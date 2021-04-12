# helper for `wt_predict_labels_ner_german_large_()`
make_wide_tbl <- function(list_input) {
  purrr::map_df(list_input, ~ {
    tidyr::pivot_wider(.x) %>%
      tidyr::unnest(cols = tidyselect::everything()) %>%
      dplyr::mutate_if(is.list, ~ purrr::map_chr(.x, as.character))
  })
}

# Load sequence tagger from flair/ner-german-large
#
# Downloads flair/ner-german-large from Hugging Face
# into the Python environment that's in use, if not already
# available. It then initializes the sequence tagger.

load_ner_german_large <- function() {

  check_and_stop_if_python_module_not_available("flair")

  import_python_module_to_globalenv(module_name = "flair")

  # download and initialize sequence tagger
  cli::cli_h1("Now loading flair/ner-german-large")
  ner_german_large_tagger <<- reticulate::py_run_string(
"
from flair.data import Sentence
from flair.models import SequenceTagger
# load tagger
ner_german_large_tagger = SequenceTagger.load('flair/ner-german-large')
"
  )
}


#' Perform NER using flair/ner-german-large
#'
#' \code{wt_predict_labels_ner_german_large} returns a tidy data frame
#' of tokens classified as named entities including probabilities.
#'
#' @param sentence A character vector with a sentence compatible with the model.
#' @seealso \url{https://huggingface.co/flair/ner-german-large} for
#' further information about this model.
#' @examples
#' \dontrun{
#' wt_load_model("ner-german-large")
#' # example sentence
#' sentence_example <- "Santesuisse und Curaviva fordern eine Umverteilung"
#' # get predictions
#' wt_predict_labels_ner_german_large(sentence = sentence_example)
#' }
#' @export
wt_predict_labels_ner_german_large <- function(sentence) {
  assertthat::assert_that(exists("ner_german_large_tagger"), msg = "Model flair/ner_german_large is not loaded. Please load using `wt_load_model()` function.")
  assertthat::assert_that(is.character(sentence), msg = "Input must be a character vector")
  assertthat::assert_that(length(sentence) == 1, msg = "Input must be single element.")

  sentence_input <- sentence

  # define sentence
  sentence <- ner_german_large_tagger$Sentence(sentence_input)
  # predict
  ner_german_large_tagger$ner_german_large_tagger$predict(all_tag_prob = "True", sentences = sentence)

  # get dictionary
  sentence_dict <- sentence$to_dict(tag_type = "ner")

  # get list of data frames
  list_of_dfs <- sentence_dict$entities %>%
    purrr::map(tibble::enframe)

  # cast to wide data frame from list of long nested dfs
  wide_tbl <- make_wide_tbl(list_of_dfs)

  clean <- wide_tbl %>%
    tidyr::separate(col = labels, into = c("label", "prob"), remove = TRUE, sep = "\\(") %>%
    mutate(
      label = stringr::str_squish(label),
      prob = as.numeric(stringr::str_remove(prob, "\\)"))
    )
  clean
}

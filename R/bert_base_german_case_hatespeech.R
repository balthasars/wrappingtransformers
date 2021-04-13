# Load sequence tagger from deepset/bert-base-german-cased-hatespeech-GermEval18Coarse
#
# Downloads deepset/bert-base-german-cased-hatespeech-GermEval18Coarse from Hugging Face
# into the Python environment that's in use, if not already
# available. It then initializes the sequence tagger.

load_bert_base_german_cased_hatespeech <- function() {

  check_and_stop_if_python_module_not_available("torch")
  check_and_stop_if_python_module_not_available("transformers")

  import_python_module_to_globalenv(module_name = "transformers")
  import_python_module_to_globalenv(module_name = "torch")

  # download and initialize sequence tagger
  cli::cli_h1("Now loading deepset/bert-base-german-cased-hatespeech-GermEval18Coarse")

  fix_parallelism_warning()

  bert_base_german_cased_hatespeech <<-  reticulate::py_run_string(
    '
from transformers import AutoTokenizer, AutoModelForSequenceClassification, pipeline
model_name = "deepset/bert-base-german-cased-hatespeech-GermEval18Coarse"
model = AutoModelForSequenceClassification.from_pretrained(model_name)
tokenizer = AutoTokenizer.from_pretrained(model_name)
nlp = pipeline("sentiment-analysis", model = model_name)
'
  )

}

#' Perform Sequence Classification using deepset/bert-base-german-cased-hatespeech-GermEval18Coarse
#'
#' \code{wt_predict_labels_ner_german_large} returns a tidy data frame
#' of tokens classified as named entities including probabilities.
#'
#' @param sentence A character vector with a sentence compatible with the model.
#' @seealso \url{https://huggingface.co/deepset/bert-base-german-cased-hatespeech-GermEval18Coarse} for
#' further information about this model.
#' @examples
#' \dontrun{
#' wt_load_model("bert-base-german-cased-hatespeech-GermEval18Coarse")
#' # example sentence
#' sentence_example <- "Der Wichser muss raus."
#' # get predictions
#' wt_predict_bert_base_german_cased_hatespeech(sentence = sentence_example)
#' }
#' @export
wt_predict_bert_base_german_cased_hatespeech <- function(sentence) {
  assertthat::assert_that(exists("bert_base_german_cased_hatespeech"), msg = "Model deepset/bert-base-german-cased-hatespeech-GermEval18Coarse is not loaded. Please load using `wt_load_model()` function.")
  assertthat::assert_that(is.character(sentence), msg = "Input must be a character vector")
  assertthat::assert_that(length(sentence) == 1, msg = "Input must be single element.")

  prediction_tbl <- bert_base_german_cased_hatespeech$nlp(sentence) %>%
    purrr::map_dfr(tibble::as_tibble)

  prediction_tbl
}

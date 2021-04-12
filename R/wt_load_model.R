#' Load one of the implemented models and initialize
#'
#' Loads one of the following models:
#' \enumerate{
#'    \item flair/ner-german-large
#'    \item deepset/bert-base-german-cased-hatespeech-GermEval18Coarse
#' }
#' @param model_name Character vector specifying the name of the model (without author) to be loaded.
#' @examples
#' \dontrun{
#' wt_load_model(model_name = "ner-german-large")
#' wt_load_model(model_name = "bert-base-german-cased-hatespeech-GermEval18Coarse")
#' }
#' @export
wt_load_model <- function(model_name) {
  assertthat::assert_that(
    length(model_name) == 1,
    msg = "Only one model can be loaded at a time"
  )
  assertthat::assert_that(
    model_name %in% supported_models,
    msg = paste(
      "model_name must be one of the following:",
      paste(supported_models,
        collapse = ", "
      )
    )
  )

  switch(model_name,
    "ner-german-large" = load_ner_german_large(),
    "bert-base-german-cased-hatespeech-GermEval18Coarse" = load_bert_base_german_cased_hatespeech()
  )
}

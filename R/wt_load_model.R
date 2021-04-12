#' Load one of the implemented models and initialize
#'
#' Loads one of the implemented models (so far only 'flair/ner-german-large') and initializes it.
#' @param model_name Character vector specifying the name of the model to be loaded.
#' @examples
#' \dontrun{
#' wt_load_model(model_name = "ner_german_large")
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
         "ner_german_large" = load_ner_german_large()
  )
}

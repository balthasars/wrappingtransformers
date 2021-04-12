#' # global reference to transformer (will be initialized in .onLoad)
#' transformers <- NULL
#'
#' .onLoad <- function(libname, pkgname) {
#'   # use superassignment to update global reference to scipy
#'   transformers <<- reticulate::import("transformers", delay_load = TRUE)
#' }
#'
#' #' Install wrappingtransformers in custom virtual environment.
#' #'
#' #' @return \code{create_wrappingtransformers_venv} sets up a virtual environment and activates it.
#' #' It will work with versions of Python >= 3.6.
#' #' The environment will be created inside ~/.virtualenvs .
#' #'
#' #' @param python_path Path to the desired Python version. If NULL, it will use the environment variable `RETICULATE_PYTHON` or Python version associated with session.
#'
#' create_wrappingtransformers_venv <- function(python_path = NULL){
#'
#'   if(is.null(python_path) & Sys.getenv("RETICULATE_PYTHON") != ""){
#'     python_path <- Sys.getenv("RETICULATE_PYTHON")
#'   }
#'
#'   # python_path <- ifelse(
#'   #   is.null(python_path),
#'   #   Sys.getenv("RETICULATE_PYTHON"),
#'   #   python_path
#'   # )
#'
#'   reticulate::virtualenv_create(
#'     envname = "wrappingtransformers",
#'     packages = c("transformers"),
#'     python = python_path
#'     )
#'
#'   reticulate::use_virtualenv("wrappingtransformers")
#' }
#'
#' #' Delete virtual environment for \code{wrappingtransformers}
#' #'
#' #' \code{remove_wrappingtransformers_venv} removes custom virtual environment created with \code{create_wrappingtransformers_venv}.
#'
#' remove_wrappingtransformers_venv <- function() {
#'   reticulate::virtualenv_remove(envname = "wrappingtransformers")
#' }

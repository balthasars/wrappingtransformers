supported_models <- c("ner_german_large")

# helper for model loading functions
check_and_stop_if_python_module_not_available <- function(module) {
  assertthat::assert_that(is.character(module), msg = "module must be character.")
  cli::cli_h1("Checking if required Python modules are available")
  if (!reticulate::py_module_available(module)) {
    cli::cli_alert_danger(text = paste0(
      module,
      " is not available in this environment. Please install using reticulate::py_install('",
      module, "', pip = TRUE)) or load appropriate Python environment."
    ))
    stop()
  } else {
    cli::cli_alert_success(paste0(
      module,
      " is available in this environment."
    ))
  }
}
# check_and_stop_if_python_module_not_available("bliblablu")

import_python_module_to_globalenv <- function(module_name){
  module <- reticulate::import(module = module_name, convert = FALSE)
  arg_name <- deparse(substitute(module_name))
  assign(x = module_name, value = module, env = .GlobalEnv) # Assign values to variable

}
# reticulate::use_python(python = "/usr/local/bin/python3.9")
# import_python_module_to_globalenv("flair")

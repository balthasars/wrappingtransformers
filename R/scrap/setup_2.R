# global reference to scipy (will be initialized in .onLoad)
# transformers <- NULL

# .onLoad <- function(libname, pkgname) {
#   reticulate::configure_environment(pkgname, force = TRUE)
#   transformers <<- reticulate::import("transformers", delay_load = TRUE)
# }


# install_transformers <- function(method = "auto", conda = "auto") {
#   reticulate::py_install("transformers", method = method, conda = conda)
# }

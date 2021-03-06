
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{wrappingtransformers}`

<!-- badges: start -->
<!-- badges: end -->

`{wrappingtransformers}` provides acess to some functions of some
pretrained NLP models shared on Hugging Face’s model community platform
through R that you’d normally access using Python.

-   Currently implemented:
    -   [`flair/ner-german-large`](https://huggingface.co/flair/ner-german-large)
        -   sequence tagger
-   Planned:
    -   [`flair/ner-german`](https://huggingface.co/flair/ner-german)
        -   sequence tagger
    -   [`deepset/bert-base-german-cased-hatespeech-GermEval18Coarse`](https://huggingface.co/deepset/bert-base-german-cased-hatespeech-GermEval18Coarse)
        -   text classification

## Basic Installation

Because `{wrappingtransformers}` has Python dependencies, the setup is a
bit more complicated than usual — you’ll have to run some extra commands
before you can use it.

If you just want to use transformers from within R, run the following
commands in R. This will create a local Python installation that will
only be used by R and install the needed Python package for you.

``` r
install.packages("reticulate")
reticulate::install_miniconda(update = TRUE) # Install Python
reticulate::py_install('transformers') # Install the Python transformers package
remotes::install_github("balthasars/wrappingtransformers") # Install this package
```

**After running these commands restart R.**

## Advanced Setup — Select the Python version to be used

Discover what version of Python will be used unless you set it manually
as suggested below. [transformers is tested with Python
3.6](https://github.com/huggingface/transformers). In my experience
&gt;= 3.9 works best.

``` r
reticulate::py_discover_config()
```

If you’re happy with what this indicates, you may skip over the
following steps.

If not, set the environmental varible `RETICULATE_PYTHON` to the desired
Python version path interactively with `usethis::edit_r_environ()` or
using `Sys.setenv()`:

``` r
Sys.setenv(RETICULATE_PYTHON = "/usr/local/bin/python3.9")
```

Alternatively you can select the Python environment using the reticulate
package:

``` r
reticulate::use_python(python = "/usr/local/bin/python3.9")
```

### Select Environment

Use `create_wrappingtransformers_venv()` to create a new environment
solely for the purpose of using this package.

This will install all required Python libraries using the version of
python indicated in the environment variable `RETICULATE_PYTHON` if you
don’t indicate it in argument `python_path`.

``` r
create_wrappingtransformers_venv(python_path = NULL)
```

If you already have a Python environment with transformers installed,
name it in the `virtualenv` argument. This will set it up for the rest
of this R session.

``` r
reticulate::use_virtualenv(virtualenv = "myenv")
```

or use Conda:

``` r
reticulate::use_condaenv(condaenv = "myenv")
```

## Using the models

### `flair/german-ner-large`

Here’s a full example on how to use the NER tagger:

``` r
reticulate::use_python(python = "/usr/local/bin/python3.9", required = TRUE)
reticulate::use_virtualenv("wrappingtransformers", required = TRUE)
wt_load_model(model_name = "ner-german-large")
sentence_example <- "Santesuisse und Curaviva fordern eine Umverteilung"
wt_predict_labels_ner_german_large(sentence = sentence_example)
```

### `deepset/bert-base-german-cased-hatespeech-GermEval18Coarse`

Here’s a full example on how to perform sequence classification:

``` r
reticulate::use_python(python = "/usr/local/bin/python3.9", required = TRUE)
reticulate::use_virtualenv(virtualenv = "wrappingtransformers", required = TRUE)
load_bert_base_german_cased_hatespeech()
sentence_example <- "Der Wichser muss raus."
wt_predict_bert_base_german_cased_hatespeech(sentence = sentence_example)
```

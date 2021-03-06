
#' Wrapper function for pretty tables
#' @description Wraps table functions to provide a single  user interface.
#' A footer can be added but this requies rows to be merged once the document
#' has been knit to word.
#' @param df A data frame to be converted to a markdown table. Optionally a vector can be passed, this will be reformatted
#' into a data frame with the vectors names used in the firt column.
#' @param col_names A character vector of replacement column names.
#' @param footer The desired footer as a character string.
#' @param cap_fun Caption function to wrap, if supplied pretty_table defaults
#'  to defining an empty caption.
#' @param label A character string of the reference label for the table
#' @param caption A character string of the required table caption.
#' @param tab_fun Table function to wrap. Supported functions are \code{\link[pander]{pander}}
#' and \code{\link[knitr]{kable}}, with \code{\link[pander]{pander}} set as the default.
#' @param ... Pass additional arguements to the wrapped table function.
#' @importFrom stats runif
#' @importFrom dplyr add_row bind_cols
#' @importFrom purrr map
#' @importFrom pander pander
#' @importFrom knitr kable
#' @return A markdown table
#' @export
#' @examples
#'
#' ## A simple table
#' pretty_table(iris[1:5, 1:5])
#'
#' ## Renaming columns
#' pretty_table(iris[1:5, 1:5], col_names = as.character(1:5))
#'
#' ## Adding a footer
#' pretty_table(iris[1:5, 1:5], footer = 'Example footer')
#'
#' ## Changing to a kable table
#' library(knitr)
#'
#' pretty_table(iris[1:5, 1:5], tab_fun = kable)
#'
#' ## Passing a named vector of values
#' pretty_table(c(b = 1, c = 2, a = 3))
#'
pretty_table <- function(df, col_names = NULL, footer = NULL,
                         cap_fun = pretty_tabref, label = NULL,
                         caption = NULL, tab_fun = pander, ...) {

  if (!is.data.frame(df) & is.vector(df)) {
    if (is.null(names(df))) {
      names(df) <- rep("", length(df))
    }
    df <- data.frame(. = names(df), .. = df, row.names = NULL)
    colnames(df) <- c("&nbsp;", "&nbsp;")
  }

  if (is.null(tab_fun)) {
    stop("Requires a table function to be set")
  }

  if (!is.null(footer)) {

    # get column name for footer location
    store_col_name <- colnames(df)[1]
    colnames(df)[1] <- "footer_loc"

    table <- df %>%
      add_row(footer_loc = footer) %>%
      map(function(x) {
        ifelse(is.na(x), "", x)
        }
        ) %>%
      bind_cols

    colnames(table)[1] <- store_col_name

  }else {
    table <- df
  }

  ## Add new column names
  if (!is.null(col_names)) {
    colnames(table) <- col_names
  }


  if (is.null(cap_fun)) {
    cap <- ""
  }else {
    ## Add dummy arguements for label and caption if not supplied
      if (is.null(label)) {
        label <- runif(1)
      }
      if (is.null(caption)) {
        caption <- ""
      }
      cap <- cap_fun(label, caption)
    }

  ## Add label and caption and make table
  tab_fun(table %>% as.data.frame, caption = cap, ...)
}

#' Reformat an estimate, with lower/upper confidence/credible intervals with an explanatory note
#' @description Takes a character vector as formated by \code{\link[prettypublisher]{pretty_ci}}
#' and adds a user specified explanatory note; to be used inline.
#' @param string A character vector as formated by \code{\link[prettypublisher]{pretty_ci}}.
#' @param note A character vector indicating the explanatory note to be used.
#' @param replace_bracket Logical, defaults to \code{TRUE}. Should the leading bracket be automatically
#' be reinserted in front of the custom note supplied by \code{note}.
#' @importFrom stringr str_replace
#' @seealso pretty_ci
#' @return An estimate with formated CI's for use inline within a document.
#' @export
#'
#' @examples
#' ## Use input from pretty_ci to generate a inline CI
#' pretty_inline_ci(pretty_ci(2,1,3))
#'
#' ## Change note i.e for 90% credible intervals
#' pretty_inline_ci(pretty_ci(2,1,3), note = '90% credible interval ')
#'
#' ## Handle vectorised input
#' est <- c(1,2,3,10)
#' lci <- c(0, -19, -209, -100)
#' uci <- c(100, 30, 40, 19)
#'
#' formated_ci <- pretty_ci(est, lci, uci, sep = '-')
#' pretty_inline_ci(formated_ci)
#'
#'## Add a note before the braket
#'pretty_inline_ci(formated_ci, note = " per 100,000 (95% CI ", replace_bracket = FALSE)
pretty_inline_ci <- function(string, note = "95% CI ", replace_bracket = TRUE) {

  if (replace_bracket) {
    note <- paste0("(", note)
  }

  string <- string %>%
              str_replace("\\(", note)

  return(string)
}

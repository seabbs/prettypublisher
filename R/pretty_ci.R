
#' Format an estimate, lower and upper confidence intervals into a single character string
#' @description Take numeric/character vectors of the estimate, and upper/lower confidence/credible
#' intervals, round with trailing zeros and format into the required journal style.
#' @param est A numeric or character vector of estimates.
#' @param lci A numeric or character vector of lower confidence/credible intervals.
#' @param uci A numeric or character vector of upper confidence/credible intervals.
#' @param string A logicial (defaults to \code{FALSE}) indicating if the estimates are being passed as a string
#' to \code{est} (formatted as est, lci, uci) or seperately to \code{est}, \code{lci} and \code{uci}. Supports  single estimates or a list/dataframe.
#' @param sep A character vector indicating the seperator used between the upper and
#' lower confidence/credible intervals. The default is ' to '.
#' @param percentage A logical (defaults to \code{FALSE}), which indicates whether the output should
#' be treated as a percentage.
#' @param inline Logical operator indicating whether an explanatory note is required.
#' @inheritParams pretty_round
#' @inheritParams pretty_inline_ci
#' @return The estimate with formated upper, and lower confidence/credible
#' intervals as a character vector.
#' @export
#' @importFrom dplyr data_frame mutate_all mutate funs
#' @import magrittr
#' @seealso  pretty_round pretty_percentage
#' @examples
#' ## Formating a single confidence interval
#' pretty_ci(2, lci = 1, uci = 3)
#'
#' ## Formating vectors of confidence intervals
#' est <- c(0, 1, 100, 300, 21221, 403)
#' lci <- c(-123, -0.2, 50, 100, 12321, 200)
#' uci <- c(10, 2, 200, 400, 30122, 500)
#'
#' pretty_ci(est, lci = lci, uci = uci, sep = '-', digits = 1)
#'
#' ## Use in a dplyr workflow
#' library(dplyr)
#'
#' x <- data_frame(est = c(0,1), lci = c(0, 2), uci = c(1, 4))
#' x <- x %>% mutate(ci = est %>% pretty_ci(lci = lci, uci = uci, sep = ' by ', digits = 0))
#'
#'## Passing values as a single string
#'est <- c(0, -1, 1)
#'pretty_ci(est, string = TRUE)
#'
#'est <- data.frame(est = c(1,2), lci = c(0, 1), uci = c(2, 3))
#'pretty_ci(est, string = TRUE)
#'
#'est <- 98
#'lci <- 96
#'uci <- 99
#'
#'pretty_ci(est, lci, uci, percentage = TRUE)
pretty_ci <- function(est, lci, uci, string = FALSE, sep = " to ", digits = 2,
                      inline = FALSE, note = "95% CI ", percentage = FALSE) {

  if (string) {
    lci <- unlist(est[2])
    uci <- unlist(est[3])
    est <- unlist(est[1])
  }

  if (percentage) {
    fill <- "%"
  }else {
    fill <- ""
  }

  df <- data_frame(est, lci, uci)

  df <- df %>%
            mutate(est = pretty_round(est, digits = digits),
                   lci = pretty_round(lci, digits = digits),
                   uci = pretty_round(uci, digits = digits)) %>%
              mutate(ci = paste0(est, fill, " (", lci, fill, sep, uci, fill, ")"))

  if (inline) {
    df$ci <-  pretty_inline_ci(df$ci, note = note)
  }


  return(df$ci)
}

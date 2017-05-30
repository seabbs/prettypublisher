
#' Format an estimate, lower and upper confidence intervals into a single character string
#' @description Take numeric/character vectors of the estimate, and upper/lower confidence/credible
#' intervals, round with trailing zeros and format into the required journal style.
#' @param est A numeric or character vector of estimates.
#' @param lci A numeric or character vector of lower confidence/credible intervals.
#' @param uci A numeric or character vector of upper confidence/credible intervals.
#' @param sep A character vector indicating the seperator used between the upper and
#' lower confidence/credible intervals. The default is ' to '.
#' @inheritParams pretty_round
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
pretty_ci <- function(est, lci, uci, sep = " to ", digits = 2) {

  df <- data_frame(est, lci, uci)

  df <- df %>%
          mutate(est = as.numeric(est),
                 lci = as.numeric(lci),
                 uci = as.numeric(uci)
                 ) %>%
            mutate(est = pretty_round(est, digits = digits),
                   lci = pretty_round(lci, digits = digits),
                   uci = pretty_round(uci, digits = digits)) %>%
              mutate(ci = paste0(est, " (", lci, sep, uci, ")"))

  return(df$ci)
}

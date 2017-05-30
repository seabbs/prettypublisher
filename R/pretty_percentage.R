
#' Calculate a percentage, and then format for publication
#' @description Take numeric vectors of numerators, and demoninators, round them,
#'  format them with trailing zeros, and return as a character string along with the original numeric values.'
#' @inheritParams pretty_round
#' @param denom A numeric vector
#' @param percent_scaling A numeric vector indicating the scaling used,
#' by default this is 100 as this gives a percentage.
#' @param as_per Logical indicating if the percentage should be deliminated by a \% symbol.
#' @seealso pretty_round pretty_ci
#' @return A character vector or string, with a percentage and
#' the numerator and denominator used to calculate it
#' @export
#'
#' @examples
#' ## Return a percentage
#' pretty_percentage(10, 500)
#'
#' ## Return a vector of percentages
#' pretty_percentage(c(1,4,6, 19), 100, digits = 1)
#'
#' ## Return a proportion
#' pretty_percentage(c(1, 2, 4, 5, 2), c(100, 40, 50, 40, 30), as_per = FALSE)
pretty_percentage <- function(num, denom, digits = 2,
                              percent_scaling = 100, as_per = TRUE, ...) {
  per <- pretty_round(num / denom * percent_scaling, digits, ...)

  if (as_per) {
    per_delim <- "% ("
  } else {
    per_delim <- " ("
  }

  per_as_char <- paste0(per, per_delim, num, "/", denom, ")")

  return(per_as_char)
}

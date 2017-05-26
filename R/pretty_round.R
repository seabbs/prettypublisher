
#' Round and format numbers; standardising trailing zeros
#'
#' @param num A numeric vector.
#' @param digits Integer indicating the number of decimal places to be used
#' @param ... Pass additional arguements to \code{\link[base]{format}}
#' @return A rounded number formatted as a character with trialing zeros
#' @export
#'
#' @examples
#' pretty_round(2.1, digits = 1)
#' pretty_round(2.1, digits = 2)
#' pretty_round(c(2.13, 2.1, 4.165, 8.2323242, 1), digits = 2)
pretty_round = function(num, digits = 2, ...) {
  num <- num %>%
    round(digits) %>%
    format(nsmall = digits, ...)
  num[] <- num %>%
    str_trim(side = 'both')

  return(num)
}

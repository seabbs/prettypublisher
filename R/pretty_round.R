
#' Round and format numeric vectors; standardising trailing zeros
#'
#' @param num A numeric vector.
#' @param digits Integer indicating the number of decimal places to be used.
#' @param ... Pass additional arguements to \code{\link[base]{format}}.
#' @return A rounded numeric vector formatted as a character vector with trialing zeros.
#' @export
#' @importFrom stringr str_trim
#' @import magrittr
#' @seealso \code{\link[base]{format}}, and \code{\link[base]{round}} for additional information
#' @examples
#' pretty_round(2.1, digits = 1)
#' pretty_round(2.1, digits = 2)
#' pretty_round(c(2.13, 2.1, 4.165, 8.2323242, 1), digits = 2)
pretty_round <- function(num, digits = 2, ...) {
  num <- num %>%
    round(digits) %>%
    format(nsmall = digits, ...)
  num[] <- num %>%
    str_trim(side = "both")

  return(num)
}

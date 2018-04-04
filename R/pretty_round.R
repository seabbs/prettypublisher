
#' Round and format numeric vectors; standardising trailing zeros
#'
#' @param num A numeric or character vector coercible to a numeric vector.
#' Empty character vectors will be returned by the function.
#' @param digits Integer indicating the number of decimal places to be used.
#' @param to_pass A character vector specifying what to pass without reformating,
#' by default this includes; NA, NaN, "Inf", "", and " ".
#' @param ... Pass additional arguements to \code{\link[base]{format}}.
#' @return A rounded numeric vector formatted as a character vector with trialing zeros.
#' @export
#' @importFrom stringr str_trim
#' @seealso \code{\link[base]{format}}, and \code{\link[base]{round}} for additional information
#' @examples
#' ## Rounding a single number
#' pretty_round(2.1, digits = 1)
#'
#' ## Rounding with trailing whitespace
#' pretty_round(2.1, digits = 2)
#'
#' ##Rounding a vector
#' pretty_round(c(2.13, 2.1, 4.165, 8.2323242, 1), digits = 2)
#'
#' ## Passed without rounding
#' pretty_round(c("", " ", "Inf", NaN, NA), digits = 2)
#'
pretty_round <- function(num, digits = 2,
                         to_pass = c("", " ", "Inf", NaN, NA), ...) {
     num <- ifelse(!num %in% to_pass,
              num %>%
                as.numeric %>%
                round(digits) %>%
                format(nsmall = digits, ...),
              num
              )
    num[] <- num %>%
      str_trim(side = "both")

  return(num)
}

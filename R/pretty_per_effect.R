

#' A Function to Convert Effect Estimates into Percentage Changes
#'
#' @description A function to convert effect estimates into percentage changes for use in line in
#' publications. It can either convert an effect estimate with lower and upper confidence intervals that
#' is unformated into a pretty formated percentage or it can convert a \code{\link[prettypublisher]{pretty_ci}}
#' formatted effect size into a pretty formated percentage.
#' @inheritParams pretty_ci
#' @param effect_direct A character string indicating the direction of the percentage.
#' Can be specified as "increase" or "decrease" (defaults to "increase").
#' @param ... Pass additional arguements to \code{\link[prettypublisher]{pretty_ci}}
#' @seealso pretty_ci
#' @return A pretty formated percentage with confidence intervals
#' @export
#' @importFrom stringr str_split
#' @importFrom stats na.omit
#' @importFrom purrr map map_chr transpose
#' @examples
#'
#' est <- 1.2
#' lci <- 1.1
#' uci <- 1.3
#'
#' ## As unformated effects
#' pretty_per_effect(est, lci, uci)
#'
#' ## As formated effects
#'
#' x <- pretty_ci(est, lci, uci, inline = TRUE)
#' pretty_per_effect(x, string = TRUE, inline = TRUE)
#'
#' ## For a decrease
#' pretty_per_effect(x, string = TRUE, inline = TRUE, effect_direct = "decrease")
#'
#' ## Vectorised (as a string)
#' est <- c(est, 1.1)
#' lci <- c(lci, 1)
#' uci <- c(uci, 1.2)
#'
#' pretty_per_effect(est, lci, uci)
pretty_per_effect <- function(est = NULL, lci = NULL, uci = NULL, string = FALSE, sep = " to ",
                              note = "95% CI ", replace_bracket = TRUE, digits = 0, inline = FALSE,
                              percentage = TRUE, effect_direct = "increase", ...) {

if (string) {
  est <- suppressWarnings(est %>%
    str_split(pattern = "\\)") %>%
    unlist %>%
    str_split(pattern = " ") %>%
    unlist %>%
    as.numeric %>%
    na.omit)
}else {
  est <- list(est, lci, uci)
}


  if (effect_direct %in% "increase") {
    adjusted_per <- map(est,  ~ . - 1)
  }else if (effect_direct %in% "decrease") {
    adjusted_per <- map(est, ~ 1 - .)
    adjusted_per <- c(adjusted_per[[1]], adjusted_per[[3]], adjusted_per[[2]])
  }else{
    stop("effect_direct must be either increase or decrease.
         This specifies the direction of the effect")
  }

  adjusted_per <- map(adjusted_per, ~ . *  100)
  adjusted_per <- transpose(adjusted_per)
  adjusted_per <- map_chr(adjusted_per, ~pretty_ci(unlist(.), string = TRUE,
                            sep = sep, note = note, replace_bracket = replace_bracket,
                            digits = digits, inline = inline,
                            percentage = percentage, ...)
  )

  return(adjusted_per)
}

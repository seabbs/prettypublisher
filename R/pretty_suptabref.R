
#' A wrapper for pretty_captioner with sensible defaults for captioning supplementary tables
#'
#' @export
#' @inherit pretty_captioner
#' @examples
#'
#'## Generate a simple reference
#'pretty_suptabref('1' , 'Example', reinit = TRUE)
#'
#'## cite in text
#'pretty_suptabref('1')
#'
#'## Drop captilisation for use in line
#'pretty_suptabref('1', inline = TRUE)
#'
#'## Add another table caption
#'pretty_suptabref('2' , 'Example 2')
#'
pretty_suptabref <- function(label = NULL, caption = NULL,
                             prefix = "Supplementary Table",
                             sec_prefix = "S", auto_space = TRUE,
                             levels = 1, type = NULL, infix = ".",
                             display = "full", inline = FALSE,
                             reinit = FALSE, ...) {

  pretty_captioner(label = label, caption = caption, prefix = prefix,
                   sec_prefix = sec_prefix, auto_space = auto_space,
                   levels = levels, type = type, infix = infix,
                   display = display, inline = inline, reinit = FALSE,
                   cap_fun_name = "suptabref", ...)
}


#' A wrapper for pretty_captioner with sensible defaults for captioning supplementary figures
#'
#' @export
#' @inherit pretty_captioner
#' @examples
#'
#'## Generate a simple reference
#'pretty_supfigref('1' , 'Example', reinit = TRUE)
#'
#'## cite in text
#'pretty_supfigref('1')
#'
#'## Drop captilisation for use in line
#'pretty_supfigref('1', inline = TRUE)
#'
#'## Add another table caption
#'pretty_supfigref('2' , 'Example 2')
#'
pretty_supfigref <- function(label = NULL, caption = NULL,
                             prefix = "Supplementary Figure",
                             sec_prefix = "S", auto_space = TRUE,
                             levels = 1, type = NULL,
                             infix = ".", display = "full",
                             inline = FALSE, reinit = FALSE, ...) {

  pretty_captioner(label = label, caption = caption, prefix = prefix,
                   sec_prefix = sec_prefix, auto_space = auto_space,
                   levels = levels, type = type, infix = infix,
                   display = display, inline = inline, reinit = FALSE,
                   cap_fun_name = "supfigref", ...)
}

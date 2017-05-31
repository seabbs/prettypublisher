
#' A wrapper for pretty_captioner with sensible defaults for captioning tables
#'
#' @seealso pretty_captioner pretty_suptabref pretty_figref pretty_supfigref
#' @export
#' @inherit pretty_captioner
#' @examples
#'
#'## Generate a simple reference
#'pretty_tabref('1' , 'Example', reinit = TRUE)
#'
#'## cite in text
#'pretty_tabref('1')
#'
#'## Drop captilisation for use in line
#'pretty_tabref('1', inline = TRUE)
#'
#'## Add another table caption
#'pretty_tabref('2' , 'Example 2')
#'
pretty_tabref <- function(label = NULL, caption = NULL, prefix = "Table",
                          sec_prefix = NULL, auto_space = TRUE, levels = 1,
                          type = NULL, infix = ".", display = "full",
                          inline = FALSE, reinit = FALSE, ...) {

  pretty_captioner(label = label, caption = caption, prefix = prefix,
                               sec_prefix = sec_prefix, auto_space = auto_space, levels = levels,
                               type = type, infix = infix, display = display,
                               inline = inline, reinit = reinit,
                               cap_fun_name = "tabref", ...)
}

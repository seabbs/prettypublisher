
#' A wrapper for the captioner function
#'
#' @description A wrapper for the \code{\link[captioner]{captioner}} function. This provides captioning functionality via \code{\link[captioner]{captioner}}
#'in word, html, and pdf. The wrapper can be used without initialisation, adds a secondary prefix, and an optional inline arguement.
#' It works by intialising a second \code{\link[captioner]{captioner}} function which can then be called within the main function.
#' Best practise is to set reinit = TRUE on first using the funciton.
#' @details As a wrapper for the \code{\link[captioner]{captioner}} function \code{\link[prettypublisher]{pretty_captioner}} intialises a
#' \code{\link[captioner]{captioner}} function in the global enviroment. This is then used by pretty_captioner
#' to return a character string containing the prefix, sec_prefix, and object number with or without a caption.
#' The initial numbering is determined based on the order of caption creation. However, this order is modified based on the citations you use.
#' The first object to be cited will be moved to the beginning of the list, becoming object 1. Changing captioner parameters (prefix, sec_prefix,
#' auto_space, levels, type, and infix) requires the captioner function to be reinitialised by setting reinit to TRUE. The captioner function
#' can also be initialised without reference to an object by not supplying a label or caption argument.
#' For more details see \code{\link[captioner]{captioner}}.
#' @param label Character string containing a unique object name.
#' @param caption Character string containing the object caption.
#' @param sec_prefix Character string containing text to between prefix and object number.
#' The default is to add nothing.
#' @param cap_fun_name A character string indicating the name to assign to the underlying captioner function.
#' @param display Character string (logical) indicating what display mode you would like:
#' full (or f) displays all information, cite (or c) displays just the prefix and number,
#' and num (or n) displays just the number.
#' @param inline Logical indicating whether the function should display the prefix uncapitalised/capitalised.
#' @param reinit Logical indicating whether to reinitialise the underlying captioner function.
#' @param ... Pass additional arguements to the intialised \code{\link[captioner]{captioner}} function
#' @seealso  \code{\link[prettypublisher]{prettypublisher}} has a group of related functions which use various defaults: \code{\link[prettypublisher]{pretty_captioner}},
#'  \code{\link[prettypublisher]{pretty_figref}}, \code{\link[prettypublisher]{pretty_supfigref}}, \code{\link[prettypublisher]{pretty_tabref}},
#'  and \code{\link[prettypublisher]{pretty_suptabref}}.
#' @importFrom captioner captioner
#' @importFrom stringr str_replace
#' @inherit captioner::captioner
#' @return A character string containing the table/figure number, and optionally the caption.
#' @export
#'
#' @examples
#' ## First call to pretty_captioner intialising the captioner function
#' pretty_captioner('1', 'Example caption', reinit = TRUE)
#'
#' ## Second call
#' pretty_captioner('2', 'Example caption 2')
#'
#' ## Displaying the cite information only for use inline
#' pretty_captioner('2', display = 'c', inline = TRUE)
#'
#' ## Reference in text without a caption
#' pretty_captioner('3')
#'
#' ##Changing the prefix, adding a sec_prefix and reinitialising
#' pretty_captioner('1', 'Example caption 1', prefix = 'Table', sec_prefix = 'S', reinit = TRUE)
#'
pretty_captioner <- function(label = NULL, caption = NULL, prefix = "Figure",
                             sec_prefix = NULL, auto_space = TRUE, levels = 1,
                             type = NULL, infix = ".", display = "full",
                             inline = FALSE, reinit = FALSE,
                             cap_fun_name = "pretty_cap.cap", ...) {
  if (is.null(caption)) {
    caption <- ""
    display <- "c"
  }

  if (exists(cap_fun_name) & !reinit) {
    if (sum(grepl("captioner", class(get(cap_fun_name)))) == 0) {
      stop(cap_fun_name,
           " does not have the class captioner and may have been
           altered elsewhere")
    }


  }

  if (!exists(cap_fun_name) | reinit) {
    message("Initialising captioning function: ", cap_fun_name)

    if (auto_space) {
      com_prefix <- paste0(prefix, " ")
    }

    if (!is.null(sec_prefix)) {
      com_prefix <- paste0(com_prefix, sec_prefix)
    }

    cap <- captioner(prefix = com_prefix,
                     auto_space = FALSE,
                     levels = levels,
                     type = type,
                     infix = infix)

    class(cap) <- c(class(cap), "captioner")

    assign(cap_fun_name, cap, envir = globalenv())
  }

  if (!is.null(label) & !is.null(caption)) {
    cap <- get(cap_fun_name)

    if (inline) {
      display <- "c"
    }

    current_cap <- cap(name = label, caption = caption, display = display, ...)

    if (inline) {
      current_cap <- str_replace(current_cap, prefix, tolower(prefix))
    }

    return(current_cap)
  } else{
    message("No caption generated. Interactive use of pretty_captioner requires
at least a label to be specifed.")
  }

}

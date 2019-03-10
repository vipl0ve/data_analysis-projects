# install packages from CRAN
p_needed <- c("rvest", "devtools", "RSelenium", "twitteR", "streamR")
packages <- rownames(installed.packages())
p_to_install <- p_needed[!(p_needed %in% packages)]
if (length(p_to_install) > 0) {
  install.packages(p_to_install)
}

lapply(p_needed, require, character.only = TRUE)
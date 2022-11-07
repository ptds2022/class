library(rvest)
url <- "https://en.wikipedia.org/wiki/Normal_distribution"

html_page <- read_html(url)

tables <- html_page %>% html_table()
tables <- html_page %>% html_nodes("dl + p + table") %>% html_table()
tables[[1]]

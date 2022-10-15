library(quantmod)
library(rvest)
sp500 <- read_html("https://en.wikipedia.org/wiki/List_of_S%26P_500_companies")

sp500 %>%
  html_nodes(".text") %>% # "td:nth-child(1) .text" should be used instead
  html_text() -> ticker_sp500

SP500_symbol <- ticker_sp500[seq_len(500) * 2 - 1]

# Replace "." by "-"
SP500_symbol <- gsub(".","-",SP500_symbol,fixed=T)

# Specify timing
tot_length <- 3 * 365 
today <- Sys.Date()
seq_three_years <- seq(today,by=-1,length.out=tot_length)
three_year_ago <- seq_three_years[tot_length]

# Retrieve data for a stock
i <- 1
getSymbols(SP500_symbol[i],from=three_year_ago,to=today)
stock_price <- ClCl(get(SP500_symbol[i]))

stocks <- matrix(nr=length(seq_three_years),nc=500)
rownames(stocks) <- seq_three_years
colnames(stocks) <- SP500_symbol
for(i in seq_len(500)){
  getSymbols(SP500_symbol[i],from=three_year_ago,to=today)
  stock_price <- ClCl(get(SP500_symbol[i]))
  index <- rownames(stocks) %in% as.numeric(time(stock_price))
  stocks[index,i] <- stock_price
  print(i)
}

rownames(stocks) <- as.character(seq_three_years)
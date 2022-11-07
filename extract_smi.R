library(quantmod)
library(rvest)
smi <- read_html("https://en.wikipedia.org/wiki/Swiss_Market_Index")

smi_table <- smi %>% html_nodes("p + p + table") %>% html_table() %>% .[[1]]
smi_ticker <- smi_table$Ticker
smi_ticker <- paste0(smi_ticker, ".SW")

# Specify timing
tot_length <- 5 * 365 
today <- Sys.Date()
seq_five_years <- seq(today,by=-1,length.out=tot_length)
five_year_ago <- seq_five_years[tot_length]

# Retrieve data for a stock
i <- 1
getSymbols(smi_ticker[i],from=five_year_ago,to=today)
stock_price <- ClCl(get(smi_ticker[i]))

stocks <- matrix(nr=length(seq_five_years),nc=length(smi_ticker))
rownames(stocks) <- seq_five_years
colnames(stocks) <- smi_ticker
for(i in seq_along(smi_ticker)){
  getSymbols(smi_ticker[i],from=five_year_ago,to=today)
  stock_price <- ClCl(get(smi_ticker[i]))
  index <- rownames(stocks) %in% as.numeric(time(stock_price))
  stocks[index,i] <- stock_price
  print(i)
}

rownames(stocks) <- as.character(seq_five_years)

library(xts)
library(quantmod)

get_stock_data = function() {
  s = c("AAPL", "CVX", "DAL", "GM", "GS", 
        "JPM", "LUV", "MSFT", "SPY", "TSLA", 
        "XOM")
  p = lapply(s, function(s_) getSymbols(s_, from = "2010-11-18",
                                        auto.assign = FALSE, 
                                        src = "yahoo")[, 6])
  p = data.frame(p)
  names(p) = s
  
  # daily returns
  r = ROC(as.xts(p))
  
  r[complete.cases(r)]
}

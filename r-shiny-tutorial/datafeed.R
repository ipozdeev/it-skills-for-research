library(xts)

get_stock_data = function() {
  # load daily returns from .csv
  res = read.csv.zoo("../data/return_data.csv")
  return(res)
}

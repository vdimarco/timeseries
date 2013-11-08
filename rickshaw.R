#get date in format that rickshaw likes
sp500.df$date <- as.double(as.POSIXct(as.Date(sp500.df$date),origin="1970-01-01"))
r1 <- Rickshaw$new()
r1$layer(
  sp500 ~ date,
  data = sp500.df,
  type = "line"
)
r1$set( 
  slider = TRUE
)
r1$print("chart3")
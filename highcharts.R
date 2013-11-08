#get in UTC format that works best with Highcharts
sp500.df$date <- as.numeric(
  as.POSIXct(sp500.df$date, origin="1970-01-01")
) * 1000

h1 <- hPlot(
  sp500 ~ date,
  data = sp500.df,
  type = "line"
)

h1$xAxis(type = "datetime")
h1$chart(zoomType = "x")

h1$plotOptions(
  line = list(
    marker = list(enabled = F)
  )
)

h1$print("chart5")
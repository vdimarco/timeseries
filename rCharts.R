# 2013 the world changes with rCharts

# define a function to convert xts wide to long data.frame
xtsMelt <- function(xtsData,metric){
  df <- data.frame(index(xtsData),coredata(xtsData),stringsAsFactors=FALSE)
  df.melt <- melt(df,id.vars=1)
  df.melt <- data.frame(df.melt,rep(metric,NROW(df.melt)))
  #little unnecessary housekeeping
  df.melt <- df.melt[,c(1,2,4,3)]
  colnames(df.melt) <- c("date","indexname","metric","value")
  df.melt$date <- as.Date(df.melt$date)
  #javascript works better when there are no .
  #remove troublesome . using modified method from Stack Overflow
  i <- sapply(df.melt, is.factor)
  df.melt[i] <- lapply(df.melt[i], gsub, pattern="\\.", replacement="")
  
  return(df.melt)
}

sp500.melt <- xtsMelt(
  sp500.monthly,
  metric = "price"
)

n1 <- nPlot(
  value~date,
  data = sp500.melt,
  group = "indexname",  # even though only one series need to specify group
  type = "lineWithFocusChart"
)

n1$xAxis(
  tickFormat=
    "#!function(d) {return d3.time.format('%b %Y')(new Date( d ));}!#"
)

n1$x2Axis(
  tickFormat=
    "#!function(d) {return d3.time.format('%Y')(new Date( d ));}!#"
)
n1$print("chart1")
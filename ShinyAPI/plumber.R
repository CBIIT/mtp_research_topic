# plumber.R
library(plotly)

# For cross domain
#* @filter cors
cors <- function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  plumber::forward()
}



#* Plot out data from the iris dataset
#* @param spec If provided, filter the data to only this species (e.g. 'setosa')
#* @get /plot
#* @serializer svg
function(spec){
  myData <- iris
  title <- "All Species"
  
  # Filter if the species was specified
  if (!missing(spec)){
    title <- paste0("Only the '", spec, "' Species")
    myData <- subset(iris, Species == spec)
  }
  
  plot(myData$Sepal.Length, myData$Petal.Length,
       main=title, xlab="Sepal Length", ylab="Petal Length")
}


#* Plot out data from the iris dataset
#* @param spec If provided, filter the data to only this species (e.g. 'setosa')
#* @get /plot3
#* @serializer svg
function(){
 
  x <- c(1:100)
  random_y <- rnorm(100, mean = 0)
  data <- data.frame(x, random_y)

  fig <- plot_ly(data, x = ~x, y = ~random_y, type = 'scatter', mode = 'lines')

  fig
}

device_size <- function() {
  h_ <- 7
  w_ <- 7
  list(
    h = function() h_,
    w = function() w_,
    set_h = function(h) if (!is.null(h)) {h_ <<- as.numeric(h)},
    set_w = function(w) if (!is.null(w)) {w_ <<- as.numeric(w)}
  )
}

output_size <- device_size()

serializer_dynamic_svg <- function(..., type = "image/svg+xml") {
  serializer_device(
    type = type,
    dev_on = function(filename) {
      grDevices::svg(filename,
                     width = output_size$w(),
                     height = output_size$h())
    }
  )
}
register_serializer("svg", serializer_dynamic_svg)

#* @filter dynamic_size
function(req) {
  if (req$PATH_INFO == "/plot") {
    output_size$set_w(req$args$width)
    output_size$set_h(req$args$height)
  }
  plumber::forward()
}

#* @get /plot2
#* @param width
#* @param height
#* @serializer svg
function() {
  plot(iris)
}

library(ggplot2)
library(plotly)

#* @apiTitle HTML widgets API

#* Return interactive plot using plotly
#* @serializer htmlwidget
#* @get /plotly
function() {
  p <- ggplot(data = diamonds,
              aes(x = cut, fill = clarity)) +
    geom_bar(position = "dodge")

  ggplotly(p)
}
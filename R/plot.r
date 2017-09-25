#' @inheritParams fortify
#'
#' @importFrom ggplot2 fortify
#' @export
fortify.fasster <- function(model, data=NULL, ...) {
  modTrigPlotData <- cbind(model$states, model$x, model$fitted)
  colnames(modTrigPlotData) <- c(colnames(model$model$FF), "Data", "Fitted")
  return(modTrigPlotData)
}

#' @inheritParams autoplot
#'
#' @importFrom ggplot2 autoplot facet_grid
#' @export
autoplot.fasster <- function(object, facet=FALSE, ...) {
  modTrigPlotData <- ts(ggplot2::fortify(object))
  if (facet) {
    autoplot(modTrigPlotData, facets = TRUE, ...)
  }
  autoplot(modTrigPlotData, ...) + facet_grid(as.numeric(series %in% c("Data", "Fitted")) ~ .)
}

#' @export
ggfitted <- function(object, ...){
  ts(fortify(object)[,c("Data", "Fitted")]) %>% autoplot
}

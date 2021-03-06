##' @name calc_metrics
##' @title calc_metrics
##' @export
##' @param model.calc
##' @param obvs.calc
##' @param var
##' @param metrics
##' @param bm
##' @param ensemble.id
##' @param model_run
##' 
##' 
##' @author Betsy Cowdery
calc_metrics <- function(model.calc, obvs.calc, var, metrics, bm, ensemble.id, model_run) {
  
  dat <- align_data(model.calc, obvs.calc, var, align_method = "mean_over_larger_timestep")
  
  # Make sure that anything that comes through align.data as NA doesn't get included. This is because there may be missing data. We may not want to do this automatically but rather have this as an option. 
  # dat <- dat[apply(dat,1, function(x) all(!is.na(x))),]
  
  results <- as.data.frame(matrix(NA, nrow = length(metrics$name), ncol = 3))
  colnames(results) <- c("metric", "variable", "score")
  results$metric <- metrics$name
  
  metric_dat <- dat[, c(paste(var, c("m", "o"), sep = "."), "posix")]
  colnames(metric_dat) <- c("model", "obvs", "time")
  
  for (m in seq_along(metrics$name)) {
    
    fcn <- paste0("metric_", metrics$name[m])
    results[m,"metric"] <- metrics$name[m]
    results[m,"variable"] <- var
    
    if (tail(unlist(strsplit(fcn, "_")), 1) == "plot") {
      filename <- file.path(dirname(dirname(model_run)), 
                            paste("benchmark", metrics$name[m], var, ensemble.id, "pdf", sep = "."))
      do.call(fcn, args <- list(metric_dat, var, filename))
      results[m,"score"] <- filename
    } else {
      results[m,"score"] <- as.character(do.call(fcn, args <- list(metric_dat, var)))
    }
    
  }  #end loop over metrics

  return(list(benchmarks = results, dat = dat))
} # calc_metrics

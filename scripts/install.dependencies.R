#!/usr/bin/env Rscript
#-------------------------------------------------------------------------------
# Copyright (c) 2012 University of Illinois, NCSA.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the 
# University of Illinois/NCSA Open Source License
# which accompanies this distribution, and is available at
# http://opensource.ncsa.illinois.edu/license.html
#-------------------------------------------------------------------------------

# install graph for MCMCpack for allometry module
if (!("graph" %in% installed.packages()[, "Package"])) {
  source("http://bioconductor.org/biocLite.R")
  biocLite("graph")
}

# install Rgraphviz for MCMCpack for allometry module
if (!("Rgraphviz" %in% installed.packages()[, "Package"])) {
  source("http://bioconductor.org/biocLite.R")
  biocLite("Rgraphviz")
}

# install packages needed from CRAN
list.of.packages <- c("BayesianTools","data.table", "doSNOW", "dplR", "earth", 
                      "emulator", "ggmap", "ggplot2", "gridExtra", "Hmisc", "httr", "kernlab", 
                      "GPfit", "knitr", "Maeswrap", "MASS", "MCMCpack", "mvtnorm",
                      "plotrix", "raster", "randtoolbox", "rjags", "rgdal", "tgp", "DBI", 
                      "roxygen2", "boot", "RNCEP", "foreign", 
                      "RCurl", "RPostgreSQL", "rPython", "minpack.lm", "mclust", 
                      "geonames", "Rcpp", "devtools", "inline", "segmented", "msm", "dplyr", 
                      "shiny", "scales", "maps", "sp")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]
if (length(new.packages)) {
  print("installing : ")
  print(new.packages)
  install.packages(new.packages, repos = "http://cran.rstudio.com/")
  
  warning("If Maeswrap Package download fails, please refer to PEcAn documentation for download instructions")
}

# install packages from forge
if (!("REddyProc" %in% installed.packages()[, "Package"])) {
  install.packages("REddyProc", repos = "http://R-Forge.R-project.org", type = "source")
}

# install packages from github
if (!("BioCro" %in% installed.packages()[, "Package"])) {
  devtools::install_github("ebimodeling/biocro")
}


# install rhdf5 from bioconductor for met2model.ED
if (!("rhdf5" %in% installed.packages()[, "Package"])) {
  source("http://bioconductor.org/biocLite.R")
  biocLite("rhdf5")
}

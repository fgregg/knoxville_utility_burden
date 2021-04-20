options(warn=2)
load.lib<-c("rmarkdown", "knitr", "tidyverse", "tidycensus", "srvyr", "lwgeom")
install.lib<-load.lib[!load.lib %in% installed.packages()]
for (lib in install.lib) install.packages(lib,dependencies=TRUE,repos="http://cran.us.r-project.org")
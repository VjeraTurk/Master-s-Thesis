lib <- .libPaths()[1]
lib_loc<- "/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5" #won't include all packages


to_install <- unname(installed.packages(lib.loc = lib_loc)[, "Package"])

install.packages(to_install)
"
install.packages( 
  lib  = lib,
  pkgs = as.data.frame(installed.packages(lib), stringsAsFactors=FALSE)$Package,
  type = 'source'
)
"

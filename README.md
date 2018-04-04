
prettypublisher
===============

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/prettypublisher)](https://cran.r-project.org/package=prettypublisher) [![Build Status](https://travis-ci.org/seabbs/prettypublisher.svg?branch=master)](https://travis-ci.org/seabbs/prettypublisher) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/seabbs/prettypublisher?branch=master&svg=true)](https://ci.appveyor.com/project/seabbs/prettypublisher) [![codecov](https://codecov.io/gh/seabbs/prettypublisher/branch/master/graph/badge.svg)](https://codecov.io/gh/seabbs/prettypublisher)

prettypublisher is an R package that aims to improve your workflow by allowing an easier transition from literate code to a paper draft ready for journal submission.

Installation
------------

You can install prettypublisher from github with:

``` r
# install.packages("devtools")
devtools::install_github("seabbs/prettypublisher")
```

Docker Development Enviroment
-----------------------------

This package has been developed in docker based on the `rocker/tidyverse` image, to access the development environment enter the following at the command line (with an active docker daemon running),

``` bash
docker pull seabbs/prettypublisher
docker run -d -p 8787:8787 -e USER=prettypublisher -e PASSWORD=prettypublisher --name prettypublisher seabbs/prettypublisher
```

The rstudio client can be accessed on port `8787` at `localhost` (or your machines ip). The default username is prettypublisher and the default password is prettypublisher.

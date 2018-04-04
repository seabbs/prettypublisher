
prettypublisher
===============

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/prettypublisher)](https://cran.r-project.org/package=prettypublisher) [![Build Status](https://travis-ci.org/seabbs/prettypublisher.svg?branch=master)](https://travis-ci.org/seabbs/prettypublisher) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/seabbs/prettypublisher?branch=master&svg=true)](https://ci.appveyor.com/project/seabbs/prettypublisher) [![codecov](https://codecov.io/gh/seabbs/prettypublisher/branch/master/graph/badge.svg)](https://codecov.io/gh/seabbs/prettypublisher)

`prettypublisher` is an R package that aims to improve your workflow by allowing an easier transition from literate code to a paper draft ready for journal submission. The core functionality is a set of functions that aim to speed up the reporting of descriptive statistics and effect estimates. It also wraps the [captioner](https://github.com/adletaw/captioner) package for figure and table referencing, although you may want to use the functionality provided by [bookdown](https://bookdown.org/yihui/blogdown/). Finally a simple interface is provided for both `pander::pandoc.table` and `knitr::kable`, with some additional features to speed up post production table editing in word, although hopefully this functionality will become redundant as packages provide improved table functionality in word.

Installation
------------

You can install prettypublisher from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("seabbs/prettypublisher")
```

At this time there are no plans to publish `prettypublisher` to CRAN as some package functionality (for example `pretty_captioner`) adds a captioning function to the users workspace, which is not allowed by CRAN.

Quick start.
------------

Whilst examples are provided for each function (see [here](https://www.samabbott.co.uk/prettypublisher/reference/index.html) for a list of functions included in the package) the following example, using the `iris` data-set, outlines some of the functionality the package provides.

Load the `dplyr` for data manipulation, `knitr` for tables, `broom` for model manipulation and `prettypublisher`.

``` r
library(prettypublisher)
library(dplyr)
library(knitr)
library(broom) 
```

Show the first several rows of the data.

``` r
head(iris)
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 1          5.1         3.5          1.4         0.2  setosa
#> 2          4.9         3.0          1.4         0.2  setosa
#> 3          4.7         3.2          1.3         0.2  setosa
#> 4          4.6         3.1          1.5         0.2  setosa
#> 5          5.0         3.6          1.4         0.2  setosa
#> 6          5.4         3.9          1.7         0.4  setosa
```

Add some summary statistics for the number of species, make into a table, and add a caption with a reference (table 1).

``` r
iris %>% 
  count(Species) %>% 
  add_count(wt = n) %>% 
  group_by(Species) %>% 
  mutate(per_species = pretty_percentage(n, nn, digits = 1)) %>% 
  select(-nn) %>% 
  pretty_table(label = "per-species",
               col_names = c("Species", "Number of samples", "Proportion of total (%)"),
               caption = "Breakdown of the number of samples per Species in the iris data-set",
               tab_fun = kable)
```

| Species    |  Number of samples| Proportion of total (%) |
|:-----------|------------------:|:------------------------|
| setosa     |                 50| 33.3% (50/150)          |
| versicolor |                 50| 33.3% (50/150)          |
| virginica  |                 50| 33.3% (50/150)          |

Estimate the association between Species (limiting the data to `setosa` and `versicolor`) and sepal length using logistic regression.

``` r
iris_model <- glm(Species ~ Sepal.Length, 
                  data = filter(iris, Species %in% c("setosa", "versicolor")),
                  family = binomial("logit"),
                  na.action = na.exclude)

or_df <- iris_model %>% 
  tidy(conf.int = TRUE, 
       conf.level = 0.95,
       exponentiate = TRUE) %>% 
  mutate(or = pretty_ci(estimate, conf.low, conf.high)) %>%
  mutate(per_effect = pretty_per_effect(estimate, conf.low, conf.high)) %>% 
  mutate(p_value = format(p.value, digits = 3, scientific = TRUE)) %>% 
  select(term, or, per_effect, p_value) %>% 
  slice(-1) 

or_df %>% 
  pretty_table(label = "glm",
               caption = "Results table for the association between Species and Sepal length.",
               col_names = c("Variable", "OR", "Percentage Effect (%)", "P value"))
```

<table style="width:100%;">
<caption>Table 2: Results table for the association between Species and Sepal length.</caption>
<colgroup>
<col width="18%" />
<col width="34%" />
<col width="34%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Variable</th>
<th align="center">OR</th>
<th align="center">Percentage Effect (%)</th>
<th align="center">P value</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Sepal.Length</td>
<td align="center">170.77 (30.62 to 1661.55)</td>
<td align="center">16977% (2962% to 166055%)</td>
<td align="center">3.28e-07</td>
</tr>
</tbody>
</table>

Table 2 shows commonly reported summary statistics for logistic regressions. For use in line we can also add additional information as follows;

``` r
pretty_inline_ci(or_df$or)
#> [1] "170.77 (95% CI 30.62 to 1661.55)"
```

Additional Features
-------------------

This package is a work in progress, although the core features and arguements will remain fixed. Additional functions will be added as I find that they are required in my academic work. If there are functions that fit the package aims, that you use regularly when formatting analysis, then please consider adding them to the package via a pull request.

Docker Development Enviroment
-----------------------------

This package has been developed in docker based on the `rocker/tidyverse` image, to access the development environment enter the following at the command line (with an active docker daemon running),

``` bash
docker pull seabbs/prettypublisher
docker run -d -p 8787:8787 -e USER=prettypublisher -e PASSWORD=prettypublisher --name prettypublisher seabbs/prettypublisher
```

The rstudio client can be accessed on port `8787` at `localhost` (or your machines ip). The default username is prettypublisher and the default password is prettypublisher.

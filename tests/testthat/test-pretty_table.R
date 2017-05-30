context('pretty_table')

test_that("pretty_table output matches that from pander", {
  df <- iris[1, 1:2]
  expect_equal(kable(df), pretty_table(df, tab_fun = kable))
})


test_that("pretty_table adds footer for kable function", {
  df <- iris[1, 1:2]
  expect_out <- c('|Sepal.Length   |Sepal.Width |',
                  '|:--------------|:-----------|',
                  '|5.1            |3.5         |',
                  '|Example footer |            |')

  expect_equal(expect_out,
               as.character(pretty_table(df,
                                         footer = 'Example footer',
                                         tab_fun = kable)))
})


test_that('pretty table changes column names', {
  df <- iris[1, 1:2]
  expect_out <- c("|   1|   2|", "|---:|---:|", "| 5.1| 3.5|")

  expect_equal(expect_out,
               as.character(pretty_table(df,
                                         col_names = as.character(1:2),
                                         tab_fun = kable)))
})

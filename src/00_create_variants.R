# Use Overflow Dark as template
# Sources:
# Code: https://github.com/StackExchange/Stacks/blob/v2.7.5/lib/components/code-block/code-block.less
# Colors: https://github.com/StackExchange/Stacks/blob/v2.7.5/lib/exports/color-sets.less

library(tidyverse)



# Create db

tb <- tibble(colnames = c(
  "highlight-addition", "highlight-attribute", "highlight-bg",
  "highlight-color", "highlight-comment", "highlight-deletion",
  "highlight-keyword", "highlight-literal", "highlight-namespace",
  "highlight-punctuation", "highlight-symbol", "highlight-variable",
  "selection"
))


tb$SO_Dark <- c(
  "#9CDEBC", "#90C4F9", "#1D1B1B", "#FFFFFF", "#999999", "#FCC5C5", "#90C4F9",
  "#FB9D51", "#FB9D51", "#CCCCCC", "#DF9FD9", "#B6BE6A", "#4E4B4B"
) |>
  toupper()


tb$SO_Light <- c(
  "#0E6235", "#015493", "#F6F6F6", "#0C0D0E", "#666F78", "#9C2121", "#015493",
  "#B75301", "#B75301", "#3B4045", "#803378", "#567A0D", "#E6E6E6"
) |>
  toupper()

tb$SO_Dark_HC <- c(
  "#E6F4ED", "#C3E0EF", "#1A1A1A", "#FFFFFF", "#FCFCFC", "#FCE9E9", "#C3E0EF",
  "#FCC36E", "#FCC36E", "#FCFCFC", "#E8CAE6", "#EFF1AC", "#4C4C4C"
) |>
  toupper()


tb$SO_Light_HC <- c(
  "#0A4324", "#004AB2", "#F6F6F6", "#0C0C0E", "#4E545A", "#9C2121", "#004AB2",
  "#992C05", "#992C05", "#3B4045", "#732B68", "#315C00", "#E6E6E6"
) |>
  toupper()






# Iterator

ncols <- seq_len(nrow(tb))

# 1. tmTheme distros ----

## Templates based on overflow.dark -----
input_tm <- "dist/tmtheme/Overflow Dark.tmTheme"
tm_lines <- readLines(input_tm)

### Dark HC ----

new_tm <- tm_lines

for (c in ncols) {
  new_tm <- gsub(tb$SO_Dark[c],
    tb$SO_Dark_HC[c], new_tm,
    ignore.case = TRUE
  )
}

# Rename and output
new_tm <- gsub(
  "dark.overflow_dark",
  "dark.overflow_hc_dark", new_tm
)

new_tm <- gsub("Overflow Dark", "Overflow Dark High Contrast", new_tm)

output_f <- gsub("Overflow Dark", "Overflow Dark High Contrast", input_tm)

writeLines(new_tm, output_f)



# Create also a new R script
input_r <- "./src/01_overflow.dark_guis.R"
r_lines <- readLines(input_r)
new_r <- gsub("Overflow Dark", "Overflow Dark High Contrast", r_lines)

output_r <- "./src/01_overflow.hc.dark_guis.R"



writeLines(new_r, output_r)



### Light ----

new_tm <- tm_lines

for (c in ncols) {
  new_tm <- gsub(tb$SO_Dark[c],
    tb$SO_Light[c], new_tm,
    ignore.case = TRUE
  )
}

# Rename and output
new_tm <- gsub(
  "dark.overflow_dark",
  "light.overflow_light", new_tm
)
new_tm <- gsub("Overflow Dark", "Overflow Light", new_tm)

output_f <- gsub("Overflow Dark", "Overflow Light", input_tm)



writeLines(new_tm, output_f)


# Create also a new R script
r_lines <- readLines(input_r)
new_r <- gsub("Overflow Dark", "Overflow Light", r_lines)

output_r <- "./src/01_overflow.light_guis.R"

writeLines(new_r, output_r)


### Light HC ----

new_tm <- tm_lines

for (c in ncols) {
  new_tm <- gsub(tb$SO_Dark[c],
    tb$SO_Light_HC[c], new_tm,
    ignore.case = TRUE
  )
}

# Rename and output
new_tm <- gsub(
  "dark.overflow_dark",
  "light.overflow_hc_light", new_tm
)
new_tm <- gsub("Overflow Dark", "Overflow Light High Contrast", new_tm)

output_f <- gsub("Overflow Dark", "Overflow Light High Contrast", input_tm)



writeLines(new_tm, output_f)


# Create also a new R script
r_lines <- readLines(input_r)
new_r <- gsub("Overflow Dark", "Overflow Light High Contrast", r_lines)

output_r <- "./src/01_overflow.hc.light_guis.R"

writeLines(new_r, output_r)




# 2. CSS variants ----


## Templates based on overflow.dark -----

css_templates <- list.files("./src/themes/", "_overflow.dark_",
  full.names = TRUE
)


### Dark HC ----

for (this_template in css_templates) {
  css_lines <- readLines(this_template)
  new_css <- css_lines

  for (c in ncols) {
    new_css <- gsub(tb$SO_Dark[c],
      tb$SO_Dark_HC[c], new_css,
      ignore.case = TRUE
    )
  }

  # Rename and output
  new_css <- gsub("overflow.dark", "overflow.hc.dark", new_css)

  output_f <- gsub("overflow.dark", "overflow.hc.dark", this_template)


  writeLines(new_css, output_f)
}


### Light ----

for (this_template in css_templates) {
  css_lines <- readLines(this_template)
  new_css <- css_lines

  for (c in ncols) {
    new_css <- gsub(tb$SO_Dark[c],
      tb$SO_Light[c], new_css,
      ignore.case = TRUE
    )
  }

  # Rename and output
  new_css <- gsub("overflow.dark", "overflow.light", new_css)

  output_f <- gsub("overflow.dark", "overflow.light", this_template)


  writeLines(new_css, output_f)
}

### Light HC ----

for (this_template in css_templates) {
  css_lines <- readLines(this_template)
  new_css <- css_lines

  for (c in ncols) {
    new_css <- gsub(tb$SO_Dark[c],
      tb$SO_Light_HC[c], new_css,
      ignore.case = TRUE
    )
  }

  # Rename and output
  new_css <- gsub("overflow.dark", "overflow.hc.light", new_css)

  output_f <- gsub("overflow.dark", "overflow.hc.light", this_template)


  writeLines(new_css, output_f)
}

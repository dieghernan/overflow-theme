# Create vscode (json) and RStudio (rstheme) variants using tmTheme as base

library(tidyverse)
library(jsonlite)
tminput <- "./dist/tmtheme/Overflow Light High Contrast.tmTheme"

source("src/functions.R")

# VScode -----
output <- basename(tminput) %>%
  str_replace_all(".tmTheme", "-color-theme.json") %>%
  str_replace_all(" ", "-") %>%
  file.path("dist", "vscode", "themes", .) |>
  tolower()

output

tmtheme2vscode(tminput, output)



# js - high contrast mode

the_js <- read_json(output)

# And get type of theme here
them_type <- the_js$type

if (grepl("High Contrast", tminput)) {
  them_type <- case_when(
    them_type == "dark" ~ "hc-black",
    TRUE ~ "hc-light"
  )

  the_js$type <- them_type
}


message(basename(tminput), " is ", them_type)


the_js |>
  write_json(path = output, auto_unbox = TRUE, pretty = TRUE)


# RStudio Theme ----

# Create a first compilation
outdir <- "./dist/rstudio"
rtheme_out <- tools::file_path_sans_ext(tminput) |>
  basename() |>
  paste0(".rstheme") %>%
  file.path(outdir, .)


tmtheme2rstheme(tminput, rtheme_out)


# Apply the new theme
rstudioapi::addTheme(rtheme_out, apply = TRUE, force = TRUE)

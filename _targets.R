
# Resources and manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)

# Set target options:
tar_option_set(
  format = "qs"
)

# Run the R scripts in the R/ folder with custom functions:
tar_source(c(
  "R/01_utils.R", 
  "R/02_processing.R"
))

# target list
list(
  # 1. Download accessibility data
  tar_target(
    name = access_data,
    command = download_accessibility(),
    format = "file" 
  ),
  # 2. Download spatial data
  tar_target(
    name = datazone_scotland,
    command = download_datazone(),
    format = "file" 
  ),
  # 3. Process and join data
  tar_target(
    name = subset_glasgow,
    command = process_access(
      access_data = access_data,
      datazone_scotland = datazone_scotland
    ),
    packages = c("dplyr", "readr", "sf"),
    format = "qs"
  ),
  # 4. Generate map
  tar_target(
    name = accessibility_map,
    command = plot_employment_access(
      accessibility_sf = subset_glasgow
    ),
    packages = c("dplyr", "ggplot2", "sf")
  )
)
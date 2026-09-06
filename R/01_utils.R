# Download accessibility data
download_accessibility <- function() {
  dir.create("./data/raw", recursive = TRUE, showWarnings = FALSE)
  url_data <- 'https://huggingface.co/datasets/rafavdz/accessibility-indicators-2023/resolve/main/records/employment_all/access_employment_all_pt.csv'
  file <- paste0("./data/raw/", basename(url_data))
  
  download.file(
    url = url_data,
    destfile = file,
    mode = "wb"
  )
  
  return(file)
}

# Download data zone geometries in Scotland
download_datazone <- function() {
  dir.create("./data/raw", recursive = TRUE, showWarnings = FALSE)
  
  zip <- "./data/raw/SG_DataZoneBdry_2011.zip"
  dir <- "./data/raw/datazones_scotland"
  
  download.file(
    "https://huggingface.co/datasets/rafavdz/datazones_scotland2011/resolve/main/datazones_scotland.zip",
    zip,
    mode = "wb"
  )
  
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  
  files <- unzip(zip, list = TRUE)$Name
  unzip(zip, exdir = dir)
  file.remove(zip)

  file.path(
    dir,
    files[grepl("\\.shp$", files, ignore.case = TRUE)]
  )
}


# Download data zone geometries in Scotland
download_datazone <- function() {
  dir.create("./data/raw", recursive = TRUE, showWarnings = FALSE)
  
  zip <- "./data/raw/SG_DataZoneBdry_2011.zip"
  dir <- "./data/raw/datazones_scotland"
  
  download.file(
    "https://huggingface.co/datasets/rafavdz/datazones_scotland2011/resolve/main/datazones_scotland.zip",
    zip,
    mode = "wb"
  )
  
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  
  unzip(zip, exdir = dir)
  file.remove(zip)
  
  shp_path <- list.files(
    dir,
    pattern = "\\.shp$",
    recursive = TRUE,
    full.names = TRUE
  )
  
  return(shp_path)
}


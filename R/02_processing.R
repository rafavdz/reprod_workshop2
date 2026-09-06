# Fun process accessibility and spatial data
process_access <- function(access_data, datazone_scotland) {
  
  # Read data
  accessibility_indices <- readr::read_csv(access_data)
  datazones <- sf::st_read(datazone_scotland) |> 
    st_transform(27700)
  
  # Glasgow city centre
  glasgow_cc <- sf::st_point(c(-4.256300, 55.860484)) |>
    sf::st_sfc(crs = 4326) |> 
    sf::st_transform(27700)
  
  # Subset
  datazones_glasgow <- datazones |> 
    sf::st_filter(st_buffer(glasgow_cc, 10e3)) 
  
  # Join accessibility data to Glasgow
  datazones_glasgow <- datazones_glasgow |> 
    left_join(accessibility_indices, by = c('DataZone' = 'geo_code')) 
  
  # Return SF Glasgow with access data
  return(datazones_glasgow)
}

# Create accessibility map
plot_employment_access <- function(accessibility_sf){
  dir.create("./data/generated", recursive = TRUE, showWarnings = FALSE)
  
  # Run map
  map_ggplot <- accessibility_sf |> 
    filter(time_of_day == 'am') |>
    ggplot() +
    geom_sf(aes(fill = access_employment_all_45/1e3), lwd = 0) +
    labs(
      title = 'Accessibility to employment',
      subtitle = 'Travel time by public transport at morning',
      fill = 'Jobs \n(In thousands)'
    ) +
    scale_fill_viridis_b(n.breaks = 6) +
    theme_void()
  
  # Save map
  ggplot2::ggsave(
    plot = map_ggplot,
    filename = "./data/generated/accessibility_map.png"
  )
}


map_bloom_sites <- function(p2_site_metadata_ready, p1_irb_flowlines, p1_irb_sf,  out_file){
  
  # focal sites
  sites_sf <- p2_site_metadata_ready %>% 
    st_as_sf(coords = c('longitude', 'latitude'), crs=4326)
  
  # stream network
  flines <- p1_irb_flowlines %>%
    filter(streamorde > 2,
           !(ftype %in% c('ArtificalPath')))
  
  sites_sf %>%
    ggplot()+
    geom_sf(data = p1_irb_sf,
            fill = NA
    ) +
    geom_sf(data = flines,
            color = "royalblue",
            aes(size = streamorde)) +
    ## backing for site points
    geom_sf(color = "white",
            size = 4, shape = 21, stroke = 4
    )+
    # site points
    geom_sf(color = "orangered",
            size = 6, shape = 21, stroke = 2
    )+
    theme_void() +
    theme(legend.position = 'none',
          panel.background = element_blank()) +
    scale_size(range = c(0.1, 1),
               breaks = c(1, 3, 6, 8))
  
  ggsave(out_file, dpi = 300, width = 12, height = 12, unit = 'in')
}
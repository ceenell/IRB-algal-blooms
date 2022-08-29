
source('data-pipeline/3_visualize/src/generate_timeseries_figure.R')
source('data-pipeline/3_visualize/src/map_sites.R')

p3_targets_list <- list(

  ## Create timeseries charts of multiple WQ params
  tar_target(p3_line_ts_facet_png,
             generate_line_ts_figure(
               file_out = sprintf('data-pipeline/3_visualize/out/line_ts_facet.png'),
               data_in = p2_param_data_ready
             ), format = "file"),

  tar_target(p3_dist_ts_facet_png,
             generate_dist_ts_figure(
               file_out = sprintf('data-pipeline/3_visualize/out/dist_ts_facet.png'),
               data_in = p2_param_data_ready
             ), format = "file"),

  ## Map study sites
  tar_target(
    p3_site_map_png,
    map_bloom_sites(p2_site_metadata_ready,
                    p1_irb_flowlines,
                    p1_irb_sf,
                    out_file = 'data-pipeline/3_visualize/out/IRB_site_map.png'
                    ),
  format = 'file'
  ),

  ## SVG TEST ZONE
  tar_target(
    p_svg, {
      p_fn <- 'p.svg'
      example_dat <- tibble(day = c(1:3,2:4),
                            value = c(5,7,2, 1,4.5,5.3),
                            group = c(rep('site1', 3), rep('site2', 3)))
      p <- ggplot(example_dat, aes(x = day, y = value, color = group)) +
        geom_line()
      ggsave(p_fn, p, width=10, height=5, units='in')
      return(p_fn)
    }, format = 'file'
  )

)


source('data-pipeline/3_visualize/src/generate_timeseries_figure.R')
source('data-pipeline/3_visualize/src/map_sites.R')

p3_targets_list <- list(

  tar_target(p3_plot_site_labels,
             tibble(site_no = c("05558300", "05553700", "05543010"),
                    site_label = c("Henry", "Starved Rock", "Seneca"))),
  tar_target(p3_param_data_to_plot,
             p2_param_data_ready %>%
               left_join(p3_plot_site_labels, by = "site_no") %>%
               group_by(param_grp) %>%
               tar_group(),
             iteration = "group"),

  ## Create timeseries charts of multiple WQ params
  tar_target(p3_line_ts_facet_png,
             generate_line_ts_figure(
               file_out = sprintf('data-pipeline/3_visualize/out/line_ts_%s.png', unique(p3_param_data_to_plot$param_grp)),
               data_in = p3_param_data_to_plot
             ), format = "file", pattern = map(p3_param_data_to_plot)),

  ## Map study sites
  tar_target(
    p3_site_map_png,
    map_bloom_sites(p2_site_metadata_ready,
                    p1_irb_flowlines,
                    p1_irb_sf,
                    out_file = 'data-pipeline/3_visualize/out/IRB_site_map.png'
                    ),
  format = 'file'
  )

)

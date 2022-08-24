
source('data-pipeline/3_visualize/src/generate_timeseries_figure.R')
source('data-pipeline/3_visualize/src/map_sites.R')

p3_targets_list <- list(

  tar_target(p3_plot_site_labels,
             tibble(site_no = c("05558300", "05553700", "05543010"),
                    site_label = c("Henry", "Starved Rock", "Seneca"))),

  # Identify plot axes per param group so that bloom and nonbloom
  # plots share the same axis.
  tar_target(p3_plot_axes_info,
             p2_param_data_bloom %>%
               bind_rows(p2_param_data_nonbloom) %>%
               group_by(param_grp) %>%
               summarize(min_val = min(plot_value, na.rm=TRUE),
                         max_val = max(plot_value, na.rm=TRUE),
                         diff_val = max_val - min_val) %>%
               # Add 2% buffer to each axes
               mutate(min_axis_val = min_val - (diff_val*0.02),
                      max_axis_val = max_val + (diff_val*0.02))
  ),

  # Plot the figures around the bloom dates for each parameter group
  tar_target(p3_param_data_to_plot_bloom,
             p2_param_data_bloom %>%
               left_join(p3_plot_site_labels, by = "site_no") %>%
               left_join(p3_plot_axes_info, by = "param_grp") %>%
               group_by(param_grp) %>%
               tar_group(),
             iteration = "group"),

  ## Create timeseries charts of multiple WQ params
  tar_target(p3_bloom_timeseries_png,
             generate_line_ts_figure(
               file_out = sprintf('data-pipeline/3_visualize/out/bloom_ts_%s.png', unique(p3_param_data_to_plot_bloom$param_grp)),
               data_in = p3_param_data_to_plot_bloom
             ), format = "file", pattern = map(p3_param_data_to_plot_bloom)),

  # Plot the figures around the dates where no bloom occurred for each parameter group
  tar_target(p3_param_data_to_plot_nonbloom,
             p2_param_data_nonbloom %>%
               left_join(p3_plot_site_labels, by = "site_no") %>%
               left_join(p3_plot_axes_info, by = "param_grp") %>%
               group_by(param_grp) %>%
               tar_group(),
             iteration = "group"),

  tar_target(p3_nonbloom_timeseries_png,
             generate_line_ts_figure(
               file_out = sprintf('data-pipeline/3_visualize/out/nonbloom_ts_%s.png', unique(p3_param_data_to_plot_nonbloom$param_grp)),
               data_in = p3_param_data_to_plot_nonbloom
             ), format = "file", pattern = map(p3_param_data_to_plot_nonbloom)),

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

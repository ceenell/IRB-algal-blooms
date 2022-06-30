
source('data-pipeline/3_visualize/src/generate_timeseries_figure.R')

p3_targets_list <- list(

  tar_target(p3_line_ts_facet_png,
             generate_line_ts_figure(
               file_out = sprintf('data-pipeline/3_visualize/out/line_ts_facet.png'),
               data_in = p2_param_data_ready
             ), format = "file"),

  tar_target(p3_dist_ts_facet_png,
             generate_dist_ts_figure(
               file_out = sprintf('data-pipeline/3_visualize/out/dist_ts_facet.png'),
               data_in = p2_param_data_ready
             ), format = "file")

)

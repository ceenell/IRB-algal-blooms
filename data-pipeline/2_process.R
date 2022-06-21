
source('data-pipeline/2_process/src/clean_param_data.R')

p2_targets_list <- list(

  tar_target(p2_param_data_clean,
             clean_param_data(
               file_in = p1_param_data_downloaded_csvs,
               param_grp = p1_param_grps,
               sites = sites_to_explore,
               start_date = start_date,
               end_date = end_date),
             iteration = "list",
             pattern = map(p1_param_data_downloaded_csvs, p1_param_grps)),

  tar_target(p2_param_data_all, bind_rows(p2_param_data_clean))

)

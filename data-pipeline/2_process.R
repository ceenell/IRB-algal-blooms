
source('data-pipeline/2_process/src/clean_param_data.R')

p2_targets_list <- list(

  tar_target(p2_param_data_bloom,
             clean_param_data(
               file_in = p1_param_data_downloaded_csvs,
               sites = sites_to_explore,
               start_date = bloom_start_date,
               end_date = bloom_end_date),
             pattern = map(p1_param_data_downloaded_csvs)),

  tar_target(p2_param_data_nonbloom,
             clean_param_data(
               file_in = p1_param_data_downloaded_csvs,
               sites = sites_to_explore,
               start_date = nonbloom_start_date,
               end_date = nonbloom_end_date),
             pattern = map(p1_param_data_downloaded_csvs)),

  tar_target(p2_site_metadata_ready,
             read_csv(p1_site_metadata_downloaded_csv) %>%
               filter(site_no %in% sites_to_explore))

)


source('data-pipeline/1_fetch/src/download_sb_file.R')

p1_targets_list <- list(

  tar_target(p1_param_grps, wq_parameter_groups), # Needs to be a target to use for branching
  tar_target(p1_param_data_downloaded_csvs,
             download_sb_file(
               local_file_to_save = sprintf("data-pipeline/1_fetch/out/data_%s_combined.csv", p1_param_grps),
               sb_file_to_download = sprintf('data_%s_combined.csv', p1_param_grps),
               sb_id = wq_data_sbid),
             format = "file",
             pattern = map(p1_param_grps))

)

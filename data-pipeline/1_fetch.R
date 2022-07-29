
source('data-pipeline/1_fetch/src/download_sb_file.R')
source('data-pipeline/1_fetch/src/get_nlcd_aoi.R')

p1_targets_list <- list(
  
  
  # Load HUC codes
  # HUC08s manually compiled by Lindsay Platt in January 2021 from
  #   --> https://water.usgs.gov/GIS/huc_name.html#Region07
  tar_target(p1_huc_cfg_yml, "data-pipeline/1_fetch/in/IRB_HUC_codes_04_08.yml", format = "file"),
  tar_target(p1_huc_cds, yaml.load_file(p1_huc_cfg_yml)),
  tar_target(p1_huc8s, p1_huc_cds$irb_huc8s),
  
  # Fetch spatial data from NHD+
  tar_target(p1_irb_sf, get_huc8(id = p1_huc8s) %>% st_union() %>% st_make_valid()),
  tar_target(p1_irb_flowlines, get_nhdplus(p1_irb_sf)),
  tar_target(p1_irb_states,
             spData::us_states %>%
               sf::st_crop(p1_irb_sf %>% st_buffer(1000)) %>%
               st_transform(st_crs(p1_irb_sf))),
  
  tar_target(p1_param_grps, wq_parameter_groups), # Needs to be a target to use for branching
  tar_target(p1_param_data_downloaded_csvs,
             download_sb_file(
               local_file_to_save = sprintf("data-pipeline/1_fetch/out/daily_metrics_%s.csv", p1_param_grps),
               sb_file_to_download = sprintf('daily_metrics_%s.csv', p1_param_grps),
               sb_id = wq_data_sbid),
             format = "file",
             pattern = map(p1_param_grps)),

  tar_target(p1_site_metadata_downloaded_csv,
             download_sb_file(
               local_file_to_save = "data-pipeline/1_fetch/out/site_metadata.csv",
               sb_file_to_download = "site_metadata.csv",
               sb_id = wq_data_sbid),
             format = "file"),
  
  # Get NLCD
  tar_target(
    years_nlcd,
    c('2001', '2004', '2006', '2008', '2011','2016','2019')
  ),
  tar_target(
    p1_irb_nlcd,
    get_nlcd_aoi(
      aoi = p1_irb_sf,
      aoi_label = 'IRB',
      nlcd_dataset = 'landcover',
      nlcd_year = years_nlcd,
      file_name = sprintf('nlcd_%s.tif', years_nlcd),
      out_folder = 'data-pipeline/1_fetch/out/nlcd'
    ),
    pattern = map(years_nlcd),
    format = 'file'
  ),
  tar_target(
    p1_irb_imp,
    get_nlcd_aoi(
      aoi = p1_irb_sf,
      aoi_label = 'IRB',
      nlcd_dataset = 'impervious',
      nlcd_year = years_nlcd,
      file_name = sprintf('impervious_%s.tif', years_nlcd),
      out_folder = 'data-pipeline/1_fetch/out/nlcd'
    ),
    pattern = map(years_nlcd),
    format = 'file'
  )
)

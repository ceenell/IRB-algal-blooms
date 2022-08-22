# Main recipe file for orchestrating the full data pipeline build

library(targets)

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c('ggdist', 'sbtools', 'tidyverse', 'yaml', 'sf',
                            'nhdplusTools', 'FedData', 'raster', 'terra'))
# get FedData via github: devtools::install_github("ropensci/FedData")
#
source('data-pipeline/1_fetch.R')
source('data-pipeline/2_process.R')
source('data-pipeline/3_visualize.R')

# ScienceBase item id for the data release containing already cleaned and
# harmonized HABS-related water quality data in the ILRB. To be released in July 2022.
# See https://www.sciencebase.gov/catalog/item/62abf202d34e74f0d80eb611
wq_data_sbid <- '62abf202d34e74f0d80eb611'

# Based on the parameter groups defined in the `pcode_groups_xwalk.csv` file
# from the data release at
wq_parameter_groups <- c('chl_a', 'fPC', 'fchl', 'DO', 'pH', 'temp_water')

# Define site numbers that we want to use. Must be sites already available in
# the `site_metadata.csv` file from the SB item
sites_to_explore <- c(
  "05543010", # Seneca
  "05558300", # Henry; bloom dates: 2021-06-18, 2020-06-25
  "05553700" # Starved Rock; bloom dates: 2021-06-18, 2020-06-25, and 2018-06-25
)

# Define the start and end dates of interest
# TODO: WAS GOING TO DO 2021 DATES BUT OUR DATA RELEASE DOESN'T INCLUDE THOSE
start_date <- '2020-06-01'
end_date <- '2020-07-10'

##### SB AUTHENTICATION #####
# TODO: DELETE ME. Currently, this SB item is internal only.
# Soon, it will be published, so this step will not be necessary
sb_secret <- dssecrets::get_dssecret('vizlab-sb-srvc-acct')
sbtools::authenticate_sb(sb_secret$username, sb_secret$password)
##### ^^^ DELETE ME ^^^ #####

c(p1_targets_list, p2_targets_list, p3_targets_list)

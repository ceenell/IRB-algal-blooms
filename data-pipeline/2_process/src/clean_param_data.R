clean_param_data <- function(in_file, param_grp, sites) {
  readr::read_csv(in_file, col_types = c(parameter_cd = "c")) %>%
    mutate(param_grp = param_grp) %>%
    filter(site_no %in% sites)
}

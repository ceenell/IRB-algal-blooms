clean_param_data <- function(file_in, param_grp, sites, start_date, end_date) {
  readr::read_csv(file_in, col_types = c(parameter_cd = "c")) %>%
    mutate(param_grp = param_grp) %>%
    filter(site_no %in% sites) %>%
    filter(date >= start_date, date <= end_date) %>%
    select(site_no, param_grp, parameter_cd, date, date_time, freq, result_va)
}

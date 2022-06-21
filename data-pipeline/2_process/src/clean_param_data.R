clean_param_data <- function(file_in, sites, start_date, end_date) {
  readr::read_csv(file_in, show_col_types = FALSE) %>%
    filter(site_no %in% sites) %>%
    filter(date >= start_date, date <= end_date) %>%
    select(site_no, date, param_grp = parm_abbrev, ends_with("_result"))
}

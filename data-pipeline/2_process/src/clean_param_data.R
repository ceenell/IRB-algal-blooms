clean_param_data <- function(file_in, sites, start_date, end_date) {
  data_clean <- readr::read_csv(file_in, show_col_types = FALSE) %>%
    dplyr::filter(site_no %in% sites) %>%
    dplyr::mutate(param_grp = parm_abbrev) %>%
    dplyr::arrange(site_no, date) %>%
    # Adjust temperature values to be a rolling 10-day `mean_result` values
    # before the date filtering so that we include dates outside of the window
    convert_temps_to_rolling_mean() %>%
    dplyr::filter(date >= start_date, date <= end_date) %>%
    dplyr::select(site_no, date, param_grp, ends_with("_result"), plot_value)

}

convert_temps_to_rolling_mean <- function(data_in) {
  data_in %>%
    dplyr::group_by(site_no, param_grp) %>%
    # Calculate the rolling mean per site/param_grp
    dplyr::mutate(mean_rolling = zoo::rollmean(mean_result, k = 10, fill=NA, align = "center")) %>%
    # Only replace `mean_result` with the rolling mean for temperature
    dplyr::mutate(plot_value = ifelse(param_grp == "temp_water", mean_rolling, mean_result)) %>%
    dplyr::select(-mean_rolling) %>%
    dplyr::ungroup()
}

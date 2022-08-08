
generate_line_ts_figure <- function(file_out, data_in) {

  p <- data_in %>%
    arrange(date) %>%
    filter(param_grp %in% c("DO", "fchl")) %>%
    filter(date >= as.Date('2020-05-01'),
           date <= as.Date('2020-07-31')) %>%
    ggplot(aes(x = date, y = mean_result)) +
    geom_line(aes(color = site_no), size = 1) +
    facet_grid(param_grp ~ ., scales = 'free') +
    scico::scale_color_scico_d(palette = 'lapaz', begin = 0.25, end = 0.75) +
    theme_bw()
  ggsave(file_out, p, width = 7, height = 10)

  return(file_out)
}

generate_dist_ts_figure <- function(file_out, data_in) {

  p <- data_in %>%
    arrange(date) %>%
    filter(param_grp %in% c("DO", "fchl")) %>%
    filter(date >= as.Date('2020-05-01'),
           date <= as.Date('2020-07-31')) %>%
    ggplot(aes(x = date, y = mean_result, ymin = minimum_result, ymax = maximum_result)) +
    geom_lineribbon(aes(color = site_no, fill = site_no), alpha=0.4) +
    facet_grid(param_grp ~ ., scales = 'free') +
    scico::scale_color_scico_d(palette = 'lapaz', begin = 0.25, end = 0.75) +
    theme_bw()
  ggsave(file_out, p, width = 7, height = 10)

  return(file_out)
}


generate_line_ts_figure <- function(file_out, data_in, plot_label = 'Mean daily algal fluorescence, ug/L', bloom_date = as.Date('2021-06-20'),
                                    color_vals = c("#506992", "#5FB5D1", "#ABD7C8"), color_val_labels = c("Henry", "Starved Rock", "Seneca")) {

  # Need to use final dates to position site labels
  data_last <- data_in %>% filter(date == max(date))

  # Insert a gradient rectangle around a bloom date
  ndays <- 5
  gradient_rect <- tibble(
    xleft = c(seq(bloom_date-ndays, bloom_date, by = 1), seq(bloom_date+1, bloom_date+ndays, by = 1))
  ) %>%
    mutate(xright = xleft + 1) %>%
    mutate(alpha_val = as.numeric(1-((bloom_date - xleft)/ndays))) %>%
    # Mirror the alphas
    mutate(alpha_val = ifelse(alpha_val > 1, 2 - alpha_val, alpha_val))

  p <- ggplot(data = data_in) +
    geom_text(data = data_last, aes(x = date, y = plot_value, label = site_label, color = site_label),
              fontface ="bold", hjust = 0, nudge_x = 0.5) +
    geom_text(x = min(data_in$date), y = 107, label = plot_label, color = '#918b8b', size = 5, hjust = 0.10) +
    geom_rect(data = gradient_rect, aes(xmin = xleft, xmax = xright, alpha = alpha_val),
              ymin = -Inf, ymax = Inf,
              fill = '#dedcdc') +
    ggalt::geom_xspline(aes(x = date, y = plot_value, color = site_label), size = 1, spline_shape = -0.5) +
    scale_color_manual(values = color_vals,
                       breaks = color_val_labels) +
    theme_bw() +
    theme(legend.position = "none",
          panel.border = element_blank(),
          panel.grid.major.x = element_blank(),
          panel.grid.minor.x = element_blank(),
          plot.margin = margin(1.5,2.5,0.25,0.25, 'cm'),
          axis.title = element_blank(),
          axis.text.x = element_text(face = 'bold', color = '#bdb9b9'),
          axis.text.y = element_text(face = 'bold', color = '#bdb9b9', vjust=0.3, hjust=1),
          axis.ticks = element_blank()) +
    coord_cartesian(clip = 'off') +
    xlim(c(min(data_in$date), max(data_in$date) + 1)) +
    ylim(c(min(data_in$minimum_result), max(data_in$maximum_result)))

  ggsave(file_out, p, width = 10, height = 6)

  return(file_out)
}

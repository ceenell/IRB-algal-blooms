library(targets)
library(tidyverse)

sites_to_explore <- c(
  "05543010", # Seneca
  "05558300", # Henry; bloom dates: 2021-06-18, 2020-06-25
  "05553700" # Starved Rock; bloom dates: 2021-06-18, 2020-06-25, and 2018-06-25
)
all_data <- purrr::map(tar_read(p1_param_data_downloaded_csvs), readr::read_csv, col_types = c(pcodes = 'c')) %>%
  bind_rows() %>%
  filter(site_no %in% sites_to_explore) %>%
  rename(param_grp = parm_abbrev)

data_ready <- all_data %>%
  arrange(date) %>%
  filter(param_grp %in% c("DO", "fchl")) %>%
  filter(date >= as.Date('2020-05-01'),
         date <= as.Date('2020-07-31')) %>%
  left_join(tibble(site_no = c("05558300", "05553700", "05543010"),
                   site_label = c("Henry", "Starved Rock", "Seneca")))

fchl_data <- data_ready %>% filter(param_grp == "fchl")
do_data <- data_ready %>% filter(param_grp == "DO")

fchl_last <- fchl_data %>% filter(date == max(date))
do_last <- do_data %>% filter(date == max(date))

bloom_date <- as.Date('2020-06-25')
ndays <- 5
gradient_rect <- tibble(
  xleft = c(seq(bloom_date-ndays, bloom_date, by = 1), seq(bloom_date+1, bloom_date+ndays, by = 1))
) %>%
  mutate(xright = xleft + 1) %>%
  mutate(alpha_val = as.numeric(1-((bloom_date - xleft)/ndays))) %>%
  # Mirror the alphas
  mutate(alpha_val = ifelse(alpha_val > 1, 2 - alpha_val, alpha_val))

p_fchl <- ggplot(data = fchl_data) +
  geom_text(data = fchl_last, aes(x = date, y = mean_result, label = site_label, color = site_label),
            fontface ="bold", hjust = 0, nudge_x = 0.5) +
  geom_text(x = as.Date('2020-05-01'), y = 107,
            label = 'Mean daily algal fluorescence, ug/L',
            color = '#918b8b', size = 5, hjust = 0.10) +
  geom_rect(data = gradient_rect, aes(xmin = xleft, xmax = xright, alpha = alpha_val),
            ymin = -Inf, ymax = Inf,
            fill = '#dedcdc') +
  # Copy this same styling to the DO plot
  # ggdist::geom_lineribbon(aes(ymin = minimum_result, ymax = maximum_result,
  #                             color = site_label, fill = site_label), alpha=0.25) +
  geom_line(aes(x = date, y = mean_result, color = site_label), size = 1) +
  scale_color_manual(values = c("#506992", "#5FB5D1", "#ABD7C8"),
                     breaks = c("Henry", "Starved Rock", "Seneca")) +
  # scale_fill_manual(values = c("#506992", "#5FB5D1", "#ABD7C8"),
  #                   breaks = c("Henry", "Starved Rock", "Seneca")) +
  theme_bw() +
  theme(legend.position = "none",
        panel.border = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        plot.margin = margin(0.5,2.5,0.25,0.25, 'cm'),
        axis.title = element_blank(),
        axis.text.x = element_text(face = 'bold', color = '#bdb9b9'),
        axis.text.y = element_text(face = 'bold', color = '#bdb9b9', vjust=0.3, hjust=1),
        axis.ticks = element_blank()) +
  coord_cartesian(clip = 'off') +
  xlim(c(min(data_ready$date), max(data_ready$date) + 1)) +
  ylim(c(min(fchl_data$minimum_result), max(fchl_data$maximum_result)))

p_do <- ggplot(do_data) +
  geom_text(data = do_last, aes(x = date, y = mean_result, label = site_label, color = site_label),
            fontface ="bold", hjust = 0, nudge_x = 0.5) +
  geom_text(x = as.Date('2020-05-01'), y = 17,
            label = 'Mean daily dissolved oxygen, mg/L',
            color = '#918b8b', size = 5, hjust = 0.10) +
  geom_rect(data = gradient_rect, aes(xmin = xleft, xmax = xright, alpha = alpha_val),
            ymin = -Inf, ymax = Inf,
            fill = '#dedcdc') +
  # Below this comment was copied from fchl plot
  # Except for turning off the x-axis labels
  # ggdist::geom_lineribbon(aes(ymin = minimum_result, ymax = maximum_result,
  #                             color = site_label, fill = site_label), alpha=0.25) +
  geom_line(aes(x = date, y = mean_result, color = site_label), size = 1) +
  scale_color_manual(values = c("#506992", "#5FB5D1", "#ABD7C8"),
                     breaks = c("Henry", "Starved Rock", "Seneca")) +
  # scale_fill_manual(values = c("#506992", "#5FB5D1", "#ABD7C8"),
  #                   breaks = c("Henry", "Starved Rock", "Seneca")) +

  theme_bw() +
  theme(legend.position = "none",
        panel.border = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        plot.margin = margin(0.5,2.5,0.25,0.25, 'cm'),
        axis.title = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_text(face = 'bold', color = '#bdb9b9', vjust=0.3,hjust=1),
        axis.ticks = element_blank()) +
  coord_cartesian(clip = 'off') +
  xlim(c(min(data_ready$date), max(data_ready$date) + 1)) +
  ylim(c(min(do_data$minimum_result), max(do_data$maximum_result)))

p_combined <- cowplot::plot_grid(p_do, p_fchl, nrow=2)
ggsave('habs_fancy_ts.png', p_combined, width = 15, height = 8)

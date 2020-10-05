ggpiano_roll_facets <- function(df_plot) {
  p1 <-
    df_plot %>%
    ggplot2::ggplot() +
    # geom_point() +
    ggplot2::geom_segment(ggplot2::aes(x = m_note_on,
                                       y = note_name,
                                       xend = m_note_off,
                                       yend = note_name,
                                       color = velocity_note_on)) +
    ggplot2::geom_rect(ggplot2::aes(xmin = m_note_on,
                                    xmax = m_note_off,
                                    ymin = note_name,
                                    ymax = note_name_max,
                                    fill = pattern,
                                    alpha = .05)) +
    # scale_y_discrete(limits = df_plot %>% distinct(note_name, .keep_all = T) %>% arrange(note) %>% pull(note_name) %>% as.character()) +
    ggplot2::facet_wrap(~ i_track,
                        ncol=1,
                        scales = "free_y")
  p1
}

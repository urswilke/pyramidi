mid_file = '/home/chief/Bitwig Studio/Projects/bossa_raw/midi_arpeggiated.mid'
# mid_file = '/home/chief/Desktop/tabs/hydrogen/1st_bossa_percussion_neu.mid'
l <- pyramidi::midi_df(mid_file)
df_plot <- pyramidi::tab_measures(l[[2]],
                       l[[1]],
                       l[[3]] %>%
                         dplyr::pull()
) %>%
  pyramidi::widen_events() %>%
  dplyr::left_join(pyramidi::midi_defs)
df_beats <-
  df_plot %>%
  # dplyr::left_join(pyramidi::midi_defs) %>%
  pyramidi:::classify_beat_patterns()

df_plot <-
  dplyr::full_join(df_plot, df_beats) %>%
  dplyr::mutate(pattern = factor(pattern))
p1 <- df_plot %>%
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
p1 <- pyramidi:::ggpiano_roll_facets(df_plot)
pl1 <- plotly::ggplotly(p1, width = 800)


# see https://stackoverflow.com/questions/58103196/how-to-facet-a-plot-ly-chart:
pl1
ply1 <-
  df_plot %>%
  dplyr::group_by(-i_track) %>%
  dplyr::group_map(~ plotly::plot_ly(data=.) %>% plotly::add_segments(name = ~note_name, x = ~m_note_on, xend = ~m_note_off, y = ~note_name, yend = ~note_name, color = ~paste0(note_name, pattern %>% as.character() %>% tidyr::replace_na("")), size = I(5), type = "scatter", mode="markers"), keep=TRUE) %>%
  plotly::subplot(nrows = length(.), shareX = TRUE, shareY=FALSE)
ply1 <- plotly::style(ply1, traces = ply1$x$data %>% purrr::map_chr(~.x$name) %>% duplicated() %>% which(), showlegend = FALSE)
ply1



# patchwork try -----------------------------------------------------------
library(patchwork)
psb <-
  df_beats %>%
  ggplot() +
  ggplot2::geom_rect(ggplot2::aes(xmin = m_note_on,
                                  xmax = m_note_off,
                                  ymin = note_name,
                                  ymax = note_name_max,
                                  fill = pattern,
                                  alpha = .05))

name <- function(variables) {

}
l_track_rolls <-
  df_plot %>%
  group_by(i_track) %>%
  group_map(~ ggplot(.x) + geom_segment(ggplot2::aes(x = m_note_on,
                                                   y = note_name,
                                                   xend = m_note_off,
                                                   yend = note_name,
                                                   color = velocity_note_on)))
# l_track_rolls[[1]] /   l_track_rolls[[2]]
l_track_rolls[[length(l_track_rolls) + 1]] <- psb
l_pl <-
  l_track_rolls %>%
  map(~plotly::ggplotly(.x))
l_pl %>%
  # map(~plotly::style(.x, showlegend = FALSE))%>%
  plotly::subplot(nrows = length(.), shareX = TRUE, shareY=FALSE)






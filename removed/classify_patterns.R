classify_beat_patterns <- function(df_plot) {

  l <-
    df_plot %>%
    filter(i_track == 1) %>%
    group_split(round(m_note_on %/% 2, 8), round(m_note_off %/% 2, 8)) %>%
    map(~select(.x, i_track, note, m_note_on, m_note_off) %>%
          mutate(m_note_on = round(m_note_on %% 2, 6),
                 m_note_off = round(m_note_off %% 2))) %>% set_names()

  lu <- unique(l) %>% set_names()
  classes <- factor(names(l), names(lu)) %>% as.numeric()

  # min_note <- df_plot %>% filter(i_track == 1,note == min(df_plot %>% filter(i_track == 1) %>% pull(note))) %>% pull(note_name) %>% unique()
  # max_note <- df_plot %>% filter(i_track == 1,note == max(df_plot %>% filter(i_track == 1) %>% pull(note))) %>% pull(note_name) %>% unique()
  df_beats <-
    (1:floor(max(df_plot$m_note_off) / 2) * 2) %>%
    tibble(m_note_off = .) %>%
    mutate(note_name = "pattern",
           # note_name_max = "pattern2",
           pattern = factor(classes),
           i_track = 1,
           m_note_on = lag(m_note_off, default = 0))
  df_beats
}

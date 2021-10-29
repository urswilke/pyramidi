## code to prepare `save_piano_keys_coord_table` dataset goes here

library(tidyverse)
library(rvest)
x <- read_html("https://upload.wikimedia.org/wikipedia/commons/1/15/PianoKeyboard.svg")
n <- x %>% html_nodes("rect")
xmins <- n %>% html_attr("x") %>% as.numeric() %>% {. / 161 * 12} %>% sort()


piano_keys_coordinates <-
  pichor::keys_chords %>%
  filter(key <= 12) %>%
  mutate_at(vars("xmin", "xmax"), ~ . * 24) %>%
  mutate(ymin = 1/3 /.45 * ymin) %>%
  mutate(
    xmin = xmins - 0.5,
    xmax = ifelse(key_color == "white",
                  xmin + 12 / 7,
                  xmin + 1)
  )

piano_keys_coordinates <-
  map_dfr(0:10 * 12, ~mutate(piano_keys_coordinates, xmin = xmin + .x, xmax = xmax + .x)) %>%
  filter(xmax <= 128.5)

piano_keys_coordinates <-
  piano_keys_coordinates %>%
  mutate(midi = 0:127) %>%
  # left_join(pyramidi::midi_defs, by = c("midi" = "note")) %>%
  select(-key, -key_color, -label_x, -label_y, -label, -tones, -label_color) %>%
  relocate(midi, layer)

usethis::use_data(piano_keys_coordinates, overwrite = TRUE)


<!-- README.md is generated from README.Rmd. Please edit that file -->

# pyramidi

<!-- badges: start -->

<!-- badges: end -->

**Work in progress\!**

The goal of pyramidi is to read in dataframes generated by the python
package [miditapyr](https://pypi.org/project/miditapyr/). These
dataframes contain midi data. Then the midi information (one line per
event) can be translated into a wide format (one line per note). This
facilitates plotting piano roll plots. These dataframes can then be
written back to midi files (again using miditapyr).

## Installation

You can install pyramidi from
[github](https://github.com/urswilke/pyramidi) with:

``` r
## install remotes package if it's not already
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

## install dev version of rtweettree from github
remotes::install_github("UrsWilke/pyramidi")
```

The python package [miditapyr](https://pypi.org/project/miditapyr/) also
needs to be installed via

``` sh
pip install miditapyr
```

in your virtual environment.

## Basic usage

### Load libraries

``` r
library(pyramidi)
library(tidyverse)
library(zeallot)
mt <- reticulate::import("miditapyr")
mido <- reticulate::import("mido")
```

### Extract midi file information into dataframe

``` r
midi_file_str <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")

midifile <- mido$MidiFile(midi_file_str)
ticks_per_beat <- midifile$ticks_per_beat

dfc = mt$midi_to_df(midifile)
head(dfc, 20)
#>    i_track  meta                            msg
#> 1        0  TRUE    track_name, Drum Machine, 0
#> 2        0 FALSE         note_on, 0, 38, 101, 9
#> 3        0 FALSE         note_on, 0, 36, 101, 9
#> 4        0  TRUE           set_tempo, 545454, 0
#> 5        0  TRUE time_signature, 4, 4, 24, 8, 0
#> 6        0 FALSE      note_off, 240, 38, 101, 9
#> 7        0 FALSE        note_off, 0, 36, 101, 9
#> 8        0 FALSE      note_on, 1200, 38, 101, 9
#> 9        0 FALSE      note_off, 240, 38, 101, 9
#> 10       0 FALSE       note_on, 240, 38, 101, 9
#> 11       0 FALSE         note_on, 0, 36, 101, 9
#> 12       0 FALSE      note_off, 240, 38, 101, 9
#> 13       0 FALSE        note_off, 0, 36, 101, 9
#> 14       0 FALSE      note_on, 1200, 38, 101, 9
#> 15       0 FALSE      note_off, 240, 38, 101, 9
#> 16       0 FALSE       note_on, 240, 38, 101, 9
#> 17       0 FALSE         note_on, 0, 36, 101, 9
#> 18       0 FALSE      note_off, 240, 38, 101, 9
#> 19       0 FALSE        note_off, 0, 36, 101, 9
#> 20       0 FALSE      note_on, 1200, 38, 101, 9
```

``` r
ticks_per_beat
#> [1] 960
```

``` r
df = mt$tidy_df(dfc)
head(df, 20)
#>    i_track  meta           type         name time note velocity channel  tempo
#> 1        0  TRUE     track_name Drum Machine    0  NaN      NaN     NaN    NaN
#> 2        0 FALSE        note_on          NaN    0   38      101       9    NaN
#> 3        0 FALSE        note_on          NaN    0   36      101       9    NaN
#> 4        0  TRUE      set_tempo          NaN    0  NaN      NaN     NaN 545454
#> 5        0  TRUE time_signature          NaN    0  NaN      NaN     NaN    NaN
#> 6        0 FALSE       note_off          NaN  240   38      101       9    NaN
#> 7        0 FALSE       note_off          NaN    0   36      101       9    NaN
#> 8        0 FALSE        note_on          NaN 1200   38      101       9    NaN
#> 9        0 FALSE       note_off          NaN  240   38      101       9    NaN
#> 10       0 FALSE        note_on          NaN  240   38      101       9    NaN
#> 11       0 FALSE        note_on          NaN    0   36      101       9    NaN
#> 12       0 FALSE       note_off          NaN  240   38      101       9    NaN
#> 13       0 FALSE       note_off          NaN    0   36      101       9    NaN
#> 14       0 FALSE        note_on          NaN 1200   38      101       9    NaN
#> 15       0 FALSE       note_off          NaN  240   38      101       9    NaN
#> 16       0 FALSE        note_on          NaN  240   38      101       9    NaN
#> 17       0 FALSE        note_on          NaN    0   36      101       9    NaN
#> 18       0 FALSE       note_off          NaN  240   38      101       9    NaN
#> 19       0 FALSE       note_off          NaN    0   36      101       9    NaN
#> 20       0 FALSE        note_on          NaN 1200   38      101       9    NaN
#>    numerator denominator clocks_per_click notated_32nd_notes_per_beat
#> 1        NaN         NaN              NaN                         NaN
#> 2        NaN         NaN              NaN                         NaN
#> 3        NaN         NaN              NaN                         NaN
#> 4        NaN         NaN              NaN                         NaN
#> 5          4           4               24                           8
#> 6        NaN         NaN              NaN                         NaN
#> 7        NaN         NaN              NaN                         NaN
#> 8        NaN         NaN              NaN                         NaN
#> 9        NaN         NaN              NaN                         NaN
#> 10       NaN         NaN              NaN                         NaN
#> 11       NaN         NaN              NaN                         NaN
#> 12       NaN         NaN              NaN                         NaN
#> 13       NaN         NaN              NaN                         NaN
#> 14       NaN         NaN              NaN                         NaN
#> 15       NaN         NaN              NaN                         NaN
#> 16       NaN         NaN              NaN                         NaN
#> 17       NaN         NaN              NaN                         NaN
#> 18       NaN         NaN              NaN                         NaN
#> 19       NaN         NaN              NaN                         NaN
#> 20       NaN         NaN              NaN                         NaN
```

``` r
dfm <- tab_measures(df, ticks_per_beat)
```

``` r
dfm %>% 
    mt$split_df()  %->% c(df_meta, df_notes)
```

``` r
df_meta
#>      i_track meta           type         name time  tempo numerator denominator
#> 0          0 TRUE     track_name Drum Machine    0    NaN       NaN         NaN
#> 3          0 TRUE      set_tempo          NaN    0 545454       NaN         NaN
#> 4          0 TRUE time_signature          NaN    0    NaN         4           4
#> 2151       0 TRUE   end_of_track          NaN  241    NaN       NaN         NaN
#> 2152       1 TRUE     track_name         FM-4    0    NaN       NaN         NaN
#> 2435       1 TRUE   end_of_track          NaN 1954    NaN       NaN         NaN
#> 2436       2 TRUE     track_name         FM-4    0    NaN       NaN         NaN
#> 4969       2 TRUE   end_of_track          NaN  202    NaN       NaN         NaN
#>      clocks_per_click notated_32nd_notes_per_beat  ticks        t        m
#> 0                 NaN                         NaN      0   0.0000   0.0000
#> 3                 NaN                         NaN      0   0.0000   0.0000
#> 4                  24                           8      0   0.0000   0.0000
#> 2151              NaN                         NaN 368641 209.4549 384.0010
#> 2152              NaN                         NaN      0   0.0000   0.0000
#> 2435              NaN                         NaN 371697 211.1913 387.1844
#> 2436              NaN                         NaN      0   0.0000   0.0000
#> 4969              NaN                         NaN 368641 209.4549 384.0010
#>             b i_note
#> 0       0.000      0
#> 3       0.000      0
#> 4       0.000      0
#> 2151 1536.004      0
#> 2152    0.000      0
#> 2435 1548.737      0
#> 2436    0.000      0
#> 4969 1536.004      0
```

``` r
df_notes %>% as_tibble()
#> # A tibble: 4,962 x 12
#>    i_track meta  type   time  note velocity channel ticks     t     m     b
#>      <dbl> <lgl> <chr> <dbl> <dbl>    <dbl>   <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1       0 FALSE note…     0    38      101       9     0 0      0       0 
#>  2       0 FALSE note…     0    36      101       9     0 0      0       0 
#>  3       0 FALSE note…   240    38      101       9   240 0.136  0.25    1 
#>  4       0 FALSE note…     0    36      101       9   240 0.136  0.25    1 
#>  5       0 FALSE note…  1200    38      101       9  1440 0.818  1.5     6 
#>  6       0 FALSE note…   240    38      101       9  1680 0.955  1.75    7.
#>  7       0 FALSE note…   240    38      101       9  1920 1.09   2       8 
#>  8       0 FALSE note…     0    36      101       9  1920 1.09   2       8 
#>  9       0 FALSE note…   240    38      101       9  2160 1.23   2.25    9 
#> 10       0 FALSE note…     0    36      101       9  2160 1.23   2.25    9 
#> # … with 4,952 more rows, and 1 more variable: i_note <int>
```

### Pivot note dataframe to wide

``` r
df_not_notes <- 
  df_notes %>% 
  dplyr::filter(!stringr::str_detect(.data$type, "^note_o[nf]f?$")) 

df_notes_wide <-
  df_notes %>% 
  dplyr::filter(stringr::str_detect(.data$type, "^note_o[nf]f?$")) %>%
  # tab_measures(df_meta, df_notes, ticks_per_beat) %>%
  widen_events() %>%
  left_join(pyramidi::midi_defs)
#> Joining, by = "note"
df_notes_wide
#> # A tibble: 2,481 x 17
#>    i_track channel  note i_note m_note_on m_note_off b_note_on b_note_off
#>      <dbl>   <dbl> <dbl>  <int>     <dbl>      <dbl>     <dbl>      <dbl>
#>  1       0       9    38      1       0         0.25        0          1 
#>  2       0       9    36      1       0         0.25        0          1 
#>  3       0       9    38      2       1.5       1.75        6          7.
#>  4       0       9    38      3       2         2.25        8          9 
#>  5       0       9    36      2       2         2.25        8          9 
#>  6       0       9    38      4       3.5       3.75       14.        15 
#>  7       0       9    38      5       4         4.25       16         17.
#>  8       0       9    36      3       4         4.25       16         17.
#>  9       0       9    38      6       5.5       5.75       22         23.
#> 10       0       9    38      7       6         6.25       24         25 
#> # … with 2,471 more rows, and 9 more variables: t_note_on <dbl>,
#> #   t_note_off <dbl>, ticks_note_on <dbl>, ticks_note_off <dbl>,
#> #   time_note_on <dbl>, time_note_off <dbl>, velocity_note_on <dbl>,
#> #   velocity_note_off <dbl>, note_name <fct>
```

### Plot the midi file information in a piano roll plot

``` r
p1 <- df_notes_wide %>%
  ggplot() +
  geom_segment(
    aes(
      x = m_note_on,
      y = note_name,
      xend = m_note_off,
      yend = note_name,
      color = velocity_note_on
    )
  ) +
  # each midi track is printed into its own facet:
  facet_wrap( ~ i_track,
              ncol = 1,
              scales = "free_y")
p1
```

<img src="man/figures/README-midi_piano_roll-1.png" width="100%" />

### Pivot note data frame back to long format

``` r
df_notes_out <-
  df_notes_wide %>%
  select(c("i_track",
           # "name",
           "channel", "note", "i_note"), matches("_note_o[nf]f?$")) %>%
  pivot_longer(matches("_note_o[nf]f?$"),
               names_to = c(".value", "type"),
               names_pattern = "(.+?)_(.*)") %>%
  mutate(meta = FALSE)


df_notes_out <-
  df_notes_out %>%
  full_join(df_meta) %>%
  full_join(df_not_notes) %>%
  arrange(i_track, ticks) %>%
  group_by(i_track) %>%
  mutate(time = ticks - lag(ticks) %>% {.[1] = 0; .}) %>%
  ungroup()
#> Joining, by = c("i_track", "i_note", "type", "m", "b", "t", "ticks", "time", "meta")
#> Joining, by = c("i_track", "channel", "note", "i_note", "type", "m", "b", "t", "ticks", "time", "velocity", "meta")

df_notes_out
#> # A tibble: 4,970 x 18
#>    i_track channel  note i_note type      m     b     t ticks  time velocity
#>      <dbl>   <dbl> <dbl>  <int> <chr> <dbl> <dbl> <dbl> <dbl> <dbl>    <dbl>
#>  1       0       9    38      1 note…  0       0  0         0     0      101
#>  2       0       9    36      1 note…  0       0  0         0     0      101
#>  3       0      NA    NA      0 trac…  0       0  0         0     0       NA
#>  4       0      NA    NA      0 set_…  0       0  0         0     0       NA
#>  5       0      NA    NA      0 time…  0       0  0         0     0       NA
#>  6       0       9    38      1 note…  0.25    1  0.136   240   240      101
#>  7       0       9    36      1 note…  0.25    1  0.136   240     0      101
#>  8       0       9    38      2 note…  1.5     6  0.818  1440  1200      101
#>  9       0       9    38      2 note…  1.75    7. 0.955  1680   240      101
#> 10       0       9    38      3 note…  2       8  1.09   1920   240      101
#> # … with 4,960 more rows, and 7 more variables: meta <lgl>, name <list>,
#> #   tempo <dbl>, numerator <dbl>, denominator <dbl>, clocks_per_click <dbl>,
#> #   notated_32nd_notes_per_beat <dbl>
```

### Write midi dataframe back to a midi file

``` r
dfc2 <-
  df_notes_out %>%
  select(names(df)) %>%
  # mutate_if(is_numeric, as.integer) %>%
  mutate_if(is.numeric, ~ifelse(is.na(.), NaN, .)) %>%
  mt$compact_df()
```

``` r
dfc2
dfc2 %>%
  mt$df_to_midi(ticks_per_beat,
                "test.mid")
```

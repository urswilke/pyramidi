
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pyramidi

<!-- badges: start -->

<!-- badges: end -->

The goal of pyramidi is to read in dataframes generated by the python
package miditapyr. These dataframes contain midi data. Then the midi
information (one line per event) can be translated into a wide format
(one line per note). This facilitates plotting piano roll plots. These
dataframes can then be written back to midi files (again using
miditapyr).

## Installation

You can install the released version of pyramidi from
[github](https://github.com/urswilke/pyramidi) with:

``` r
## install remotes package if it's not already
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

## install dev version of rtweettree from github
remotes::install_github("UrsWilke/pyramidi")
```

## Basic usage

### Extract midi file information into a dataframe

``` r
library(pyramidi)
library(zeallot)
mid_file <- '/home/chief/Bitwig Studio/Projects/bossa_raw/midi_arpeggiated.mid'
mt <- reticulate::import("miditapyr")
mido <- reticulate::import("mido")
 
mido$MidiFile(mid_file) %>%
  mt$mido_midi_df()  %->% c(df_meta, df_notes, ticks_per_beat)
df_notes_wide <-  
  tab_measures(df_meta, df_notes, ticks_per_beat) %>%
  widen_events() %>%
  dplyr::left_join(pyramidi::midi_defs)
#> Joining, by = "note"
df_notes_wide
#> # A tibble: 2,481 x 18
#>    i_track name  channel  note i_note m_note_on m_note_off b_note_on b_note_off
#>      <dbl> <chr>   <dbl> <dbl>  <int>     <dbl>      <dbl>     <dbl>      <dbl>
#>  1       1 nan         9    38      1       0         0.25        0          1 
#>  2       1 nan         9    36      1       0         0.25        0          1 
#>  3       1 nan         9    38      2       1.5       1.75        6          7.
#>  4       1 nan         9    38      3       2         2.25        8          9 
#>  5       1 nan         9    36      2       2         2.25        8          9 
#>  6       1 nan         9    38      4       3.5       3.75       14.        15 
#>  7       1 nan         9    38      5       4         4.25       16         17.
#>  8       1 nan         9    36      3       4         4.25       16         17.
#>  9       1 nan         9    38      6       5.5       5.75       22         23.
#> 10       1 nan         9    38      7       6         6.25       24         25 
#> # … with 2,471 more rows, and 9 more variables: t_note_on <dbl>,
#> #   t_note_off <dbl>, ticks_note_on <dbl>, ticks_note_off <dbl>,
#> #   time_note_on <dbl>, time_note_off <dbl>, velocity_note_on <dbl>,
#> #   velocity_note_off <dbl>, note_name <fct>
```

### Plot the midi file information in a piano roll plot

``` r
p1 <- df_notes_wide %>%
  ggplot2::ggplot() +
  ggplot2::geom_segment(ggplot2::aes(x = m_note_on,
                                     y = note_name,
                                     xend = m_note_off,
                                     yend = note_name,
                                     color = velocity_note_on)) +
# each midi track is printed into its own facet
  ggplot2::facet_wrap(~ i_track,
                      ncol=1,
                      scales = "free_y")
p1
```

<img src="man/figures/README-midi_piano roll-1.png" width="100%" />

# meta events work

    Code
      tab_time_sig(df_meta)
    Condition
      Warning:
      Use of .data in tidyselect expressions was deprecated in tidyselect 1.2.0.
      i Please use `"numerator"` instead of `.data$numerator`
      Warning:
      Use of .data in tidyselect expressions was deprecated in tidyselect 1.2.0.
      i Please use `"denominator"` instead of `.data$denominator`
      Warning:
      Use of .data in tidyselect expressions was deprecated in tidyselect 1.2.0.
      i Please use `"clocks_per_click"` instead of `.data$clocks_per_click`
      Warning:
      Use of .data in tidyselect expressions was deprecated in tidyselect 1.2.0.
      i Please use `"notated_32nd_notes_per_beat"` instead of `.data$notated_32nd_notes_per_beat`
    Output
      # A tibble: 1 x 4
        numerator denominator clocks_per_click notated_32nd_notes_per_beat
            <dbl>       <dbl>            <dbl>                       <dbl>
      1         4           4               24                           8

---

    Code
      dfm
    Output
      # A tibble: 268 x 15
         i_track meta  type     name   note velocity channel ticks     b i_note  tempo
           <dbl> <lgl> <chr>    <chr> <dbl>    <dbl>   <dbl> <dbl> <dbl>  <int>  <dbl>
       1       0 TRUE  track_n~ drum~   NaN      NaN     NaN     0     0      0    NaN
       2       0 FALSE note_on  <NA>     43       72       9     0     0      1    NaN
       3       0 FALSE note_on  <NA>     39       64       9     0     0      1    NaN
       4       0 FALSE note_on  <NA>     36      101       9     0     0      1    NaN
       5       0 TRUE  set_tem~ <NA>    NaN      NaN     NaN     0     0      0 666666
       6       0 TRUE  time_si~ <NA>    NaN      NaN     NaN     0     0      0    NaN
       7       0 FALSE note_off <NA>     43       72       9   240     1      1    NaN
       8       0 FALSE note_off <NA>     39       64       9   240     1      1    NaN
       9       0 FALSE note_off <NA>     36      101       9   240     1      1    NaN
      10       0 FALSE note_on  <NA>     42      101       9   480     2      1    NaN
      # i 258 more rows
      # i 4 more variables: numerator <dbl>, denominator <dbl>,
      #   clocks_per_click <dbl>, notated_32nd_notes_per_beat <dbl>

---

    Code
      dfw
    Output
      # A tibble: 138 x 29
         i_track meta  name   note channel i_note tempo numerator denominator
           <dbl> <lgl> <chr> <dbl>   <dbl>  <int> <dbl>     <dbl>       <dbl>
       1       0 FALSE <NA>     43       9      1   NaN       NaN         NaN
       2       0 FALSE <NA>     39       9      1   NaN       NaN         NaN
       3       0 FALSE <NA>     36       9      1   NaN       NaN         NaN
       4       0 FALSE <NA>     42       9      1   NaN       NaN         NaN
       5       0 FALSE <NA>     38       9      1   NaN       NaN         NaN
       6       0 FALSE <NA>     43       9      2   NaN       NaN         NaN
       7       0 FALSE <NA>     36       9      2   NaN       NaN         NaN
       8       0 FALSE <NA>     43       9      3   NaN       NaN         NaN
       9       0 FALSE <NA>     42       9      2   NaN       NaN         NaN
      10       0 FALSE <NA>     43       9      4   NaN       NaN         NaN
      # i 128 more rows
      # i 20 more variables: clocks_per_click <dbl>,
      #   notated_32nd_notes_per_beat <dbl>, velocity_track_name <dbl>,
      #   velocity_note_on <dbl>, velocity_set_tempo <dbl>,
      #   velocity_time_signature <dbl>, velocity_note_off <dbl>,
      #   velocity_end_of_track <dbl>, ticks_track_name <dbl>, ticks_note_on <dbl>,
      #   ticks_set_tempo <dbl>, ticks_time_signature <dbl>, ...


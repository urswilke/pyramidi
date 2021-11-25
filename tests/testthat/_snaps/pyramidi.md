# meta events work

    Code
      tab_time_sig(df_meta)
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
           <dbl> <lgl> <chr>    <lis> <dbl>    <dbl>   <dbl> <dbl> <dbl>  <int>  <dbl>
       1       0 TRUE  track_n~ <chr~   NaN      NaN     NaN     0     0      0    NaN
       2       0 FALSE note_on  <dbl~    43       72       9     0     0      1    NaN
       3       0 FALSE note_on  <dbl~    39       64       9     0     0      1    NaN
       4       0 FALSE note_on  <dbl~    36      101       9     0     0      1    NaN
       5       0 TRUE  set_tem~ <dbl~   NaN      NaN     NaN     0     0      0 666666
       6       0 TRUE  time_si~ <dbl~   NaN      NaN     NaN     0     0      0    NaN
       7       0 FALSE note_off <dbl~    43       72       9   240     1      1    NaN
       8       0 FALSE note_off <dbl~    39       64       9   240     1      1    NaN
       9       0 FALSE note_off <dbl~    36      101       9   240     1      1    NaN
      10       0 FALSE note_on  <dbl~    42      101       9   480     2      1    NaN
      # ... with 258 more rows, and 4 more variables: numerator <dbl>,
      #   denominator <dbl>, clocks_per_click <dbl>,
      #   notated_32nd_notes_per_beat <dbl>

---

    Code
      dfw
    Output
      # A tibble: 138 x 29
         i_track meta  name       note channel i_note tempo numerator denominator
           <dbl> <lgl> <list>    <dbl>   <dbl>  <int> <dbl>     <dbl>       <dbl>
       1       0 FALSE <dbl [1]>    43       9      1   NaN       NaN         NaN
       2       0 FALSE <dbl [1]>    39       9      1   NaN       NaN         NaN
       3       0 FALSE <dbl [1]>    36       9      1   NaN       NaN         NaN
       4       0 FALSE <dbl [1]>    42       9      1   NaN       NaN         NaN
       5       0 FALSE <dbl [1]>    38       9      1   NaN       NaN         NaN
       6       0 FALSE <dbl [1]>    43       9      2   NaN       NaN         NaN
       7       0 FALSE <dbl [1]>    36       9      2   NaN       NaN         NaN
       8       0 FALSE <dbl [1]>    43       9      3   NaN       NaN         NaN
       9       0 FALSE <dbl [1]>    42       9      2   NaN       NaN         NaN
      10       0 FALSE <dbl [1]>    43       9      4   NaN       NaN         NaN
      # ... with 128 more rows, and 20 more variables: clocks_per_click <dbl>,
      #   notated_32nd_notes_per_beat <dbl>, velocity_track_name <dbl>,
      #   velocity_note_on <dbl>, velocity_set_tempo <dbl>,
      #   velocity_time_signature <dbl>, velocity_note_off <dbl>,
      #   velocity_end_of_track <dbl>, ticks_track_name <dbl>, ticks_note_on <dbl>,
      #   ticks_set_tempo <dbl>, ticks_time_signature <dbl>, ticks_note_off <dbl>,
      #   ticks_end_of_track <dbl>, b_track_name <dbl>, b_note_on <dbl>, ...


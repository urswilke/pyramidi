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
      # A tibble: 268 x 18
         i_track meta  type           name   time  note velocity channel  tempo numerator
           <dbl> <lgl> <chr>          <lis> <dbl> <dbl>    <dbl>   <dbl>  <dbl>     <dbl>
       1       0 TRUE  track_name     <chr~     0   NaN      NaN     NaN    NaN       NaN
       2       0 FALSE note_on        <dbl~     0    43       72       9    NaN       NaN
       3       0 FALSE note_on        <dbl~     0    39       64       9    NaN       NaN
       4       0 FALSE note_on        <dbl~     0    36      101       9    NaN       NaN
       5       0 TRUE  set_tempo      <dbl~     0   NaN      NaN     NaN 666666       NaN
       6       0 TRUE  time_signature <dbl~     0   NaN      NaN     NaN    NaN         4
       7       0 FALSE note_off       <dbl~   240    43       72       9    NaN       NaN
       8       0 FALSE note_off       <dbl~     0    39       64       9    NaN       NaN
       9       0 FALSE note_off       <dbl~     0    36      101       9    NaN       NaN
      10       0 FALSE note_on        <dbl~   240    42      101       9    NaN       NaN
      # ... with 258 more rows, and 8 more variables: denominator <dbl>,
      #   clocks_per_click <dbl>, notated_32nd_notes_per_beat <dbl>, ticks <dbl>,
      #   t <dbl>, m <dbl>, b <dbl>, i_note <int>

---

    Code
      dfw
    Output
      # A tibble: 138 x 47
         i_track meta  name       note channel tempo numerator denominator
           <dbl> <lgl> <list>    <dbl>   <dbl> <dbl>     <dbl>       <dbl>
       1       0 FALSE <dbl [1]>    43       9   NaN       NaN         NaN
       2       0 FALSE <dbl [1]>    39       9   NaN       NaN         NaN
       3       0 FALSE <dbl [1]>    36       9   NaN       NaN         NaN
       4       0 FALSE <dbl [1]>    42       9   NaN       NaN         NaN
       5       0 FALSE <dbl [1]>    38       9   NaN       NaN         NaN
       6       0 FALSE <dbl [1]>    43       9   NaN       NaN         NaN
       7       0 FALSE <dbl [1]>    36       9   NaN       NaN         NaN
       8       0 FALSE <dbl [1]>    43       9   NaN       NaN         NaN
       9       0 FALSE <dbl [1]>    42       9   NaN       NaN         NaN
      10       0 FALSE <dbl [1]>    43       9   NaN       NaN         NaN
      # ... with 128 more rows, and 39 more variables: clocks_per_click <dbl>,
      #   notated_32nd_notes_per_beat <dbl>, i_note <int>, time_track_name <dbl>,
      #   time_note_on <dbl>, time_set_tempo <dbl>, time_time_signature <dbl>,
      #   time_note_off <dbl>, time_end_of_track <dbl>, velocity_track_name <dbl>,
      #   velocity_note_on <dbl>, velocity_set_tempo <dbl>,
      #   velocity_time_signature <dbl>, velocity_note_off <dbl>,
      #   velocity_end_of_track <dbl>, ticks_track_name <dbl>, ...


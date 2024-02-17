# MidiFramer seems to work

    Code
      c("midi_frame_mod", "df_notes_wide", "df_not_notes", "df_meta", "df_notes_long",
        "dfm", "mf") %>% purrr::set_names() %>% purrr::map(~ mfr6[[.x]])
    Output
      $midi_frame_mod
      # A tibble: 268 x 13
         i_track channel  note type  velocity meta  name   tempo numerator denominator
           <dbl>   <dbl> <dbl> <chr>    <dbl> <lgl> <chr>  <dbl>     <dbl>       <dbl>
       1       0       9    43 note~       72 FALSE <NA>      NA        NA          NA
       2       0       9    39 note~       64 FALSE <NA>      NA        NA          NA
       3       0       9    36 note~      101 FALSE <NA>      NA        NA          NA
       4       0      NA    NA trac~       NA TRUE  drum~    NaN       NaN         NaN
       5       0      NA    NA set_~       NA TRUE  <NA>  666666       NaN         NaN
       6       0      NA    NA time~       NA TRUE  <NA>     NaN         4           4
       7       0       9    43 note~       72 FALSE <NA>      NA        NA          NA
       8       0       9    39 note~       64 FALSE <NA>      NA        NA          NA
       9       0       9    36 note~      101 FALSE <NA>      NA        NA          NA
      10       0       9    42 note~      101 FALSE <NA>      NA        NA          NA
      # i 258 more rows
      # i 3 more variables: clocks_per_click <dbl>,
      #   notated_32nd_notes_per_beat <dbl>, time <dbl>
      
      $df_notes_wide
      # A tibble: 130 x 11
         i_track meta   note channel i_note velocity_note_on velocity_note_off
           <dbl> <lgl> <dbl>   <dbl>  <int>            <dbl>             <dbl>
       1       0 FALSE    43       9      1               72                72
       2       0 FALSE    39       9      1               64                64
       3       0 FALSE    36       9      1              101               101
       4       0 FALSE    42       9      1              101               101
       5       0 FALSE    38       9      1              101               101
       6       0 FALSE    43       9      2               64                64
       7       0 FALSE    36       9      2              101               101
       8       0 FALSE    43       9      3               60                60
       9       0 FALSE    42       9      2              101               101
      10       0 FALSE    43       9      4               60                60
      # i 120 more rows
      # i 4 more variables: ticks_note_on <dbl>, ticks_note_off <dbl>,
      #   b_note_on <dbl>, b_note_off <dbl>
      
      $df_not_notes
      [1] i_track  meta     type     note     velocity channel  ticks    b       
      [9] i_note  
      <0 rows> (or 0-length row.names)
      
      $df_meta
          i_track meta           type         name ticks        b i_note  tempo
      0         0 TRUE     track_name drum-t1-1-t1     0  0.00000      0    NaN
      4         0 TRUE      set_tempo         <NA>     0  0.00000      0 666666
      5         0 TRUE time_signature         <NA>     0  0.00000      0    NaN
      159       0 TRUE   end_of_track         <NA> 15361 64.00417      0    NaN
      160       1 TRUE     track_name   Audio+MIDI     0  0.00000      0    NaN
      185       1 TRUE   end_of_track         <NA> 15361 64.00417      0    NaN
      186       2 TRUE     track_name Audio+MIDI 1     0  0.00000      0    NaN
      267       2 TRUE   end_of_track         <NA> 15361 64.00417      0    NaN
          numerator denominator clocks_per_click notated_32nd_notes_per_beat
      0         NaN         NaN              NaN                         NaN
      4         NaN         NaN              NaN                         NaN
      5           4           4               24                           8
      159       NaN         NaN              NaN                         NaN
      160       NaN         NaN              NaN                         NaN
      185       NaN         NaN              NaN                         NaN
      186       NaN         NaN              NaN                         NaN
      267       NaN         NaN              NaN                         NaN
      
      $df_notes_long
      # A tibble: 260 x 9
         i_track channel  note i_note type     velocity ticks     b meta 
           <dbl>   <dbl> <dbl>  <int> <chr>       <dbl> <dbl> <dbl> <lgl>
       1       0       9    43      1 note_on        72     0     0 FALSE
       2       0       9    43      1 note_off       72   240     1 FALSE
       3       0       9    39      1 note_on        64     0     0 FALSE
       4       0       9    39      1 note_off       64   240     1 FALSE
       5       0       9    36      1 note_on       101     0     0 FALSE
       6       0       9    36      1 note_off      101   240     1 FALSE
       7       0       9    42      1 note_on       101   480     2 FALSE
       8       0       9    42      1 note_off      101   720     3 FALSE
       9       0       9    38      1 note_on       101   480     2 FALSE
      10       0       9    38      1 note_off      101   720     3 FALSE
      # i 250 more rows
      
      $dfm
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
      
      $mf
      <miditapyr.midi_frame.MidiFrames object at <stochastic term :)>>
      

---

    Code
      list(mfr6$mf$midi_frame_raw, mfr6$mf$midi_frame_unnested$df, mfr6$mf$
        midi_frame_nested$df) %>% purrr::map(head, 20)
    Output
      [[1]]
         i_track  meta                            msg
      1        0  TRUE    track_name, drum-t1-1-t1, 0
      2        0 FALSE          note_on, 0, 43, 72, 9
      3        0 FALSE          note_on, 0, 39, 64, 9
      4        0 FALSE         note_on, 0, 36, 101, 9
      5        0  TRUE           set_tempo, 666666, 0
      6        0  TRUE time_signature, 4, 4, 24, 8, 0
      7        0 FALSE       note_off, 240, 43, 72, 9
      8        0 FALSE         note_off, 0, 39, 64, 9
      9        0 FALSE        note_off, 0, 36, 101, 9
      10       0 FALSE       note_on, 240, 42, 101, 9
      11       0 FALSE         note_on, 0, 38, 101, 9
      12       0 FALSE        note_on, 240, 43, 64, 9
      13       0 FALSE        note_off, 0, 42, 101, 9
      14       0 FALSE        note_off, 0, 38, 101, 9
      15       0 FALSE       note_off, 240, 43, 64, 9
      16       0 FALSE         note_on, 0, 36, 101, 9
      17       0 FALSE      note_off, 240, 36, 101, 9
      18       0 FALSE        note_on, 240, 43, 60, 9
      19       0 FALSE         note_on, 0, 42, 101, 9
      20       0 FALSE       note_off, 240, 43, 60, 9
      
      [[2]]
         i_track  meta           type         name time note velocity channel  tempo
      1        0  TRUE     track_name drum-t1-1-t1    0  NaN      NaN     NaN    NaN
      2        0 FALSE        note_on         <NA>    0   43       72       9    NaN
      3        0 FALSE        note_on         <NA>    0   39       64       9    NaN
      4        0 FALSE        note_on         <NA>    0   36      101       9    NaN
      5        0  TRUE      set_tempo         <NA>    0  NaN      NaN     NaN 666666
      6        0  TRUE time_signature         <NA>    0  NaN      NaN     NaN    NaN
      7        0 FALSE       note_off         <NA>  240   43       72       9    NaN
      8        0 FALSE       note_off         <NA>    0   39       64       9    NaN
      9        0 FALSE       note_off         <NA>    0   36      101       9    NaN
      10       0 FALSE        note_on         <NA>  240   42      101       9    NaN
      11       0 FALSE        note_on         <NA>    0   38      101       9    NaN
      12       0 FALSE        note_on         <NA>  240   43       64       9    NaN
      13       0 FALSE       note_off         <NA>    0   42      101       9    NaN
      14       0 FALSE       note_off         <NA>    0   38      101       9    NaN
      15       0 FALSE       note_off         <NA>  240   43       64       9    NaN
      16       0 FALSE        note_on         <NA>    0   36      101       9    NaN
      17       0 FALSE       note_off         <NA>  240   36      101       9    NaN
      18       0 FALSE        note_on         <NA>  240   43       60       9    NaN
      19       0 FALSE        note_on         <NA>    0   42      101       9    NaN
      20       0 FALSE       note_off         <NA>  240   43       60       9    NaN
         numerator denominator clocks_per_click notated_32nd_notes_per_beat
      1        NaN         NaN              NaN                         NaN
      2        NaN         NaN              NaN                         NaN
      3        NaN         NaN              NaN                         NaN
      4        NaN         NaN              NaN                         NaN
      5        NaN         NaN              NaN                         NaN
      6          4           4               24                           8
      7        NaN         NaN              NaN                         NaN
      8        NaN         NaN              NaN                         NaN
      9        NaN         NaN              NaN                         NaN
      10       NaN         NaN              NaN                         NaN
      11       NaN         NaN              NaN                         NaN
      12       NaN         NaN              NaN                         NaN
      13       NaN         NaN              NaN                         NaN
      14       NaN         NaN              NaN                         NaN
      15       NaN         NaN              NaN                         NaN
      16       NaN         NaN              NaN                         NaN
      17       NaN         NaN              NaN                         NaN
      18       NaN         NaN              NaN                         NaN
      19       NaN         NaN              NaN                         NaN
      20       NaN         NaN              NaN                         NaN
      
      [[3]]
         i_track  meta                            msg
      1        0  TRUE    track_name, drum-t1-1-t1, 0
      2        0 FALSE          note_on, 0, 43, 72, 9
      3        0 FALSE          note_on, 0, 39, 64, 9
      4        0 FALSE         note_on, 0, 36, 101, 9
      5        0  TRUE           set_tempo, 0, 666666
      6        0  TRUE time_signature, 0, 4, 4, 24, 8
      7        0 FALSE       note_off, 240, 43, 72, 9
      8        0 FALSE         note_off, 0, 39, 64, 9
      9        0 FALSE        note_off, 0, 36, 101, 9
      10       0 FALSE       note_on, 240, 42, 101, 9
      11       0 FALSE         note_on, 0, 38, 101, 9
      12       0 FALSE        note_on, 240, 43, 64, 9
      13       0 FALSE        note_off, 0, 42, 101, 9
      14       0 FALSE        note_off, 0, 38, 101, 9
      15       0 FALSE       note_off, 240, 43, 64, 9
      16       0 FALSE         note_on, 0, 36, 101, 9
      17       0 FALSE      note_off, 240, 36, 101, 9
      18       0 FALSE        note_on, 240, 43, 60, 9
      19       0 FALSE         note_on, 0, 42, 101, 9
      20       0 FALSE       note_off, 240, 43, 60, 9
      

# MidiFramer$update_notes_wide() seems to work

    Code
      mfr6$mf$midi_frame_nested$df
    Output
        i_track  meta                            msg
      1       0 FALSE          9, 43, note_on, 72, 0
      2       0 FALSE          9, 39, note_on, 64, 0
      3       0  TRUE    track_name, drum-t1-1-t1, 0
      4       0  TRUE           set_tempo, 666666, 0
      5       0  TRUE time_signature, 4, 4, 24, 8, 0
      6       0 FALSE       9, 43, note_off, 72, 240
      7       0 FALSE         9, 39, note_off, 64, 0
      8       0  TRUE            end_of_track, 15121

# Changing params and recalculating works.

    Code
      mfr6$df_notes_wide
    Output
      # A tibble: 2 x 17
        i_track channel  note meta  i_note velocity_note_on velocity_note_off
          <dbl>   <dbl> <dbl> <lgl>  <int>            <dbl>             <dbl>
      1       0       9    43 FALSE      1               72                72
      2       0       9    39 FALSE      1               64                64
      # i 10 more variables: time_note_on <dbl>, time_note_off <dbl>,
      #   ticks_note_on <dbl>, ticks_note_off <dbl>, t_note_on <dbl>,
      #   t_note_off <dbl>, m_note_on <dbl>, m_note_off <dbl>, b_note_on <dbl>,
      #   b_note_off <dbl>


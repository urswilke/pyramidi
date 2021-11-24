# MidiFramer seems to work

    Code
      c("midi_frame_mod", "df_notes_wide", "df_not_notes", "df_meta", "df_notes_long",
        "dfm", "mf", "midi_file_string") %>% purrr::set_names() %>% purrr::map(~mfr6[[
        .x]])
    Output
      $midi_frame_mod
      # A tibble: 268 x 13
         i_track channel  note type        time velocity meta  name    tempo numerator
           <dbl>   <dbl> <dbl> <chr>      <dbl>    <dbl> <lgl> <list>  <dbl>     <dbl>
       1       0       9    43 note_on        0       72 FALSE <NULL>     NA        NA
       2       0       9    39 note_on        0       64 FALSE <NULL>     NA        NA
       3       0       9    36 note_on        0      101 FALSE <NULL>     NA        NA
       4       0      NA    NA track_name     0       NA TRUE  <chr ~    NaN       NaN
       5       0      NA    NA set_tempo      0       NA TRUE  <dbl ~ 666666       NaN
       6       0      NA    NA time_sign~     0       NA TRUE  <dbl ~    NaN         4
       7       0       9    43 note_off     240       72 FALSE <NULL>     NA        NA
       8       0       9    39 note_off       0       64 FALSE <NULL>     NA        NA
       9       0       9    36 note_off       0      101 FALSE <NULL>     NA        NA
      10       0       9    42 note_on      240      101 FALSE <NULL>     NA        NA
      # ... with 258 more rows, and 3 more variables: denominator <dbl>,
      #   clocks_per_click <dbl>, notated_32nd_notes_per_beat <dbl>
      
      $df_notes_wide
      # A tibble: 130 x 17
         i_track meta   note channel i_note time_note_on time_note_off
           <dbl> <lgl> <dbl>   <dbl>  <int>        <dbl>         <dbl>
       1       0 FALSE    43       9      1            0           240
       2       0 FALSE    39       9      1            0             0
       3       0 FALSE    36       9      1            0             0
       4       0 FALSE    42       9      1          240             0
       5       0 FALSE    38       9      1            0             0
       6       0 FALSE    43       9      2          240           240
       7       0 FALSE    36       9      2            0           240
       8       0 FALSE    43       9      3          240           240
       9       0 FALSE    42       9      2            0             0
      10       0 FALSE    43       9      4          240           240
      # ... with 120 more rows, and 10 more variables: velocity_note_on <dbl>,
      #   velocity_note_off <dbl>, ticks_note_on <dbl>, ticks_note_off <dbl>,
      #   t_note_on <dbl>, t_note_off <dbl>, m_note_on <dbl>, m_note_off <dbl>,
      #   b_note_on <dbl>, b_note_off <dbl>
      
      $df_not_notes
       [1] i_track  meta     type     time     note     velocity channel  ticks   
       [9] t        m        b        i_note  
      <0 rows> (or 0-length row.names)
      
      $df_meta
          i_track meta           type         name time  tempo numerator denominator
      0         0 TRUE     track_name drum-t1-1-t1    0    NaN       NaN         NaN
      4         0 TRUE      set_tempo          NaN    0 666666       NaN         NaN
      5         0 TRUE time_signature          NaN    0    NaN         4           4
      159       0 TRUE   end_of_track          NaN    1    NaN       NaN         NaN
      160       1 TRUE     track_name   Audio+MIDI    0    NaN       NaN         NaN
      185       1 TRUE   end_of_track          NaN    1    NaN       NaN         NaN
      186       2 TRUE     track_name Audio+MIDI 1    0    NaN       NaN         NaN
      267       2 TRUE   end_of_track          NaN    1    NaN       NaN         NaN
          clocks_per_click notated_32nd_notes_per_beat ticks        t        m
      0                NaN                         NaN     0  0.00000  0.00000
      4                NaN                         NaN     0  0.00000  0.00000
      5                 24                           8     0  0.00000  0.00000
      159              NaN                         NaN 15361 10.66735 16.00104
      160              NaN                         NaN     0  0.00000  0.00000
      185              NaN                         NaN 15361 10.66735 16.00104
      186              NaN                         NaN     0  0.00000  0.00000
      267              NaN                         NaN 15361 10.66735 16.00104
                 b i_note
      0    0.00000      0
      4    0.00000      0
      5    0.00000      0
      159 64.00417      0
      160  0.00000      0
      185 64.00417      0
      186  0.00000      0
      267 64.00417      0
      
      $df_notes_long
      # A tibble: 260 x 12
         i_track channel  note i_note type      time velocity ticks     t     m     b
           <dbl>   <dbl> <dbl>  <int> <chr>    <dbl>    <dbl> <dbl> <dbl> <dbl> <dbl>
       1       0       9    43      1 note_on      0       72     0 0      0        0
       2       0       9    43      1 note_off   240       72   240 0.167  0.25     1
       3       0       9    39      1 note_on      0       64     0 0      0        0
       4       0       9    39      1 note_off     0       64   240 0.167  0.25     1
       5       0       9    36      1 note_on      0      101     0 0      0        0
       6       0       9    36      1 note_off     0      101   240 0.167  0.25     1
       7       0       9    42      1 note_on    240      101   480 0.333  0.5      2
       8       0       9    42      1 note_off     0      101   720 0.500  0.75     3
       9       0       9    38      1 note_on      0      101   480 0.333  0.5      2
      10       0       9    38      1 note_off     0      101   720 0.500  0.75     3
      # ... with 250 more rows, and 1 more variable: meta <lgl>
      
      $dfm
      # A tibble: 268 x 18
         i_track meta  type       name    time  note velocity channel  tempo numerator
           <dbl> <lgl> <chr>      <list> <dbl> <dbl>    <dbl>   <dbl>  <dbl>     <dbl>
       1       0 TRUE  track_name <chr ~     0   NaN      NaN     NaN    NaN       NaN
       2       0 FALSE note_on    <dbl ~     0    43       72       9    NaN       NaN
       3       0 FALSE note_on    <dbl ~     0    39       64       9    NaN       NaN
       4       0 FALSE note_on    <dbl ~     0    36      101       9    NaN       NaN
       5       0 TRUE  set_tempo  <dbl ~     0   NaN      NaN     NaN 666666       NaN
       6       0 TRUE  time_sign~ <dbl ~     0   NaN      NaN     NaN    NaN         4
       7       0 FALSE note_off   <dbl ~   240    43       72       9    NaN       NaN
       8       0 FALSE note_off   <dbl ~     0    39       64       9    NaN       NaN
       9       0 FALSE note_off   <dbl ~     0    36      101       9    NaN       NaN
      10       0 FALSE note_on    <dbl ~   240    42      101       9    NaN       NaN
      # ... with 258 more rows, and 8 more variables: denominator <dbl>,
      #   clocks_per_click <dbl>, notated_32nd_notes_per_beat <dbl>, ticks <dbl>,
      #   t <dbl>, m <dbl>, b <dbl>, i_note <int>
      
      $mf
      <miditapyr.midi_frame.MidiFrames>
      
      $midi_file_string
      [1] "/home/chief/R/pyramidi/inst/extdata/test_midi_file.mid"
      

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
      2        0 FALSE        note_on          NaN    0   43       72       9    NaN
      3        0 FALSE        note_on          NaN    0   39       64       9    NaN
      4        0 FALSE        note_on          NaN    0   36      101       9    NaN
      5        0  TRUE      set_tempo          NaN    0  NaN      NaN     NaN 666666
      6        0  TRUE time_signature          NaN    0  NaN      NaN     NaN    NaN
      7        0 FALSE       note_off          NaN  240   43       72       9    NaN
      8        0 FALSE       note_off          NaN    0   39       64       9    NaN
      9        0 FALSE       note_off          NaN    0   36      101       9    NaN
      10       0 FALSE        note_on          NaN  240   42      101       9    NaN
      11       0 FALSE        note_on          NaN    0   38      101       9    NaN
      12       0 FALSE        note_on          NaN  240   43       64       9    NaN
      13       0 FALSE       note_off          NaN    0   42      101       9    NaN
      14       0 FALSE       note_off          NaN    0   38      101       9    NaN
      15       0 FALSE       note_off          NaN  240   43       64       9    NaN
      16       0 FALSE        note_on          NaN    0   36      101       9    NaN
      17       0 FALSE       note_off          NaN  240   36      101       9    NaN
      18       0 FALSE        note_on          NaN  240   43       60       9    NaN
      19       0 FALSE        note_on          NaN    0   42      101       9    NaN
      20       0 FALSE       note_off          NaN  240   43       60       9    NaN
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
      


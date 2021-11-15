# print of r_midi_frames() correct

    Code
      mfr
    Output
      $mf
      <miditapyr.midi_frame.MidiFrames>
      
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
      
      $df_not_notes
       [1] i_track  meta     type     time     note     velocity channel  ticks   
       [9] t        m        b        i_note  
      <0 rows> (or 0-length row.names)
      
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
      
      $df_long_mod
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
      
      attr(,"class")
      [1] "r_midi_frames" "list"         

---

    Code
      list(mfr$mf$midi_frame_raw, mfr$mf$midi_frame_unnested$df, mfr$mf$
        midi_frame_nested$df)
    Output
      [[1]]
          i_track  meta                            msg
      1         0  TRUE    track_name, drum-t1-1-t1, 0
      2         0 FALSE          note_on, 0, 43, 72, 9
      3         0 FALSE          note_on, 0, 39, 64, 9
      4         0 FALSE         note_on, 0, 36, 101, 9
      5         0  TRUE           set_tempo, 666666, 0
      6         0  TRUE time_signature, 4, 4, 24, 8, 0
      7         0 FALSE       note_off, 240, 43, 72, 9
      8         0 FALSE         note_off, 0, 39, 64, 9
      9         0 FALSE        note_off, 0, 36, 101, 9
      10        0 FALSE       note_on, 240, 42, 101, 9
      11        0 FALSE         note_on, 0, 38, 101, 9
      12        0 FALSE        note_on, 240, 43, 64, 9
      13        0 FALSE        note_off, 0, 42, 101, 9
      14        0 FALSE        note_off, 0, 38, 101, 9
      15        0 FALSE       note_off, 240, 43, 64, 9
      16        0 FALSE         note_on, 0, 36, 101, 9
      17        0 FALSE      note_off, 240, 36, 101, 9
      18        0 FALSE        note_on, 240, 43, 60, 9
      19        0 FALSE         note_on, 0, 42, 101, 9
      20        0 FALSE       note_off, 240, 43, 60, 9
      21        0 FALSE        note_off, 0, 42, 101, 9
      22        0 FALSE        note_on, 240, 43, 60, 9
      23        0 FALSE          note_on, 0, 39, 66, 9
      24        0 FALSE         note_on, 0, 36, 101, 9
      25        0 FALSE       note_off, 240, 43, 60, 9
      26        0 FALSE         note_off, 0, 39, 66, 9
      27        0 FALSE        note_off, 0, 36, 101, 9
      28        0 FALSE       note_on, 240, 42, 101, 9
      29        0 FALSE         note_on, 0, 38, 101, 9
      30        0 FALSE        note_on, 240, 43, 53, 9
      31        0 FALSE        note_off, 0, 42, 101, 9
      32        0 FALSE        note_off, 0, 38, 101, 9
      33        0 FALSE       note_off, 240, 43, 53, 9
      34        0 FALSE         note_on, 0, 36, 101, 9
      35        0 FALSE      note_off, 240, 36, 101, 9
      36        0 FALSE        note_on, 240, 43, 52, 9
      37        0 FALSE          note_on, 0, 42, 66, 9
      38        0 FALSE       note_off, 240, 43, 52, 9
      39        0 FALSE         note_off, 0, 42, 66, 9
      40        0 FALSE        note_on, 240, 43, 72, 9
      41        0 FALSE          note_on, 0, 39, 64, 9
      42        0 FALSE         note_on, 0, 36, 101, 9
      43        0 FALSE       note_off, 240, 43, 72, 9
      44        0 FALSE         note_off, 0, 39, 64, 9
      45        0 FALSE        note_off, 0, 36, 101, 9
      46        0 FALSE       note_on, 240, 42, 101, 9
      47        0 FALSE         note_on, 0, 38, 101, 9
      48        0 FALSE        note_on, 240, 43, 64, 9
      49        0 FALSE        note_off, 0, 42, 101, 9
      50        0 FALSE        note_off, 0, 38, 101, 9
      51        0 FALSE       note_off, 240, 43, 64, 9
      52        0 FALSE         note_on, 0, 36, 101, 9
      53        0 FALSE      note_off, 240, 36, 101, 9
      54        0 FALSE        note_on, 240, 43, 60, 9
      55        0 FALSE         note_on, 0, 42, 101, 9
      56        0 FALSE       note_off, 240, 43, 60, 9
      57        0 FALSE        note_off, 0, 42, 101, 9
      58        0 FALSE        note_on, 240, 43, 60, 9
      59        0 FALSE          note_on, 0, 39, 66, 9
      60        0 FALSE         note_on, 0, 36, 101, 9
      61        0 FALSE       note_off, 240, 43, 60, 9
      62        0 FALSE         note_off, 0, 39, 66, 9
      63        0 FALSE        note_off, 0, 36, 101, 9
      64        0 FALSE       note_on, 240, 42, 101, 9
      65        0 FALSE         note_on, 0, 38, 101, 9
      66        0 FALSE        note_on, 240, 43, 53, 9
      67        0 FALSE        note_off, 0, 42, 101, 9
      68        0 FALSE        note_off, 0, 38, 101, 9
      69        0 FALSE       note_off, 240, 43, 53, 9
      70        0 FALSE         note_on, 0, 36, 101, 9
      71        0 FALSE      note_off, 240, 36, 101, 9
      72        0 FALSE        note_on, 240, 43, 52, 9
      73        0 FALSE          note_on, 0, 42, 66, 9
      74        0 FALSE       note_off, 240, 43, 52, 9
      75        0 FALSE         note_off, 0, 42, 66, 9
      76        0 FALSE        note_on, 240, 43, 72, 9
      77        0 FALSE          note_on, 0, 39, 64, 9
      78        0 FALSE         note_on, 0, 36, 101, 9
      79        0 FALSE       note_off, 240, 43, 72, 9
      80        0 FALSE         note_off, 0, 39, 64, 9
      81        0 FALSE        note_off, 0, 36, 101, 9
      82        0 FALSE       note_on, 240, 42, 101, 9
      83        0 FALSE         note_on, 0, 38, 101, 9
      84        0 FALSE        note_on, 240, 43, 64, 9
      85        0 FALSE        note_off, 0, 42, 101, 9
      86        0 FALSE        note_off, 0, 38, 101, 9
      87        0 FALSE       note_off, 240, 43, 64, 9
      88        0 FALSE         note_on, 0, 36, 101, 9
      89        0 FALSE      note_off, 240, 36, 101, 9
      90        0 FALSE        note_on, 240, 43, 60, 9
      91        0 FALSE         note_on, 0, 42, 101, 9
      92        0 FALSE       note_off, 240, 43, 60, 9
      93        0 FALSE        note_off, 0, 42, 101, 9
      94        0 FALSE        note_on, 240, 43, 60, 9
      95        0 FALSE          note_on, 0, 39, 66, 9
      96        0 FALSE         note_on, 0, 36, 101, 9
      97        0 FALSE       note_off, 240, 43, 60, 9
      98        0 FALSE         note_off, 0, 39, 66, 9
      99        0 FALSE        note_off, 0, 36, 101, 9
      100       0 FALSE       note_on, 240, 42, 101, 9
      101       0 FALSE         note_on, 0, 38, 101, 9
      102       0 FALSE        note_on, 240, 43, 53, 9
      103       0 FALSE        note_off, 0, 42, 101, 9
      104       0 FALSE        note_off, 0, 38, 101, 9
      105       0 FALSE       note_off, 240, 43, 53, 9
      106       0 FALSE         note_on, 0, 36, 101, 9
      107       0 FALSE      note_off, 240, 36, 101, 9
      108       0 FALSE        note_on, 240, 43, 52, 9
      109       0 FALSE          note_on, 0, 42, 66, 9
      110       0 FALSE       note_off, 240, 43, 52, 9
      111       0 FALSE         note_off, 0, 42, 66, 9
      112       0 FALSE        note_on, 240, 43, 81, 9
      113       0 FALSE         note_on, 0, 36, 101, 9
      114       0 FALSE       note_off, 240, 43, 81, 9
      115       0 FALSE        note_off, 0, 36, 101, 9
      116       0 FALSE       note_on, 240, 42, 101, 9
      117       0 FALSE          note_on, 0, 39, 57, 9
      118       0 FALSE         note_on, 0, 38, 101, 9
      119       0 FALSE        note_on, 240, 43, 60, 9
      120       0 FALSE        note_off, 0, 42, 101, 9
      121       0 FALSE         note_off, 0, 39, 57, 9
      122       0 FALSE        note_off, 0, 38, 101, 9
      123       0 FALSE       note_off, 240, 43, 60, 9
      124       0 FALSE         note_on, 0, 36, 101, 9
      125       0 FALSE      note_off, 240, 36, 101, 9
      126       0 FALSE        note_on, 240, 43, 66, 9
      127       0 FALSE         note_on, 0, 42, 101, 9
      128       0 FALSE       note_off, 240, 43, 66, 9
      129       0 FALSE        note_off, 0, 42, 101, 9
      130       0 FALSE        note_on, 240, 43, 66, 9
      131       0 FALSE         note_on, 0, 36, 101, 9
      132       0 FALSE       note_off, 240, 43, 66, 9
      133       0 FALSE        note_off, 0, 36, 101, 9
      134       0 FALSE        note_on, 240, 46, 81, 9
      135       0 FALSE          note_on, 0, 45, 67, 9
      136       0 FALSE          note_on, 0, 39, 60, 9
      137       0 FALSE         note_on, 0, 38, 101, 9
      138       0 FALSE       note_off, 240, 46, 81, 9
      139       0 FALSE         note_off, 0, 45, 67, 9
      140       0 FALSE         note_off, 0, 39, 60, 9
      141       0 FALSE        note_off, 0, 38, 101, 9
      142       0 FALSE        note_on, 240, 39, 59, 9
      143       0 FALSE         note_on, 0, 36, 101, 9
      144       0 FALSE       note_off, 240, 39, 59, 9
      145       0 FALSE          note_on, 0, 39, 55, 9
      146       0 FALSE        note_off, 0, 36, 101, 9
      147       0 FALSE        note_on, 240, 45, 63, 9
      148       0 FALSE          note_on, 0, 43, 52, 9
      149       0 FALSE         note_on, 0, 42, 101, 9
      150       0 FALSE         note_off, 0, 39, 55, 9
      151       0 FALSE          note_on, 0, 39, 55, 9
      152       0 FALSE       note_off, 240, 45, 63, 9
      153       0 FALSE         note_off, 0, 43, 52, 9
      154       0 FALSE        note_off, 0, 42, 101, 9
      155       0 FALSE          note_on, 0, 42, 59, 9
      156       0 FALSE         note_off, 0, 39, 55, 9
      157       0 FALSE          note_on, 0, 39, 57, 9
      158       0 FALSE       note_off, 240, 42, 59, 9
      159       0 FALSE         note_off, 0, 39, 57, 9
      160       0  TRUE                end_of_track, 1
      161       1  TRUE      track_name, Audio+MIDI, 0
      162       1 FALSE         note_on, 0, 50, 82, 15
      163       1 FALSE      note_off, 240, 50, 82, 15
      164       1 FALSE      note_on, 3000, 45, 85, 15
      165       1 FALSE       note_on, 600, 50, 81, 15
      166       1 FALSE        note_off, 0, 45, 85, 15
      167       1 FALSE      note_off, 240, 50, 81, 15
      168       1 FALSE      note_on, 3120, 45, 69, 15
      169       1 FALSE       note_on, 480, 50, 69, 15
      170       1 FALSE        note_off, 0, 45, 69, 15
      171       1 FALSE      note_off, 360, 50, 69, 15
      172       1 FALSE      note_on, 2400, 45, 82, 15
      173       1 FALSE      note_off, 960, 45, 82, 15
      174       1 FALSE       note_on, 120, 50, 72, 15
      175       1 FALSE     note_off, 1080, 50, 72, 15
      176       1 FALSE       note_on, 360, 57, 79, 15
      177       1 FALSE      note_off, 480, 57, 79, 15
      178       1 FALSE         note_on, 0, 55, 50, 15
      179       1 FALSE      note_off, 480, 55, 50, 15
      180       1 FALSE         note_on, 0, 53, 73, 15
      181       1 FALSE      note_off, 480, 53, 73, 15
      182       1 FALSE         note_on, 0, 52, 69, 15
      183       1 FALSE      note_off, 480, 52, 69, 15
      184       1 FALSE         note_on, 0, 48, 85, 15
      185       1 FALSE      note_off, 480, 48, 85, 15
      186       1  TRUE                end_of_track, 1
      187       2  TRUE    track_name, Audio+MIDI 1, 0
      188       2 FALSE        note_on, 54, 62, 78, 15
      189       2 FALSE        note_on, 10, 57, 78, 15
      190       2 FALSE         note_on, 6, 65, 72, 15
      191       2 FALSE      note_off, 283, 65, 72, 15
      192       2 FALSE       note_off, 16, 62, 78, 15
      193       2 FALSE       note_off, 55, 57, 78, 15
      194       2 FALSE      note_on, 1049, 62, 57, 15
      195       2 FALSE         note_on, 9, 57, 53, 15
      196       2 FALSE         note_on, 8, 65, 58, 15
      197       2 FALSE     note_off, 1652, 65, 58, 15
      198       2 FALSE        note_off, 8, 62, 57, 15
      199       2 FALSE       note_off, 47, 57, 53, 15
      200       2 FALSE       note_on, 142, 62, 61, 15
      201       2 FALSE         note_on, 9, 57, 53, 15
      202       2 FALSE         note_on, 8, 65, 58, 15
      203       2 FALSE      note_off, 188, 62, 61, 15
      204       2 FALSE        note_off, 8, 65, 58, 15
      205       2 FALSE       note_off, 24, 57, 53, 15
      206       2 FALSE       note_on, 275, 62, 47, 15
      207       2 FALSE         note_on, 8, 57, 42, 15
      208       2 FALSE         note_on, 9, 65, 46, 15
      209       2 FALSE      note_off, 337, 65, 46, 15
      210       2 FALSE      note_off, 266, 62, 47, 15
      211       2 FALSE      note_off, 119, 57, 42, 15
      212       2 FALSE       note_on, 657, 62, 56, 15
      213       2 FALSE         note_on, 9, 57, 53, 15
      214       2 FALSE         note_on, 8, 65, 58, 15
      215       2 FALSE     note_off, 1651, 65, 58, 15
      216       2 FALSE       note_off, 24, 62, 56, 15
      217       2 FALSE       note_off, 24, 57, 53, 15
      218       2 FALSE       note_on, 173, 62, 49, 15
      219       2 FALSE         note_on, 9, 57, 42, 15
      220       2 FALSE         note_on, 8, 65, 49, 15
      221       2 FALSE      note_off, 266, 65, 49, 15
      222       2 FALSE       note_off, 24, 62, 49, 15
      223       2 FALSE       note_off, 24, 57, 42, 15
      224       2 FALSE       note_on, 212, 62, 37, 15
      225       2 FALSE         note_on, 9, 57, 34, 15
      226       2 FALSE         note_on, 8, 65, 51, 15
      227       2 FALSE      note_off, 314, 65, 51, 15
      228       2 FALSE        note_off, 8, 62, 37, 15
      229       2 FALSE       note_off, 79, 57, 34, 15
      230       2 FALSE      note_on, 1018, 57, 58, 15
      231       2 FALSE         note_on, 8, 62, 60, 15
      232       2 FALSE         note_on, 8, 65, 56, 15
      233       2 FALSE     note_off, 1746, 65, 56, 15
      234       2 FALSE        note_off, 8, 62, 60, 15
      235       2 FALSE       note_off, 71, 57, 58, 15
      236       2 FALSE       note_on, 447, 62, 50, 15
      237       2 FALSE         note_on, 8, 57, 40, 15
      238       2 FALSE         note_on, 8, 65, 52, 15
      239       2 FALSE      note_off, 431, 62, 50, 15
      240       2 FALSE        note_off, 9, 65, 52, 15
      241       2 FALSE       note_off, 70, 57, 40, 15
      242       2 FALSE       note_on, 917, 62, 63, 15
      243       2 FALSE         note_on, 8, 59, 69, 15
      244       2 FALSE         note_on, 8, 67, 58, 15
      245       2 FALSE      note_off, 252, 62, 63, 15
      246       2 FALSE        note_off, 8, 67, 58, 15
      247       2 FALSE       note_off, 23, 59, 69, 15
      248       2 FALSE       note_on, 268, 59, 58, 15
      249       2 FALSE         note_on, 8, 62, 58, 15
      250       2 FALSE         note_on, 8, 67, 58, 15
      251       2 FALSE      note_off, 587, 62, 58, 15
      252       2 FALSE        note_off, 9, 67, 58, 15
      253       2 FALSE       note_off, 63, 59, 58, 15
      254       2 FALSE        note_on, 87, 59, 52, 15
      255       2 FALSE         note_on, 8, 67, 60, 15
      256       2 FALSE         note_on, 8, 62, 65, 15
      257       2 FALSE      note_off, 251, 62, 65, 15
      258       2 FALSE       note_off, 32, 67, 60, 15
      259       2 FALSE       note_off, 48, 59, 52, 15
      260       2 FALSE       note_on, 337, 59, 57, 15
      261       2 FALSE         note_on, 9, 62, 60, 15
      262       2 FALSE         note_on, 8, 67, 57, 15
      263       2 FALSE      note_off, 173, 62, 60, 15
      264       2 FALSE       note_off, 31, 59, 57, 15
      265       2 FALSE        note_off, 9, 67, 57, 15
      266       2 FALSE       note_on, 266, 62, 82, 15
      267       2 FALSE        note_off, 5, 62, 82, 15
      268       2  TRUE                end_of_track, 1
      
      [[2]]
          i_track  meta           type         name time note velocity channel  tempo
      1         0  TRUE     track_name drum-t1-1-t1    0  NaN      NaN     NaN    NaN
      2         0 FALSE        note_on          NaN    0   43       72       9    NaN
      3         0 FALSE        note_on          NaN    0   39       64       9    NaN
      4         0 FALSE        note_on          NaN    0   36      101       9    NaN
      5         0  TRUE      set_tempo          NaN    0  NaN      NaN     NaN 666666
      6         0  TRUE time_signature          NaN    0  NaN      NaN     NaN    NaN
      7         0 FALSE       note_off          NaN  240   43       72       9    NaN
      8         0 FALSE       note_off          NaN    0   39       64       9    NaN
      9         0 FALSE       note_off          NaN    0   36      101       9    NaN
      10        0 FALSE        note_on          NaN  240   42      101       9    NaN
      11        0 FALSE        note_on          NaN    0   38      101       9    NaN
      12        0 FALSE        note_on          NaN  240   43       64       9    NaN
      13        0 FALSE       note_off          NaN    0   42      101       9    NaN
      14        0 FALSE       note_off          NaN    0   38      101       9    NaN
      15        0 FALSE       note_off          NaN  240   43       64       9    NaN
      16        0 FALSE        note_on          NaN    0   36      101       9    NaN
      17        0 FALSE       note_off          NaN  240   36      101       9    NaN
      18        0 FALSE        note_on          NaN  240   43       60       9    NaN
      19        0 FALSE        note_on          NaN    0   42      101       9    NaN
      20        0 FALSE       note_off          NaN  240   43       60       9    NaN
      21        0 FALSE       note_off          NaN    0   42      101       9    NaN
      22        0 FALSE        note_on          NaN  240   43       60       9    NaN
      23        0 FALSE        note_on          NaN    0   39       66       9    NaN
      24        0 FALSE        note_on          NaN    0   36      101       9    NaN
      25        0 FALSE       note_off          NaN  240   43       60       9    NaN
      26        0 FALSE       note_off          NaN    0   39       66       9    NaN
      27        0 FALSE       note_off          NaN    0   36      101       9    NaN
      28        0 FALSE        note_on          NaN  240   42      101       9    NaN
      29        0 FALSE        note_on          NaN    0   38      101       9    NaN
      30        0 FALSE        note_on          NaN  240   43       53       9    NaN
      31        0 FALSE       note_off          NaN    0   42      101       9    NaN
      32        0 FALSE       note_off          NaN    0   38      101       9    NaN
      33        0 FALSE       note_off          NaN  240   43       53       9    NaN
      34        0 FALSE        note_on          NaN    0   36      101       9    NaN
      35        0 FALSE       note_off          NaN  240   36      101       9    NaN
      36        0 FALSE        note_on          NaN  240   43       52       9    NaN
      37        0 FALSE        note_on          NaN    0   42       66       9    NaN
      38        0 FALSE       note_off          NaN  240   43       52       9    NaN
      39        0 FALSE       note_off          NaN    0   42       66       9    NaN
      40        0 FALSE        note_on          NaN  240   43       72       9    NaN
      41        0 FALSE        note_on          NaN    0   39       64       9    NaN
      42        0 FALSE        note_on          NaN    0   36      101       9    NaN
      43        0 FALSE       note_off          NaN  240   43       72       9    NaN
      44        0 FALSE       note_off          NaN    0   39       64       9    NaN
      45        0 FALSE       note_off          NaN    0   36      101       9    NaN
      46        0 FALSE        note_on          NaN  240   42      101       9    NaN
      47        0 FALSE        note_on          NaN    0   38      101       9    NaN
      48        0 FALSE        note_on          NaN  240   43       64       9    NaN
      49        0 FALSE       note_off          NaN    0   42      101       9    NaN
      50        0 FALSE       note_off          NaN    0   38      101       9    NaN
      51        0 FALSE       note_off          NaN  240   43       64       9    NaN
      52        0 FALSE        note_on          NaN    0   36      101       9    NaN
      53        0 FALSE       note_off          NaN  240   36      101       9    NaN
      54        0 FALSE        note_on          NaN  240   43       60       9    NaN
      55        0 FALSE        note_on          NaN    0   42      101       9    NaN
      56        0 FALSE       note_off          NaN  240   43       60       9    NaN
      57        0 FALSE       note_off          NaN    0   42      101       9    NaN
      58        0 FALSE        note_on          NaN  240   43       60       9    NaN
      59        0 FALSE        note_on          NaN    0   39       66       9    NaN
      60        0 FALSE        note_on          NaN    0   36      101       9    NaN
      61        0 FALSE       note_off          NaN  240   43       60       9    NaN
      62        0 FALSE       note_off          NaN    0   39       66       9    NaN
      63        0 FALSE       note_off          NaN    0   36      101       9    NaN
      64        0 FALSE        note_on          NaN  240   42      101       9    NaN
      65        0 FALSE        note_on          NaN    0   38      101       9    NaN
      66        0 FALSE        note_on          NaN  240   43       53       9    NaN
      67        0 FALSE       note_off          NaN    0   42      101       9    NaN
      68        0 FALSE       note_off          NaN    0   38      101       9    NaN
      69        0 FALSE       note_off          NaN  240   43       53       9    NaN
      70        0 FALSE        note_on          NaN    0   36      101       9    NaN
      71        0 FALSE       note_off          NaN  240   36      101       9    NaN
      72        0 FALSE        note_on          NaN  240   43       52       9    NaN
      73        0 FALSE        note_on          NaN    0   42       66       9    NaN
      74        0 FALSE       note_off          NaN  240   43       52       9    NaN
      75        0 FALSE       note_off          NaN    0   42       66       9    NaN
      76        0 FALSE        note_on          NaN  240   43       72       9    NaN
      77        0 FALSE        note_on          NaN    0   39       64       9    NaN
      78        0 FALSE        note_on          NaN    0   36      101       9    NaN
      79        0 FALSE       note_off          NaN  240   43       72       9    NaN
      80        0 FALSE       note_off          NaN    0   39       64       9    NaN
      81        0 FALSE       note_off          NaN    0   36      101       9    NaN
      82        0 FALSE        note_on          NaN  240   42      101       9    NaN
      83        0 FALSE        note_on          NaN    0   38      101       9    NaN
      84        0 FALSE        note_on          NaN  240   43       64       9    NaN
      85        0 FALSE       note_off          NaN    0   42      101       9    NaN
      86        0 FALSE       note_off          NaN    0   38      101       9    NaN
      87        0 FALSE       note_off          NaN  240   43       64       9    NaN
      88        0 FALSE        note_on          NaN    0   36      101       9    NaN
      89        0 FALSE       note_off          NaN  240   36      101       9    NaN
      90        0 FALSE        note_on          NaN  240   43       60       9    NaN
      91        0 FALSE        note_on          NaN    0   42      101       9    NaN
      92        0 FALSE       note_off          NaN  240   43       60       9    NaN
      93        0 FALSE       note_off          NaN    0   42      101       9    NaN
      94        0 FALSE        note_on          NaN  240   43       60       9    NaN
      95        0 FALSE        note_on          NaN    0   39       66       9    NaN
      96        0 FALSE        note_on          NaN    0   36      101       9    NaN
      97        0 FALSE       note_off          NaN  240   43       60       9    NaN
      98        0 FALSE       note_off          NaN    0   39       66       9    NaN
      99        0 FALSE       note_off          NaN    0   36      101       9    NaN
      100       0 FALSE        note_on          NaN  240   42      101       9    NaN
      101       0 FALSE        note_on          NaN    0   38      101       9    NaN
      102       0 FALSE        note_on          NaN  240   43       53       9    NaN
      103       0 FALSE       note_off          NaN    0   42      101       9    NaN
      104       0 FALSE       note_off          NaN    0   38      101       9    NaN
      105       0 FALSE       note_off          NaN  240   43       53       9    NaN
      106       0 FALSE        note_on          NaN    0   36      101       9    NaN
      107       0 FALSE       note_off          NaN  240   36      101       9    NaN
      108       0 FALSE        note_on          NaN  240   43       52       9    NaN
      109       0 FALSE        note_on          NaN    0   42       66       9    NaN
      110       0 FALSE       note_off          NaN  240   43       52       9    NaN
      111       0 FALSE       note_off          NaN    0   42       66       9    NaN
      112       0 FALSE        note_on          NaN  240   43       81       9    NaN
      113       0 FALSE        note_on          NaN    0   36      101       9    NaN
      114       0 FALSE       note_off          NaN  240   43       81       9    NaN
      115       0 FALSE       note_off          NaN    0   36      101       9    NaN
      116       0 FALSE        note_on          NaN  240   42      101       9    NaN
      117       0 FALSE        note_on          NaN    0   39       57       9    NaN
      118       0 FALSE        note_on          NaN    0   38      101       9    NaN
      119       0 FALSE        note_on          NaN  240   43       60       9    NaN
      120       0 FALSE       note_off          NaN    0   42      101       9    NaN
      121       0 FALSE       note_off          NaN    0   39       57       9    NaN
      122       0 FALSE       note_off          NaN    0   38      101       9    NaN
      123       0 FALSE       note_off          NaN  240   43       60       9    NaN
      124       0 FALSE        note_on          NaN    0   36      101       9    NaN
      125       0 FALSE       note_off          NaN  240   36      101       9    NaN
      126       0 FALSE        note_on          NaN  240   43       66       9    NaN
      127       0 FALSE        note_on          NaN    0   42      101       9    NaN
      128       0 FALSE       note_off          NaN  240   43       66       9    NaN
      129       0 FALSE       note_off          NaN    0   42      101       9    NaN
      130       0 FALSE        note_on          NaN  240   43       66       9    NaN
      131       0 FALSE        note_on          NaN    0   36      101       9    NaN
      132       0 FALSE       note_off          NaN  240   43       66       9    NaN
      133       0 FALSE       note_off          NaN    0   36      101       9    NaN
      134       0 FALSE        note_on          NaN  240   46       81       9    NaN
      135       0 FALSE        note_on          NaN    0   45       67       9    NaN
      136       0 FALSE        note_on          NaN    0   39       60       9    NaN
      137       0 FALSE        note_on          NaN    0   38      101       9    NaN
      138       0 FALSE       note_off          NaN  240   46       81       9    NaN
      139       0 FALSE       note_off          NaN    0   45       67       9    NaN
      140       0 FALSE       note_off          NaN    0   39       60       9    NaN
      141       0 FALSE       note_off          NaN    0   38      101       9    NaN
      142       0 FALSE        note_on          NaN  240   39       59       9    NaN
      143       0 FALSE        note_on          NaN    0   36      101       9    NaN
      144       0 FALSE       note_off          NaN  240   39       59       9    NaN
      145       0 FALSE        note_on          NaN    0   39       55       9    NaN
      146       0 FALSE       note_off          NaN    0   36      101       9    NaN
      147       0 FALSE        note_on          NaN  240   45       63       9    NaN
      148       0 FALSE        note_on          NaN    0   43       52       9    NaN
      149       0 FALSE        note_on          NaN    0   42      101       9    NaN
      150       0 FALSE       note_off          NaN    0   39       55       9    NaN
      151       0 FALSE        note_on          NaN    0   39       55       9    NaN
      152       0 FALSE       note_off          NaN  240   45       63       9    NaN
      153       0 FALSE       note_off          NaN    0   43       52       9    NaN
      154       0 FALSE       note_off          NaN    0   42      101       9    NaN
      155       0 FALSE        note_on          NaN    0   42       59       9    NaN
      156       0 FALSE       note_off          NaN    0   39       55       9    NaN
      157       0 FALSE        note_on          NaN    0   39       57       9    NaN
      158       0 FALSE       note_off          NaN  240   42       59       9    NaN
      159       0 FALSE       note_off          NaN    0   39       57       9    NaN
      160       0  TRUE   end_of_track          NaN    1  NaN      NaN     NaN    NaN
      161       1  TRUE     track_name   Audio+MIDI    0  NaN      NaN     NaN    NaN
      162       1 FALSE        note_on          NaN    0   50       82      15    NaN
      163       1 FALSE       note_off          NaN  240   50       82      15    NaN
      164       1 FALSE        note_on          NaN 3000   45       85      15    NaN
      165       1 FALSE        note_on          NaN  600   50       81      15    NaN
      166       1 FALSE       note_off          NaN    0   45       85      15    NaN
      167       1 FALSE       note_off          NaN  240   50       81      15    NaN
      168       1 FALSE        note_on          NaN 3120   45       69      15    NaN
      169       1 FALSE        note_on          NaN  480   50       69      15    NaN
      170       1 FALSE       note_off          NaN    0   45       69      15    NaN
      171       1 FALSE       note_off          NaN  360   50       69      15    NaN
      172       1 FALSE        note_on          NaN 2400   45       82      15    NaN
      173       1 FALSE       note_off          NaN  960   45       82      15    NaN
      174       1 FALSE        note_on          NaN  120   50       72      15    NaN
      175       1 FALSE       note_off          NaN 1080   50       72      15    NaN
      176       1 FALSE        note_on          NaN  360   57       79      15    NaN
      177       1 FALSE       note_off          NaN  480   57       79      15    NaN
      178       1 FALSE        note_on          NaN    0   55       50      15    NaN
      179       1 FALSE       note_off          NaN  480   55       50      15    NaN
      180       1 FALSE        note_on          NaN    0   53       73      15    NaN
      181       1 FALSE       note_off          NaN  480   53       73      15    NaN
      182       1 FALSE        note_on          NaN    0   52       69      15    NaN
      183       1 FALSE       note_off          NaN  480   52       69      15    NaN
      184       1 FALSE        note_on          NaN    0   48       85      15    NaN
      185       1 FALSE       note_off          NaN  480   48       85      15    NaN
      186       1  TRUE   end_of_track          NaN    1  NaN      NaN     NaN    NaN
      187       2  TRUE     track_name Audio+MIDI 1    0  NaN      NaN     NaN    NaN
      188       2 FALSE        note_on          NaN   54   62       78      15    NaN
      189       2 FALSE        note_on          NaN   10   57       78      15    NaN
      190       2 FALSE        note_on          NaN    6   65       72      15    NaN
      191       2 FALSE       note_off          NaN  283   65       72      15    NaN
      192       2 FALSE       note_off          NaN   16   62       78      15    NaN
      193       2 FALSE       note_off          NaN   55   57       78      15    NaN
      194       2 FALSE        note_on          NaN 1049   62       57      15    NaN
      195       2 FALSE        note_on          NaN    9   57       53      15    NaN
      196       2 FALSE        note_on          NaN    8   65       58      15    NaN
      197       2 FALSE       note_off          NaN 1652   65       58      15    NaN
      198       2 FALSE       note_off          NaN    8   62       57      15    NaN
      199       2 FALSE       note_off          NaN   47   57       53      15    NaN
      200       2 FALSE        note_on          NaN  142   62       61      15    NaN
      201       2 FALSE        note_on          NaN    9   57       53      15    NaN
      202       2 FALSE        note_on          NaN    8   65       58      15    NaN
      203       2 FALSE       note_off          NaN  188   62       61      15    NaN
      204       2 FALSE       note_off          NaN    8   65       58      15    NaN
      205       2 FALSE       note_off          NaN   24   57       53      15    NaN
      206       2 FALSE        note_on          NaN  275   62       47      15    NaN
      207       2 FALSE        note_on          NaN    8   57       42      15    NaN
      208       2 FALSE        note_on          NaN    9   65       46      15    NaN
      209       2 FALSE       note_off          NaN  337   65       46      15    NaN
      210       2 FALSE       note_off          NaN  266   62       47      15    NaN
      211       2 FALSE       note_off          NaN  119   57       42      15    NaN
      212       2 FALSE        note_on          NaN  657   62       56      15    NaN
      213       2 FALSE        note_on          NaN    9   57       53      15    NaN
      214       2 FALSE        note_on          NaN    8   65       58      15    NaN
      215       2 FALSE       note_off          NaN 1651   65       58      15    NaN
      216       2 FALSE       note_off          NaN   24   62       56      15    NaN
      217       2 FALSE       note_off          NaN   24   57       53      15    NaN
      218       2 FALSE        note_on          NaN  173   62       49      15    NaN
      219       2 FALSE        note_on          NaN    9   57       42      15    NaN
      220       2 FALSE        note_on          NaN    8   65       49      15    NaN
      221       2 FALSE       note_off          NaN  266   65       49      15    NaN
      222       2 FALSE       note_off          NaN   24   62       49      15    NaN
      223       2 FALSE       note_off          NaN   24   57       42      15    NaN
      224       2 FALSE        note_on          NaN  212   62       37      15    NaN
      225       2 FALSE        note_on          NaN    9   57       34      15    NaN
      226       2 FALSE        note_on          NaN    8   65       51      15    NaN
      227       2 FALSE       note_off          NaN  314   65       51      15    NaN
      228       2 FALSE       note_off          NaN    8   62       37      15    NaN
      229       2 FALSE       note_off          NaN   79   57       34      15    NaN
      230       2 FALSE        note_on          NaN 1018   57       58      15    NaN
      231       2 FALSE        note_on          NaN    8   62       60      15    NaN
      232       2 FALSE        note_on          NaN    8   65       56      15    NaN
      233       2 FALSE       note_off          NaN 1746   65       56      15    NaN
      234       2 FALSE       note_off          NaN    8   62       60      15    NaN
      235       2 FALSE       note_off          NaN   71   57       58      15    NaN
      236       2 FALSE        note_on          NaN  447   62       50      15    NaN
      237       2 FALSE        note_on          NaN    8   57       40      15    NaN
      238       2 FALSE        note_on          NaN    8   65       52      15    NaN
      239       2 FALSE       note_off          NaN  431   62       50      15    NaN
      240       2 FALSE       note_off          NaN    9   65       52      15    NaN
      241       2 FALSE       note_off          NaN   70   57       40      15    NaN
      242       2 FALSE        note_on          NaN  917   62       63      15    NaN
      243       2 FALSE        note_on          NaN    8   59       69      15    NaN
      244       2 FALSE        note_on          NaN    8   67       58      15    NaN
      245       2 FALSE       note_off          NaN  252   62       63      15    NaN
      246       2 FALSE       note_off          NaN    8   67       58      15    NaN
      247       2 FALSE       note_off          NaN   23   59       69      15    NaN
      248       2 FALSE        note_on          NaN  268   59       58      15    NaN
      249       2 FALSE        note_on          NaN    8   62       58      15    NaN
      250       2 FALSE        note_on          NaN    8   67       58      15    NaN
      251       2 FALSE       note_off          NaN  587   62       58      15    NaN
      252       2 FALSE       note_off          NaN    9   67       58      15    NaN
      253       2 FALSE       note_off          NaN   63   59       58      15    NaN
      254       2 FALSE        note_on          NaN   87   59       52      15    NaN
      255       2 FALSE        note_on          NaN    8   67       60      15    NaN
      256       2 FALSE        note_on          NaN    8   62       65      15    NaN
      257       2 FALSE       note_off          NaN  251   62       65      15    NaN
      258       2 FALSE       note_off          NaN   32   67       60      15    NaN
      259       2 FALSE       note_off          NaN   48   59       52      15    NaN
      260       2 FALSE        note_on          NaN  337   59       57      15    NaN
      261       2 FALSE        note_on          NaN    9   62       60      15    NaN
      262       2 FALSE        note_on          NaN    8   67       57      15    NaN
      263       2 FALSE       note_off          NaN  173   62       60      15    NaN
      264       2 FALSE       note_off          NaN   31   59       57      15    NaN
      265       2 FALSE       note_off          NaN    9   67       57      15    NaN
      266       2 FALSE        note_on          NaN  266   62       82      15    NaN
      267       2 FALSE       note_off          NaN    5   62       82      15    NaN
      268       2  TRUE   end_of_track          NaN    1  NaN      NaN     NaN    NaN
          numerator denominator clocks_per_click notated_32nd_notes_per_beat
      1         NaN         NaN              NaN                         NaN
      2         NaN         NaN              NaN                         NaN
      3         NaN         NaN              NaN                         NaN
      4         NaN         NaN              NaN                         NaN
      5         NaN         NaN              NaN                         NaN
      6           4           4               24                           8
      7         NaN         NaN              NaN                         NaN
      8         NaN         NaN              NaN                         NaN
      9         NaN         NaN              NaN                         NaN
      10        NaN         NaN              NaN                         NaN
      11        NaN         NaN              NaN                         NaN
      12        NaN         NaN              NaN                         NaN
      13        NaN         NaN              NaN                         NaN
      14        NaN         NaN              NaN                         NaN
      15        NaN         NaN              NaN                         NaN
      16        NaN         NaN              NaN                         NaN
      17        NaN         NaN              NaN                         NaN
      18        NaN         NaN              NaN                         NaN
      19        NaN         NaN              NaN                         NaN
      20        NaN         NaN              NaN                         NaN
      21        NaN         NaN              NaN                         NaN
      22        NaN         NaN              NaN                         NaN
      23        NaN         NaN              NaN                         NaN
      24        NaN         NaN              NaN                         NaN
      25        NaN         NaN              NaN                         NaN
      26        NaN         NaN              NaN                         NaN
      27        NaN         NaN              NaN                         NaN
      28        NaN         NaN              NaN                         NaN
      29        NaN         NaN              NaN                         NaN
      30        NaN         NaN              NaN                         NaN
      31        NaN         NaN              NaN                         NaN
      32        NaN         NaN              NaN                         NaN
      33        NaN         NaN              NaN                         NaN
      34        NaN         NaN              NaN                         NaN
      35        NaN         NaN              NaN                         NaN
      36        NaN         NaN              NaN                         NaN
      37        NaN         NaN              NaN                         NaN
      38        NaN         NaN              NaN                         NaN
      39        NaN         NaN              NaN                         NaN
      40        NaN         NaN              NaN                         NaN
      41        NaN         NaN              NaN                         NaN
      42        NaN         NaN              NaN                         NaN
      43        NaN         NaN              NaN                         NaN
      44        NaN         NaN              NaN                         NaN
      45        NaN         NaN              NaN                         NaN
      46        NaN         NaN              NaN                         NaN
      47        NaN         NaN              NaN                         NaN
      48        NaN         NaN              NaN                         NaN
      49        NaN         NaN              NaN                         NaN
      50        NaN         NaN              NaN                         NaN
      51        NaN         NaN              NaN                         NaN
      52        NaN         NaN              NaN                         NaN
      53        NaN         NaN              NaN                         NaN
      54        NaN         NaN              NaN                         NaN
      55        NaN         NaN              NaN                         NaN
      56        NaN         NaN              NaN                         NaN
      57        NaN         NaN              NaN                         NaN
      58        NaN         NaN              NaN                         NaN
      59        NaN         NaN              NaN                         NaN
      60        NaN         NaN              NaN                         NaN
      61        NaN         NaN              NaN                         NaN
      62        NaN         NaN              NaN                         NaN
      63        NaN         NaN              NaN                         NaN
      64        NaN         NaN              NaN                         NaN
      65        NaN         NaN              NaN                         NaN
      66        NaN         NaN              NaN                         NaN
      67        NaN         NaN              NaN                         NaN
      68        NaN         NaN              NaN                         NaN
      69        NaN         NaN              NaN                         NaN
      70        NaN         NaN              NaN                         NaN
      71        NaN         NaN              NaN                         NaN
      72        NaN         NaN              NaN                         NaN
      73        NaN         NaN              NaN                         NaN
      74        NaN         NaN              NaN                         NaN
      75        NaN         NaN              NaN                         NaN
      76        NaN         NaN              NaN                         NaN
      77        NaN         NaN              NaN                         NaN
      78        NaN         NaN              NaN                         NaN
      79        NaN         NaN              NaN                         NaN
      80        NaN         NaN              NaN                         NaN
      81        NaN         NaN              NaN                         NaN
      82        NaN         NaN              NaN                         NaN
      83        NaN         NaN              NaN                         NaN
      84        NaN         NaN              NaN                         NaN
      85        NaN         NaN              NaN                         NaN
      86        NaN         NaN              NaN                         NaN
      87        NaN         NaN              NaN                         NaN
      88        NaN         NaN              NaN                         NaN
      89        NaN         NaN              NaN                         NaN
      90        NaN         NaN              NaN                         NaN
      91        NaN         NaN              NaN                         NaN
      92        NaN         NaN              NaN                         NaN
      93        NaN         NaN              NaN                         NaN
      94        NaN         NaN              NaN                         NaN
      95        NaN         NaN              NaN                         NaN
      96        NaN         NaN              NaN                         NaN
      97        NaN         NaN              NaN                         NaN
      98        NaN         NaN              NaN                         NaN
      99        NaN         NaN              NaN                         NaN
      100       NaN         NaN              NaN                         NaN
      101       NaN         NaN              NaN                         NaN
      102       NaN         NaN              NaN                         NaN
      103       NaN         NaN              NaN                         NaN
      104       NaN         NaN              NaN                         NaN
      105       NaN         NaN              NaN                         NaN
      106       NaN         NaN              NaN                         NaN
      107       NaN         NaN              NaN                         NaN
      108       NaN         NaN              NaN                         NaN
      109       NaN         NaN              NaN                         NaN
      110       NaN         NaN              NaN                         NaN
      111       NaN         NaN              NaN                         NaN
      112       NaN         NaN              NaN                         NaN
      113       NaN         NaN              NaN                         NaN
      114       NaN         NaN              NaN                         NaN
      115       NaN         NaN              NaN                         NaN
      116       NaN         NaN              NaN                         NaN
      117       NaN         NaN              NaN                         NaN
      118       NaN         NaN              NaN                         NaN
      119       NaN         NaN              NaN                         NaN
      120       NaN         NaN              NaN                         NaN
      121       NaN         NaN              NaN                         NaN
      122       NaN         NaN              NaN                         NaN
      123       NaN         NaN              NaN                         NaN
      124       NaN         NaN              NaN                         NaN
      125       NaN         NaN              NaN                         NaN
      126       NaN         NaN              NaN                         NaN
      127       NaN         NaN              NaN                         NaN
      128       NaN         NaN              NaN                         NaN
      129       NaN         NaN              NaN                         NaN
      130       NaN         NaN              NaN                         NaN
      131       NaN         NaN              NaN                         NaN
      132       NaN         NaN              NaN                         NaN
      133       NaN         NaN              NaN                         NaN
      134       NaN         NaN              NaN                         NaN
      135       NaN         NaN              NaN                         NaN
      136       NaN         NaN              NaN                         NaN
      137       NaN         NaN              NaN                         NaN
      138       NaN         NaN              NaN                         NaN
      139       NaN         NaN              NaN                         NaN
      140       NaN         NaN              NaN                         NaN
      141       NaN         NaN              NaN                         NaN
      142       NaN         NaN              NaN                         NaN
      143       NaN         NaN              NaN                         NaN
      144       NaN         NaN              NaN                         NaN
      145       NaN         NaN              NaN                         NaN
      146       NaN         NaN              NaN                         NaN
      147       NaN         NaN              NaN                         NaN
      148       NaN         NaN              NaN                         NaN
      149       NaN         NaN              NaN                         NaN
      150       NaN         NaN              NaN                         NaN
      151       NaN         NaN              NaN                         NaN
      152       NaN         NaN              NaN                         NaN
      153       NaN         NaN              NaN                         NaN
      154       NaN         NaN              NaN                         NaN
      155       NaN         NaN              NaN                         NaN
      156       NaN         NaN              NaN                         NaN
      157       NaN         NaN              NaN                         NaN
      158       NaN         NaN              NaN                         NaN
      159       NaN         NaN              NaN                         NaN
      160       NaN         NaN              NaN                         NaN
      161       NaN         NaN              NaN                         NaN
      162       NaN         NaN              NaN                         NaN
      163       NaN         NaN              NaN                         NaN
      164       NaN         NaN              NaN                         NaN
      165       NaN         NaN              NaN                         NaN
      166       NaN         NaN              NaN                         NaN
      167       NaN         NaN              NaN                         NaN
      168       NaN         NaN              NaN                         NaN
      169       NaN         NaN              NaN                         NaN
      170       NaN         NaN              NaN                         NaN
      171       NaN         NaN              NaN                         NaN
      172       NaN         NaN              NaN                         NaN
      173       NaN         NaN              NaN                         NaN
      174       NaN         NaN              NaN                         NaN
      175       NaN         NaN              NaN                         NaN
      176       NaN         NaN              NaN                         NaN
      177       NaN         NaN              NaN                         NaN
      178       NaN         NaN              NaN                         NaN
      179       NaN         NaN              NaN                         NaN
      180       NaN         NaN              NaN                         NaN
      181       NaN         NaN              NaN                         NaN
      182       NaN         NaN              NaN                         NaN
      183       NaN         NaN              NaN                         NaN
      184       NaN         NaN              NaN                         NaN
      185       NaN         NaN              NaN                         NaN
      186       NaN         NaN              NaN                         NaN
      187       NaN         NaN              NaN                         NaN
      188       NaN         NaN              NaN                         NaN
      189       NaN         NaN              NaN                         NaN
      190       NaN         NaN              NaN                         NaN
      191       NaN         NaN              NaN                         NaN
      192       NaN         NaN              NaN                         NaN
      193       NaN         NaN              NaN                         NaN
      194       NaN         NaN              NaN                         NaN
      195       NaN         NaN              NaN                         NaN
      196       NaN         NaN              NaN                         NaN
      197       NaN         NaN              NaN                         NaN
      198       NaN         NaN              NaN                         NaN
      199       NaN         NaN              NaN                         NaN
      200       NaN         NaN              NaN                         NaN
      201       NaN         NaN              NaN                         NaN
      202       NaN         NaN              NaN                         NaN
      203       NaN         NaN              NaN                         NaN
      204       NaN         NaN              NaN                         NaN
      205       NaN         NaN              NaN                         NaN
      206       NaN         NaN              NaN                         NaN
      207       NaN         NaN              NaN                         NaN
      208       NaN         NaN              NaN                         NaN
      209       NaN         NaN              NaN                         NaN
      210       NaN         NaN              NaN                         NaN
      211       NaN         NaN              NaN                         NaN
      212       NaN         NaN              NaN                         NaN
      213       NaN         NaN              NaN                         NaN
      214       NaN         NaN              NaN                         NaN
      215       NaN         NaN              NaN                         NaN
      216       NaN         NaN              NaN                         NaN
      217       NaN         NaN              NaN                         NaN
      218       NaN         NaN              NaN                         NaN
      219       NaN         NaN              NaN                         NaN
      220       NaN         NaN              NaN                         NaN
      221       NaN         NaN              NaN                         NaN
      222       NaN         NaN              NaN                         NaN
      223       NaN         NaN              NaN                         NaN
      224       NaN         NaN              NaN                         NaN
      225       NaN         NaN              NaN                         NaN
      226       NaN         NaN              NaN                         NaN
      227       NaN         NaN              NaN                         NaN
      228       NaN         NaN              NaN                         NaN
      229       NaN         NaN              NaN                         NaN
      230       NaN         NaN              NaN                         NaN
      231       NaN         NaN              NaN                         NaN
      232       NaN         NaN              NaN                         NaN
      233       NaN         NaN              NaN                         NaN
      234       NaN         NaN              NaN                         NaN
      235       NaN         NaN              NaN                         NaN
      236       NaN         NaN              NaN                         NaN
      237       NaN         NaN              NaN                         NaN
      238       NaN         NaN              NaN                         NaN
      239       NaN         NaN              NaN                         NaN
      240       NaN         NaN              NaN                         NaN
      241       NaN         NaN              NaN                         NaN
      242       NaN         NaN              NaN                         NaN
      243       NaN         NaN              NaN                         NaN
      244       NaN         NaN              NaN                         NaN
      245       NaN         NaN              NaN                         NaN
      246       NaN         NaN              NaN                         NaN
      247       NaN         NaN              NaN                         NaN
      248       NaN         NaN              NaN                         NaN
      249       NaN         NaN              NaN                         NaN
      250       NaN         NaN              NaN                         NaN
      251       NaN         NaN              NaN                         NaN
      252       NaN         NaN              NaN                         NaN
      253       NaN         NaN              NaN                         NaN
      254       NaN         NaN              NaN                         NaN
      255       NaN         NaN              NaN                         NaN
      256       NaN         NaN              NaN                         NaN
      257       NaN         NaN              NaN                         NaN
      258       NaN         NaN              NaN                         NaN
      259       NaN         NaN              NaN                         NaN
      260       NaN         NaN              NaN                         NaN
      261       NaN         NaN              NaN                         NaN
      262       NaN         NaN              NaN                         NaN
      263       NaN         NaN              NaN                         NaN
      264       NaN         NaN              NaN                         NaN
      265       NaN         NaN              NaN                         NaN
      266       NaN         NaN              NaN                         NaN
      267       NaN         NaN              NaN                         NaN
      268       NaN         NaN              NaN                         NaN
      
      [[3]]
          i_track  meta                            msg
      1         0  TRUE    track_name, drum-t1-1-t1, 0
      2         0 FALSE          note_on, 0, 43, 72, 9
      3         0 FALSE          note_on, 0, 39, 64, 9
      4         0 FALSE         note_on, 0, 36, 101, 9
      5         0  TRUE           set_tempo, 0, 666666
      6         0  TRUE time_signature, 0, 4, 4, 24, 8
      7         0 FALSE       note_off, 240, 43, 72, 9
      8         0 FALSE         note_off, 0, 39, 64, 9
      9         0 FALSE        note_off, 0, 36, 101, 9
      10        0 FALSE       note_on, 240, 42, 101, 9
      11        0 FALSE         note_on, 0, 38, 101, 9
      12        0 FALSE        note_on, 240, 43, 64, 9
      13        0 FALSE        note_off, 0, 42, 101, 9
      14        0 FALSE        note_off, 0, 38, 101, 9
      15        0 FALSE       note_off, 240, 43, 64, 9
      16        0 FALSE         note_on, 0, 36, 101, 9
      17        0 FALSE      note_off, 240, 36, 101, 9
      18        0 FALSE        note_on, 240, 43, 60, 9
      19        0 FALSE         note_on, 0, 42, 101, 9
      20        0 FALSE       note_off, 240, 43, 60, 9
      21        0 FALSE        note_off, 0, 42, 101, 9
      22        0 FALSE        note_on, 240, 43, 60, 9
      23        0 FALSE          note_on, 0, 39, 66, 9
      24        0 FALSE         note_on, 0, 36, 101, 9
      25        0 FALSE       note_off, 240, 43, 60, 9
      26        0 FALSE         note_off, 0, 39, 66, 9
      27        0 FALSE        note_off, 0, 36, 101, 9
      28        0 FALSE       note_on, 240, 42, 101, 9
      29        0 FALSE         note_on, 0, 38, 101, 9
      30        0 FALSE        note_on, 240, 43, 53, 9
      31        0 FALSE        note_off, 0, 42, 101, 9
      32        0 FALSE        note_off, 0, 38, 101, 9
      33        0 FALSE       note_off, 240, 43, 53, 9
      34        0 FALSE         note_on, 0, 36, 101, 9
      35        0 FALSE      note_off, 240, 36, 101, 9
      36        0 FALSE        note_on, 240, 43, 52, 9
      37        0 FALSE          note_on, 0, 42, 66, 9
      38        0 FALSE       note_off, 240, 43, 52, 9
      39        0 FALSE         note_off, 0, 42, 66, 9
      40        0 FALSE        note_on, 240, 43, 72, 9
      41        0 FALSE          note_on, 0, 39, 64, 9
      42        0 FALSE         note_on, 0, 36, 101, 9
      43        0 FALSE       note_off, 240, 43, 72, 9
      44        0 FALSE         note_off, 0, 39, 64, 9
      45        0 FALSE        note_off, 0, 36, 101, 9
      46        0 FALSE       note_on, 240, 42, 101, 9
      47        0 FALSE         note_on, 0, 38, 101, 9
      48        0 FALSE        note_on, 240, 43, 64, 9
      49        0 FALSE        note_off, 0, 42, 101, 9
      50        0 FALSE        note_off, 0, 38, 101, 9
      51        0 FALSE       note_off, 240, 43, 64, 9
      52        0 FALSE         note_on, 0, 36, 101, 9
      53        0 FALSE      note_off, 240, 36, 101, 9
      54        0 FALSE        note_on, 240, 43, 60, 9
      55        0 FALSE         note_on, 0, 42, 101, 9
      56        0 FALSE       note_off, 240, 43, 60, 9
      57        0 FALSE        note_off, 0, 42, 101, 9
      58        0 FALSE        note_on, 240, 43, 60, 9
      59        0 FALSE          note_on, 0, 39, 66, 9
      60        0 FALSE         note_on, 0, 36, 101, 9
      61        0 FALSE       note_off, 240, 43, 60, 9
      62        0 FALSE         note_off, 0, 39, 66, 9
      63        0 FALSE        note_off, 0, 36, 101, 9
      64        0 FALSE       note_on, 240, 42, 101, 9
      65        0 FALSE         note_on, 0, 38, 101, 9
      66        0 FALSE        note_on, 240, 43, 53, 9
      67        0 FALSE        note_off, 0, 42, 101, 9
      68        0 FALSE        note_off, 0, 38, 101, 9
      69        0 FALSE       note_off, 240, 43, 53, 9
      70        0 FALSE         note_on, 0, 36, 101, 9
      71        0 FALSE      note_off, 240, 36, 101, 9
      72        0 FALSE        note_on, 240, 43, 52, 9
      73        0 FALSE          note_on, 0, 42, 66, 9
      74        0 FALSE       note_off, 240, 43, 52, 9
      75        0 FALSE         note_off, 0, 42, 66, 9
      76        0 FALSE        note_on, 240, 43, 72, 9
      77        0 FALSE          note_on, 0, 39, 64, 9
      78        0 FALSE         note_on, 0, 36, 101, 9
      79        0 FALSE       note_off, 240, 43, 72, 9
      80        0 FALSE         note_off, 0, 39, 64, 9
      81        0 FALSE        note_off, 0, 36, 101, 9
      82        0 FALSE       note_on, 240, 42, 101, 9
      83        0 FALSE         note_on, 0, 38, 101, 9
      84        0 FALSE        note_on, 240, 43, 64, 9
      85        0 FALSE        note_off, 0, 42, 101, 9
      86        0 FALSE        note_off, 0, 38, 101, 9
      87        0 FALSE       note_off, 240, 43, 64, 9
      88        0 FALSE         note_on, 0, 36, 101, 9
      89        0 FALSE      note_off, 240, 36, 101, 9
      90        0 FALSE        note_on, 240, 43, 60, 9
      91        0 FALSE         note_on, 0, 42, 101, 9
      92        0 FALSE       note_off, 240, 43, 60, 9
      93        0 FALSE        note_off, 0, 42, 101, 9
      94        0 FALSE        note_on, 240, 43, 60, 9
      95        0 FALSE          note_on, 0, 39, 66, 9
      96        0 FALSE         note_on, 0, 36, 101, 9
      97        0 FALSE       note_off, 240, 43, 60, 9
      98        0 FALSE         note_off, 0, 39, 66, 9
      99        0 FALSE        note_off, 0, 36, 101, 9
      100       0 FALSE       note_on, 240, 42, 101, 9
      101       0 FALSE         note_on, 0, 38, 101, 9
      102       0 FALSE        note_on, 240, 43, 53, 9
      103       0 FALSE        note_off, 0, 42, 101, 9
      104       0 FALSE        note_off, 0, 38, 101, 9
      105       0 FALSE       note_off, 240, 43, 53, 9
      106       0 FALSE         note_on, 0, 36, 101, 9
      107       0 FALSE      note_off, 240, 36, 101, 9
      108       0 FALSE        note_on, 240, 43, 52, 9
      109       0 FALSE          note_on, 0, 42, 66, 9
      110       0 FALSE       note_off, 240, 43, 52, 9
      111       0 FALSE         note_off, 0, 42, 66, 9
      112       0 FALSE        note_on, 240, 43, 81, 9
      113       0 FALSE         note_on, 0, 36, 101, 9
      114       0 FALSE       note_off, 240, 43, 81, 9
      115       0 FALSE        note_off, 0, 36, 101, 9
      116       0 FALSE       note_on, 240, 42, 101, 9
      117       0 FALSE          note_on, 0, 39, 57, 9
      118       0 FALSE         note_on, 0, 38, 101, 9
      119       0 FALSE        note_on, 240, 43, 60, 9
      120       0 FALSE        note_off, 0, 42, 101, 9
      121       0 FALSE         note_off, 0, 39, 57, 9
      122       0 FALSE        note_off, 0, 38, 101, 9
      123       0 FALSE       note_off, 240, 43, 60, 9
      124       0 FALSE         note_on, 0, 36, 101, 9
      125       0 FALSE      note_off, 240, 36, 101, 9
      126       0 FALSE        note_on, 240, 43, 66, 9
      127       0 FALSE         note_on, 0, 42, 101, 9
      128       0 FALSE       note_off, 240, 43, 66, 9
      129       0 FALSE        note_off, 0, 42, 101, 9
      130       0 FALSE        note_on, 240, 43, 66, 9
      131       0 FALSE         note_on, 0, 36, 101, 9
      132       0 FALSE       note_off, 240, 43, 66, 9
      133       0 FALSE        note_off, 0, 36, 101, 9
      134       0 FALSE        note_on, 240, 46, 81, 9
      135       0 FALSE          note_on, 0, 45, 67, 9
      136       0 FALSE          note_on, 0, 39, 60, 9
      137       0 FALSE         note_on, 0, 38, 101, 9
      138       0 FALSE       note_off, 240, 46, 81, 9
      139       0 FALSE         note_off, 0, 45, 67, 9
      140       0 FALSE         note_off, 0, 39, 60, 9
      141       0 FALSE        note_off, 0, 38, 101, 9
      142       0 FALSE        note_on, 240, 39, 59, 9
      143       0 FALSE         note_on, 0, 36, 101, 9
      144       0 FALSE       note_off, 240, 39, 59, 9
      145       0 FALSE          note_on, 0, 39, 55, 9
      146       0 FALSE        note_off, 0, 36, 101, 9
      147       0 FALSE        note_on, 240, 45, 63, 9
      148       0 FALSE          note_on, 0, 43, 52, 9
      149       0 FALSE         note_on, 0, 42, 101, 9
      150       0 FALSE         note_off, 0, 39, 55, 9
      151       0 FALSE          note_on, 0, 39, 55, 9
      152       0 FALSE       note_off, 240, 45, 63, 9
      153       0 FALSE         note_off, 0, 43, 52, 9
      154       0 FALSE        note_off, 0, 42, 101, 9
      155       0 FALSE          note_on, 0, 42, 59, 9
      156       0 FALSE         note_off, 0, 39, 55, 9
      157       0 FALSE          note_on, 0, 39, 57, 9
      158       0 FALSE       note_off, 240, 42, 59, 9
      159       0 FALSE         note_off, 0, 39, 57, 9
      160       0  TRUE                end_of_track, 1
      161       1  TRUE      track_name, Audio+MIDI, 0
      162       1 FALSE         note_on, 0, 50, 82, 15
      163       1 FALSE      note_off, 240, 50, 82, 15
      164       1 FALSE      note_on, 3000, 45, 85, 15
      165       1 FALSE       note_on, 600, 50, 81, 15
      166       1 FALSE        note_off, 0, 45, 85, 15
      167       1 FALSE      note_off, 240, 50, 81, 15
      168       1 FALSE      note_on, 3120, 45, 69, 15
      169       1 FALSE       note_on, 480, 50, 69, 15
      170       1 FALSE        note_off, 0, 45, 69, 15
      171       1 FALSE      note_off, 360, 50, 69, 15
      172       1 FALSE      note_on, 2400, 45, 82, 15
      173       1 FALSE      note_off, 960, 45, 82, 15
      174       1 FALSE       note_on, 120, 50, 72, 15
      175       1 FALSE     note_off, 1080, 50, 72, 15
      176       1 FALSE       note_on, 360, 57, 79, 15
      177       1 FALSE      note_off, 480, 57, 79, 15
      178       1 FALSE         note_on, 0, 55, 50, 15
      179       1 FALSE      note_off, 480, 55, 50, 15
      180       1 FALSE         note_on, 0, 53, 73, 15
      181       1 FALSE      note_off, 480, 53, 73, 15
      182       1 FALSE         note_on, 0, 52, 69, 15
      183       1 FALSE      note_off, 480, 52, 69, 15
      184       1 FALSE         note_on, 0, 48, 85, 15
      185       1 FALSE      note_off, 480, 48, 85, 15
      186       1  TRUE                end_of_track, 1
      187       2  TRUE    track_name, Audio+MIDI 1, 0
      188       2 FALSE        note_on, 54, 62, 78, 15
      189       2 FALSE        note_on, 10, 57, 78, 15
      190       2 FALSE         note_on, 6, 65, 72, 15
      191       2 FALSE      note_off, 283, 65, 72, 15
      192       2 FALSE       note_off, 16, 62, 78, 15
      193       2 FALSE       note_off, 55, 57, 78, 15
      194       2 FALSE      note_on, 1049, 62, 57, 15
      195       2 FALSE         note_on, 9, 57, 53, 15
      196       2 FALSE         note_on, 8, 65, 58, 15
      197       2 FALSE     note_off, 1652, 65, 58, 15
      198       2 FALSE        note_off, 8, 62, 57, 15
      199       2 FALSE       note_off, 47, 57, 53, 15
      200       2 FALSE       note_on, 142, 62, 61, 15
      201       2 FALSE         note_on, 9, 57, 53, 15
      202       2 FALSE         note_on, 8, 65, 58, 15
      203       2 FALSE      note_off, 188, 62, 61, 15
      204       2 FALSE        note_off, 8, 65, 58, 15
      205       2 FALSE       note_off, 24, 57, 53, 15
      206       2 FALSE       note_on, 275, 62, 47, 15
      207       2 FALSE         note_on, 8, 57, 42, 15
      208       2 FALSE         note_on, 9, 65, 46, 15
      209       2 FALSE      note_off, 337, 65, 46, 15
      210       2 FALSE      note_off, 266, 62, 47, 15
      211       2 FALSE      note_off, 119, 57, 42, 15
      212       2 FALSE       note_on, 657, 62, 56, 15
      213       2 FALSE         note_on, 9, 57, 53, 15
      214       2 FALSE         note_on, 8, 65, 58, 15
      215       2 FALSE     note_off, 1651, 65, 58, 15
      216       2 FALSE       note_off, 24, 62, 56, 15
      217       2 FALSE       note_off, 24, 57, 53, 15
      218       2 FALSE       note_on, 173, 62, 49, 15
      219       2 FALSE         note_on, 9, 57, 42, 15
      220       2 FALSE         note_on, 8, 65, 49, 15
      221       2 FALSE      note_off, 266, 65, 49, 15
      222       2 FALSE       note_off, 24, 62, 49, 15
      223       2 FALSE       note_off, 24, 57, 42, 15
      224       2 FALSE       note_on, 212, 62, 37, 15
      225       2 FALSE         note_on, 9, 57, 34, 15
      226       2 FALSE         note_on, 8, 65, 51, 15
      227       2 FALSE      note_off, 314, 65, 51, 15
      228       2 FALSE        note_off, 8, 62, 37, 15
      229       2 FALSE       note_off, 79, 57, 34, 15
      230       2 FALSE      note_on, 1018, 57, 58, 15
      231       2 FALSE         note_on, 8, 62, 60, 15
      232       2 FALSE         note_on, 8, 65, 56, 15
      233       2 FALSE     note_off, 1746, 65, 56, 15
      234       2 FALSE        note_off, 8, 62, 60, 15
      235       2 FALSE       note_off, 71, 57, 58, 15
      236       2 FALSE       note_on, 447, 62, 50, 15
      237       2 FALSE         note_on, 8, 57, 40, 15
      238       2 FALSE         note_on, 8, 65, 52, 15
      239       2 FALSE      note_off, 431, 62, 50, 15
      240       2 FALSE        note_off, 9, 65, 52, 15
      241       2 FALSE       note_off, 70, 57, 40, 15
      242       2 FALSE       note_on, 917, 62, 63, 15
      243       2 FALSE         note_on, 8, 59, 69, 15
      244       2 FALSE         note_on, 8, 67, 58, 15
      245       2 FALSE      note_off, 252, 62, 63, 15
      246       2 FALSE        note_off, 8, 67, 58, 15
      247       2 FALSE       note_off, 23, 59, 69, 15
      248       2 FALSE       note_on, 268, 59, 58, 15
      249       2 FALSE         note_on, 8, 62, 58, 15
      250       2 FALSE         note_on, 8, 67, 58, 15
      251       2 FALSE      note_off, 587, 62, 58, 15
      252       2 FALSE        note_off, 9, 67, 58, 15
      253       2 FALSE       note_off, 63, 59, 58, 15
      254       2 FALSE        note_on, 87, 59, 52, 15
      255       2 FALSE         note_on, 8, 67, 60, 15
      256       2 FALSE         note_on, 8, 62, 65, 15
      257       2 FALSE      note_off, 251, 62, 65, 15
      258       2 FALSE       note_off, 32, 67, 60, 15
      259       2 FALSE       note_off, 48, 59, 52, 15
      260       2 FALSE       note_on, 337, 59, 57, 15
      261       2 FALSE         note_on, 9, 62, 60, 15
      262       2 FALSE         note_on, 8, 67, 57, 15
      263       2 FALSE      note_off, 173, 62, 60, 15
      264       2 FALSE       note_off, 31, 59, 57, 15
      265       2 FALSE        note_off, 9, 67, 57, 15
      266       2 FALSE       note_on, 266, 62, 82, 15
      267       2 FALSE        note_off, 5, 62, 82, 15
      268       2  TRUE                end_of_track, 1
      


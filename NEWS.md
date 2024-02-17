# pyramidi

Changes:

* **0.2**

   * **breaking changes** -
      * `MidiFramer$play()`:
         * `overwrite` argument was changed to `TRUE` by default. Be careful not to OVERWRITE files!
         * `marie_kondo` argument was added which DELETES intermediate files.
         * the `live` argument also allows to play the sound in the R console (setting this to `TRUE` when rendering an Rmarkdown document will probably result in an error).

      * removed `play_midi_frame()` and replaced it by `player()` (the workhorse of the new `MidiFramer$play()` method)

   * New features:
      * the play() method and player (see above :) - play your modified sounds directly from the `MidiFramer` object in the R console! 🥳
      * The new dependency on the fluidsynth & av packages now allows to remove the audio files from git (needed for the audio on the pkgdown site; except for the README where it's still needed as knitted locally...). In other words, you can now also play the generated sounds on a deployed site without pushing a copy of the audio files to the server where the site is deployed (the pkgdown site on github pages is generated with new R randomness in some of the sounds, every time a new commit is pushed to main. Before the audio generation only worked locally on my machine. Now, installing the package and its dependencies makes things start to work remotely.).
      * The dependency on raudiomate was replaced by fluidsynth & av (thanks to @jeroen! #4).

* **0.1**

   * **Breaking changes** -
      * rename functions:

         * rename df_long_mod to midi_frame_mod
         * rename merge_long_events to merge_midi_frames
         * rename triage_measured_unnested to split_midi_frame

      * adapted to new names in miditapyr:

         * rename functions:
            * `midi_to_df()` to `frame_midi()`
            * `tidy_df()` to `unnest_midi()`
            * `compact_df()` to `nest_midi()`
            * `df_to_midi()` to `write_midi()`

         * rename classes:
            * `MidiFrameTidy` to `MidiFrameUnnested`
            * `MidiFrameCompact` to `MidiFrameNested`

         * rename "tidy" to "unnested"
         * rename "compact" to "nested"
         * rename midi_frame_nested.midi_frame_nested to midi_frame_nested.df
         * rename midi_frame_unnested.midi_frame_unnested to midi_frame_unnested.df

   * added new vignettes:
      * "Composing from R"
      * "Midi manipulation with pyramidi"
      * "Package workflow"
      * "Using mido directly from R"

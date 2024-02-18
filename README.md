
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pyramidi <a href='https://github.com/urswilke/pyramidi/'><img src='man/figures/hex_logo_pyramidi.png' align="right" height="139" /></a>

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/urswilke/pyramidi.svg?branch=master)](https://travis-ci.org/github/urswilke/pyramidi)
[![Codecov test
coverage](https://codecov.io/gh/urswilke/pyramidi/branch/master/graph/badge.svg)](https://app.codecov.io/gh/urswilke/pyramidi?branch=master)
[![R-CMD-check](https://github.com/urswilke/pyramidi/workflows/R-CMD-check/badge.svg)](https://github.com/urswilke/pyramidi/actions)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

# Introduction

pyramidi is a very experimental package to generate / manipulate midi
data from R. Be aware that a lot of the code I’ve written some years ago
hurts my eyes when I look at it now :) Midi data is read into
dataframes, using the python package
[miditapyr](https://pypi.org/project/miditapyr/) under the hood (which
itself uses the excellent [mido](https://github.com/mido/mido)). The
notes’ midi information (one line per `note_on`/`note_off` midi event)
is translated into a wide format (one line per note). This format
facilitates some manipulations of the notes’ data and also plotting them
in piano roll plots. Finally, the modified dataframes can be written
back to midi files (again using miditapyr).

Thus, you can manipulate all the intermediate dataframes and create midi
files from R. However, you need to make sure yourself that the midi
files you write can be understood by your softsynth. The data is not yet
validated by pyramidi, but mido (also used to write midi files) already
catches some of the possible inconsistencies.

If you’re new to midi, [mido’s
documentation](https://mido.readthedocs.io/en/latest/) might be a good
start.

## New in version 0.2

The midi data can now be

- played live in the R console OR generate a sound file and a html audio
  player when knitting rmarkdown documents thanks to the excellent R
  packages [fluidsynth](https://github.com/ropensci/fluidsynth) &
  [av](https://github.com/ropensci/av/) (see the documentation of the
  [`play()`](https://urswilke.github.io/pyramidi/reference/MidiFramer.html#method-play-)
  method in the `MidiFramer` class and its helper function `player()`
  which use
- `fluidsynth::midi_convert()` to synthesize midi to wav files (needs
  [fluidsynth](https://www.fluidsynth.org/) installed, but if I
  understand correctly R will do that for you),
- `av::av_audio_convert()` to convert wav to mp3 files

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
needs to be installed in your python environment used by
[reticulate](https://github.com/rstudio/reticulate).

``` sh
pip install miditapyr
```

But if everything works as I believe it should, miditapyr is
automatically installed if you install pyramidi, as soon as you access
the module for the first time.

Otherwise, you can also install it in your reticulate python environment
with the included helper function:

``` r
pyramidi::install_miditapyr()
```

*I’m not sure if that works on windows too. Perhaps there you have to
manually configure your reticulate environment.*

## Usage

### Generate a `MidiFramer` object

We can create a `MidiFramer` object by passing the file path to the
constructor method
([`new()`](https://urswilke.github.io/pyramidi/reference/MidiFramer.html#method-new)).

``` r
library(pyramidi)
library(dplyr)
midi_file_string <- system.file("extdata", "test_midi_file.mid", package = "pyramidi")
mfr <- MidiFramer$new(midi_file_string)
```

The object contains the midi data in various dataframe formats and an
interface to the miditapyr
[miditapyr.MidiFrames](https://miditapyr.readthedocs.io/en/latest/notebooks/midi_frame_usage.html)
object `mfr$mf`. You can write the midi file resulting of the
`MidiFramer` object to disk:

``` r
mfr$mf$write_file("/path/to/your/midifile.mid")
```

### Modifying midi data

In the `MidiFramer` object, we can modify `mfr$df_notes_wide`, the notes
in note-wise wide format (`note_on` & `note_off` events in the same
line). Thus we don’t need to worry which midi events belong together

Let’s look at a small example. We’ll define a function to replace every
note with a random midi note between 60 & 71::

``` r
mod <- function(dfn, seed) {
  n_notes <- sum(!is.na(dfn$note))
  dfn %>% mutate(note = ifelse(
    !is.na(note),
    sample(60:71, n_notes, TRUE),
    note
  ))
}
```

When we call the `update_notes_wide()` method, the midi data in `mfr` is
updated:

``` r
mfr$update_notes_wide(mod)
```

### Writing modified midi files

Thus, we can now save the modifications to a midi file:

``` r
mfr$mf$write_file("mod_test_midi_file.mid")
```

### Synthesizing and playing audio

See the `vignette("pyramidi", package = "pyramidi")` to see how you can
synthesize the midi data to wav, convert to mp3 if you want, and then
embed a player in your rmarkdown html document with

``` r
mfr$play("mod_test_midi_file.mp3")
```

<audio controls="">
<source src="https://urswilke.github.io/pyramidi/articles/mod_test_midi_file.mp3" type="audio/mp3"/>
</audio>

\*The player only appears in the
[docs](https://urswilke.github.io/pyramidi/index.html#synthesizing-and-playing-audio).

Even if that sound is very weird, I was very happy not having to listen
to the package midi file over and over again. :)

## Documentation

You can find the complete online documentation of the package
[here](https://urswilke.github.io/pyramidi/).

- See the `vignette("pyramidi")` for a brief usage introduction how to
  manipulate midi data.
- The `vignette("compose")` shows a more extended example how to compose
  music and generate midi files from scratch.
- `vignette("package_workflow")` shows in detail the structure of the
  `MidiFramer` class and the functions of the pyramidi package.
- `vignette("functions_usage")` illustrates the low-level functions of
  the pyramidi package, that `MidiFramer` objects use under the hood.

## pyramidi out in the wild

To see examples where pyramidi is used for midi mangling in R dataframes
etc. (amongst plenty other of his awesome writings about music), please
check out Matt Crump’s
[blog](https://homophony.quest/notes.html#category=midi) and his package
[midiblender](https://www.crumplab.com/midiblender/articles/Getting_started.html)!

## Related R packages

- The [tabr](https://github.com/leonawicz/tabr) package is a massive
  music notation, transcription and analysis program allowing to create
  musical scores (using Lilypond). It allows to read midi files
  (wrapping tuneR; see below) and also to export them (also using
  Lilypond).
- The [gm](https://github.com/flujoo/gm) package also allows to create
  and show musical scores using musescore. It also allows to export the
  music to audio (also using musescore) and to embed the players in html
  documents.
- The [noon package](https://github.com/ColinFay/noon) wraps node.js
  libraries and can be used to read live midi input port data. I wrote a
  small [blog
  post](https://urssblogg.netlify.app/post/2020-10-24-live-recording-of-a-midi-controller-via-mido-inport/)
  how reading a midi port can also be done in R with
  [mido](https://mido.readthedocs.io/en/latest/ports.html).
  Interestingly, the node.js libraries and mido rely on a the same C++
  library [RtMidi](http://www.music.mcgill.ca/~gary/rtmidi/index.html).
- The [tuneR](https://cran.r-project.org/package=tuneR) package can also
  read in midi data. See the `vignette("tuner")`, for an example how you
  can transform the tuner format into the pyramidi format.

## R packages used

This package stands on the shoulders of giants. A big thank you to the
authors of the following libraries!

| Package    | Version    | Citation                                                                                      |
|:-----------|:-----------|:----------------------------------------------------------------------------------------------|
| av         | 0.9.0      | Ooms (2023)                                                                                   |
| base       | 4.3.2      | R Core Team (2023a)                                                                           |
| details    | 0.3.0      | Sidi (2022)                                                                                   |
| DiagrammeR | 1.0.11     | Iannone and Roy (2024)                                                                        |
| fluidsynth | 1.0.0      | Ooms (2024)                                                                                   |
| glue       | 1.7.0      | Hester and Bryan (2024)                                                                       |
| grateful   | 0.2.6      | Rodriguez-Sanchez and Jackson (2023)                                                          |
| htmltools  | 0.5.7      | Cheng et al. (2023)                                                                           |
| knitr      | 1.45       | Xie (2014); Xie (2015); Xie (2023)                                                            |
| pichor     | 0.0.0.9030 | Andersen (2024)                                                                               |
| pkgdown    | 2.0.7      | Wickham, Hesselberth, and Salmon (2022)                                                       |
| R6         | 2.5.1      | Chang (2021)                                                                                  |
| reticulate | 1.35.0     | Ushey, Allaire, and Tang (2024)                                                               |
| rmarkdown  | 2.25       | Xie, Allaire, and Grolemund (2018); Xie, Dervieux, and Riederer (2020); Allaire et al. (2023) |
| spelling   | 2.2.1      | Ooms and Hester (2023)                                                                        |
| testthat   | 3.2.1      | Wickham (2011)                                                                                |
| tidyverse  | 2.0.0      | Wickham et al. (2019)                                                                         |
| tools      | 4.3.2      | R Core Team (2023b)                                                                           |
| tuneR      | 1.4.6      | Ligges et al. (2023)                                                                          |
| usethis    | 2.2.2      | Wickham et al. (2023)                                                                         |
| zeallot    | 0.1.0      | Teetor (2018)                                                                                 |

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-rmarkdown2023" class="csl-entry">

Allaire, JJ, Yihui Xie, Christophe Dervieux, Jonathan McPherson, Javier
Luraschi, Kevin Ushey, Aron Atkins, et al. 2023.
*<span class="nocase">rmarkdown</span>: Dynamic Documents for r*.
<https://github.com/rstudio/rmarkdown>.

</div>

<div id="ref-pichor" class="csl-entry">

Andersen, Mikkel Meyer. 2024. *<span class="nocase">pichor</span>: Piano
Chords in r*.

</div>

<div id="ref-R6" class="csl-entry">

Chang, Winston. 2021. *R6: Encapsulated Classes with Reference
Semantics*. <https://CRAN.R-project.org/package=R6>.

</div>

<div id="ref-htmltools" class="csl-entry">

Cheng, Joe, Carson Sievert, Barret Schloerke, Winston Chang, Yihui Xie,
and Jeff Allen. 2023. *<span class="nocase">htmltools</span>: Tools for
HTML*. <https://CRAN.R-project.org/package=htmltools>.

</div>

<div id="ref-glue" class="csl-entry">

Hester, Jim, and Jennifer Bryan. 2024.
*<span class="nocase">glue</span>: Interpreted String Literals*.
<https://CRAN.R-project.org/package=glue>.

</div>

<div id="ref-DiagrammeR" class="csl-entry">

Iannone, Richard, and Olivier Roy. 2024. *DiagrammeR: Graph/Network
Visualization*. <https://CRAN.R-project.org/package=DiagrammeR>.

</div>

<div id="ref-tuneR" class="csl-entry">

Ligges, Uwe, Sebastian Krey, Olaf Mersmann, and Sarah Schnackenberg.
2023. *<span class="nocase">tuneR</span>: Analysis of Music and Speech*.
<https://CRAN.R-project.org/package=tuneR>.

</div>

<div id="ref-av" class="csl-entry">

Ooms, Jeroen. 2023. *<span class="nocase">av</span>: Working with Audio
and Video in r*. <https://CRAN.R-project.org/package=av>.

</div>

<div id="ref-fluidsynth" class="csl-entry">

———. 2024. *<span class="nocase">fluidsynth</span>: Read and Play
Digital Music (MIDI) in r*. [https://docs.ropensci.org/fluidsynth/
https://ropensci.r-universe.dev/fluidsynth](https://docs.ropensci.org/fluidsynth/
https://ropensci.r-universe.dev/fluidsynth).

</div>

<div id="ref-spelling" class="csl-entry">

Ooms, Jeroen, and Jim Hester. 2023.
*<span class="nocase">spelling</span>: Tools for Spell Checking in r*.
<https://CRAN.R-project.org/package=spelling>.

</div>

<div id="ref-base" class="csl-entry">

R Core Team. 2023a. *R: A Language and Environment for Statistical
Computing*. Vienna, Austria: R Foundation for Statistical Computing.
<https://www.R-project.org/>.

</div>

<div id="ref-tools" class="csl-entry">

———. 2023b. *R: A Language and Environment for Statistical Computing*.
Vienna, Austria: R Foundation for Statistical Computing.
<https://www.R-project.org/>.

</div>

<div id="ref-grateful" class="csl-entry">

Rodriguez-Sanchez, Francisco, and Connor P. Jackson. 2023.
*<span class="nocase">grateful</span>: Facilitate Citation of r
Packages*. <https://pakillo.github.io/grateful/>.

</div>

<div id="ref-details" class="csl-entry">

Sidi, Jonathan. 2022. *<span class="nocase">details</span>: Create
Details HTML Tag for Markdown and Package Documentation*.
<https://CRAN.R-project.org/package=details>.

</div>

<div id="ref-zeallot" class="csl-entry">

Teetor, Nathan. 2018. *<span class="nocase">zeallot</span>: Multiple,
Unpacking, and Destructuring Assignment*.
<https://CRAN.R-project.org/package=zeallot>.

</div>

<div id="ref-reticulate" class="csl-entry">

Ushey, Kevin, JJ Allaire, and Yuan Tang. 2024.
*<span class="nocase">reticulate</span>: Interface to “Python”*.
<https://CRAN.R-project.org/package=reticulate>.

</div>

<div id="ref-testthat" class="csl-entry">

Wickham, Hadley. 2011. “<span class="nocase">testthat</span>: Get
Started with Testing.” *The R Journal* 3: 5–10.
<https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

</div>

<div id="ref-tidyverse" class="csl-entry">

Wickham, Hadley, Mara Averick, Jennifer Bryan, Winston Chang, Lucy
D’Agostino McGowan, Romain François, Garrett Grolemund, et al. 2019.
“Welcome to the <span class="nocase">tidyverse</span>.” *Journal of Open
Source Software* 4 (43): 1686. <https://doi.org/10.21105/joss.01686>.

</div>

<div id="ref-usethis" class="csl-entry">

Wickham, Hadley, Jennifer Bryan, Malcolm Barrett, and Andy Teucher.
2023. *<span class="nocase">usethis</span>: Automate Package and Project
Setup*. <https://CRAN.R-project.org/package=usethis>.

</div>

<div id="ref-pkgdown" class="csl-entry">

Wickham, Hadley, Jay Hesselberth, and Maëlle Salmon. 2022.
*<span class="nocase">pkgdown</span>: Make Static HTML Documentation for
a Package*. <https://CRAN.R-project.org/package=pkgdown>.

</div>

<div id="ref-knitr2014" class="csl-entry">

Xie, Yihui. 2014. “<span class="nocase">knitr</span>: A Comprehensive
Tool for Reproducible Research in R.” In *Implementing Reproducible
Computational Research*, edited by Victoria Stodden, Friedrich Leisch,
and Roger D. Peng. Chapman; Hall/CRC.

</div>

<div id="ref-knitr2015" class="csl-entry">

———. 2015. *Dynamic Documents with R and Knitr*. 2nd ed. Boca Raton,
Florida: Chapman; Hall/CRC. <https://yihui.org/knitr/>.

</div>

<div id="ref-knitr2023" class="csl-entry">

———. 2023. *<span class="nocase">knitr</span>: A General-Purpose Package
for Dynamic Report Generation in r*. <https://yihui.org/knitr/>.

</div>

<div id="ref-rmarkdown2018" class="csl-entry">

Xie, Yihui, J. J. Allaire, and Garrett Grolemund. 2018. *R Markdown: The
Definitive Guide*. Boca Raton, Florida: Chapman; Hall/CRC.
<https://bookdown.org/yihui/rmarkdown>.

</div>

<div id="ref-rmarkdown2020" class="csl-entry">

Xie, Yihui, Christophe Dervieux, and Emily Riederer. 2020. *R Markdown
Cookbook*. Boca Raton, Florida: Chapman; Hall/CRC.
<https://bookdown.org/yihui/rmarkdown-cookbook>.

</div>

</div>

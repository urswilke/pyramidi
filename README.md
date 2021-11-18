
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pyramidi <a href='https://github.com/urswilke/pyramidi/'><img src='man/figures/hex_logo_pyramidi.png' align="right" height="139" /></a>

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/urswilke/pyramidi.svg?branch=master)](https://travis-ci.org/github/urswilke/pyramidi)
[![Codecov test
coverage](https://codecov.io/gh/urswilke/pyramidi/branch/master/graph/badge.svg)](https://codecov.io/gh/urswilke/pyramidi?branch=master)
[![R-CMD-check](https://github.com/urswilke/pyramidi/workflows/R-CMD-check/badge.svg)](https://github.com/urswilke/pyramidi/actions)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

**Work in progress!**

♪ ♫ ♩ ♬ ♪ ♫ ♩ ♬ ♪ ♫ ♩ ♬ ♪ ♫ ♩ ♬ ♪ ♫ ♩ ♬ ♪ ♫ ♩ ♬ ♪ ♫ ♩ ♬ ♪ ♫ ♩ ♬ ♪ ♫ ♩ ♬

# Introduction

The goal of pyramidi is to reproducibly manipulate midi data from R.
Midi data is read into dataframes, using the python package
[miditapyr](https://pypi.org/project/miditapyr/) under the hood (which
itself uses [mido](https://github.com/mido/mido)). Then the midi
information (one line per midi event) is translated into a wide format
(one line per note). The wide format facilitates some manipulations of
the notes’ data and also plotting them in piano roll plots. Finally, the
modified dataframes can be written back to midi files (again using
miditapyr).

Thus, you can manipulate all the intermediate dataframes and write midi
files from R. However, you need to make sure yourself that the midi
files you write can be understood by your softsynth. The data is not yet
validated, but [mido](https://github.com/mido/mido) (also used to write
midi files) already catches some of the possible inconsistencies.

Via the small helper package
[raudiomate](https://github.com/urswilke/raudiomate) the midi data can
be

-   synthesized to wav files with `raudiomate::synthesize_midi()` (needs
    [fluidsynth](https://www.fluidsynth.org/) installed),
-   converted to mp3 files with `raudiomate::convert_to_mp3()` (needs
    [ffmpeg](https://www.ffmpeg.org/)),
-   and played in rmarkdown documents with the `play()` method of
    `MidiFramer` (using `raudiomate::player()`).

If you’re new to midi, [mido’s
documentation](https://mido.readthedocs.io/en/latest/) might be a good
start.

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

But if everything works as it should 🤞😅, miditapyr is automatically
installed if you install pyramidi, as soon as you access the module for
the first time.

Otherwise, you can also install it in your reticulate python environment
with the included helper function:

``` r
pyramidi::install_miditapyr()
```

*I’m not sure if that works on windows too. Perhaps there you have to
configure your reticulate environment manually.*

## Usage

### Generate a `MidiFramer` object

We can create an `MidiFramer` object by passing the file file path to
the  
constructor.

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

In the R midi frames object, we can modify `mfr$df_notes_wide`, the
notes in notewise wide format (`note_on` & `note_off` events in the same
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

See the `vignette("midi_framer", package = "pyramidi")` to see how you
can synthesize the midi data to wav, convert to mp3 if you want, and
then embed a player in your rmarkdown html document with

``` r
mfr$play()
```

<audio controls="">
<source src="https://urswilke.github.io/pyramidi/articles/mod_test_midi_file.mp3" type="audio/mp3"/>
</audio>

## Related R packages

-   The [noon package](https://github.com/ColinFay/noon) wraps node.js
    libraries and can be used to read live midi input port data. I wrote
    a small [blog
    post](https://urssblogg.netlify.app/post/2020-10-24-live-recording-of-a-midi-controller-via-mido-inport/)
    how reading a midi port can also be done in R with
    [mido](https://mido.readthedocs.io/en/latest/ports.html).
    Interestingly, the node.js libraries and mido rely on a the same C++
    library
    [RtMidi](http://www.music.mcgill.ca/~gary/rtmidi/index.html).
-   The [tuneR](https://cran.r-project.org/package=tuneR) package can
    also read in midi data. See this
    [article](https://urswilke.github.io/pyramidi/articles/tuner.html),
    for an example how you can transform the tuner format into the
    pyramidi format.

<!-- 
The following as well as the bibtex file "pkg-refs.bib" were automatically
created with the commands:
library(grateful)
pkgs <- scan_packages()
# don't know why including "R" gives an error ??
pkgs <- pkgs[!pkgs %in% c("R", "pyramidi", "raudiomate")] %>% c("rayrender", "magick")
cites <- get_citations(pkgs)
rmd <- create_rmd(cites)

-> then copy the list in the created refs.Rmd below

-->

## R packages used

This package stands on the shoulders of giants. A big thank you to the
authors of the following libraries!

-   base (R Core Team 2021)
-   pkgdown (Wickham and Hesselberth 2020)
-   dplyr (Wickham et al. 2021)
-   forcats (Wickham 2021a)
-   tibble (Müller and Wickham 2021)
-   tidyr (Wickham 2021c)
-   usethis (Wickham, Bryan, and Barrett 2021)
-   pichor (Andersen 2021)
-   purrr (Henry and Wickham 2020)
-   rvest (Wickham 2021b)
-   reticulate (Ushey, Allaire, and Tang 2021)
-   details (Sidi 2020)
-   stringr (Wickham 2019)
-   ggplot2 (Wickham 2016)
-   zeallot (Teetor 2018)
-   magrittr (Bache and Wickham 2020)
-   rlang (Henry and Wickham 2021)
-   R6 (Chang 2021)
-   knitr (Xie 2014)
-   rmarkdown (Xie, Dervieux, and Riederer 2020)
-   testthat (Wickham 2011)
-   htmltools (Cheng et al. 2021)
-   covr (Hester 2020)
-   rayrender (Morgan-Wall 2021)
-   magick (Ooms 2021)

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-pichor" class="csl-entry">

Andersen, Mikkel Meyer. 2021. *Pichor: Piano Chords in r*.

</div>

<div id="ref-magrittr" class="csl-entry">

Bache, Stefan Milton, and Hadley Wickham. 2020. *Magrittr: A
Forward-Pipe Operator for r*.
<https://CRAN.R-project.org/package=magrittr>.

</div>

<div id="ref-R6" class="csl-entry">

Chang, Winston. 2021. *R6: Encapsulated Classes with Reference
Semantics*. <https://CRAN.R-project.org/package=R6>.

</div>

<div id="ref-htmltools" class="csl-entry">

Cheng, Joe, Carson Sievert, Barret Schloerke, Winston Chang, Yihui Xie,
and Jeff Allen. 2021. *Htmltools: Tools for HTML*.
<https://CRAN.R-project.org/package=htmltools>.

</div>

<div id="ref-purrr" class="csl-entry">

Henry, Lionel, and Hadley Wickham. 2020. *Purrr: Functional Programming
Tools*. <https://CRAN.R-project.org/package=purrr>.

</div>

<div id="ref-rlang" class="csl-entry">

———. 2021. *Rlang: Functions for Base Types and Core r and ’Tidyverse’
Features*. <https://CRAN.R-project.org/package=rlang>.

</div>

<div id="ref-covr" class="csl-entry">

Hester, Jim. 2020. *Covr: Test Coverage for Packages*.
<https://CRAN.R-project.org/package=covr>.

</div>

<div id="ref-rayrender" class="csl-entry">

Morgan-Wall, Tyler. 2021. *Rayrender: Build and Raytrace 3d Scenes*.
<https://CRAN.R-project.org/package=rayrender>.

</div>

<div id="ref-tibble" class="csl-entry">

Müller, Kirill, and Hadley Wickham. 2021. *Tibble: Simple Data Frames*.
<https://CRAN.R-project.org/package=tibble>.

</div>

<div id="ref-magick" class="csl-entry">

Ooms, Jeroen. 2021. *Magick: Advanced Graphics and Image-Processing in
r*. <https://CRAN.R-project.org/package=magick>.

</div>

<div id="ref-base" class="csl-entry">

R Core Team. 2021. *R: A Language and Environment for Statistical
Computing*. Vienna, Austria: R Foundation for Statistical Computing.
<https://www.R-project.org/>.

</div>

<div id="ref-details" class="csl-entry">

Sidi, Jonathan. 2020. *Details: Create Details HTML Tag for Markdown and
Package Documentation*. <https://CRAN.R-project.org/package=details>.

</div>

<div id="ref-zeallot" class="csl-entry">

Teetor, Nathan. 2018. *Zeallot: Multiple, Unpacking, and Destructuring
Assignment*. <https://CRAN.R-project.org/package=zeallot>.

</div>

<div id="ref-reticulate" class="csl-entry">

Ushey, Kevin, JJ Allaire, and Yuan Tang. 2021. *Reticulate: Interface to
’Python’*. <https://CRAN.R-project.org/package=reticulate>.

</div>

<div id="ref-testthat" class="csl-entry">

Wickham, Hadley. 2011. “Testthat: Get Started with Testing.” *The R
Journal* 3: 5–10.
<https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

</div>

<div id="ref-ggplot2" class="csl-entry">

———. 2016. *Ggplot2: Elegant Graphics for Data Analysis*.
Springer-Verlag New York. <https://ggplot2.tidyverse.org>.

</div>

<div id="ref-stringr" class="csl-entry">

———. 2019. *Stringr: Simple, Consistent Wrappers for Common String
Operations*. <https://CRAN.R-project.org/package=stringr>.

</div>

<div id="ref-forcats" class="csl-entry">

———. 2021a. *Forcats: Tools for Working with Categorical Variables
(Factors)*. <https://CRAN.R-project.org/package=forcats>.

</div>

<div id="ref-rvest" class="csl-entry">

———. 2021b. *Rvest: Easily Harvest (Scrape) Web Pages*.
<https://CRAN.R-project.org/package=rvest>.

</div>

<div id="ref-tidyr" class="csl-entry">

———. 2021c. *Tidyr: Tidy Messy Data*.
<https://CRAN.R-project.org/package=tidyr>.

</div>

<div id="ref-usethis" class="csl-entry">

Wickham, Hadley, Jennifer Bryan, and Malcolm Barrett. 2021. *Usethis:
Automate Package and Project Setup*.
<https://CRAN.R-project.org/package=usethis>.

</div>

<div id="ref-dplyr" class="csl-entry">

Wickham, Hadley, Romain François, Lionel Henry, and Kirill Müller. 2021.
*Dplyr: A Grammar of Data Manipulation*.
<https://CRAN.R-project.org/package=dplyr>.

</div>

<div id="ref-pkgdown" class="csl-entry">

Wickham, Hadley, and Jay Hesselberth. 2020. *Pkgdown: Make Static HTML
Documentation for a Package*.
<https://CRAN.R-project.org/package=pkgdown>.

</div>

<div id="ref-knitr" class="csl-entry">

Xie, Yihui. 2014. “Knitr: A Comprehensive Tool for Reproducible Research
in R.” In *Implementing Reproducible Computational Research*, edited by
Victoria Stodden, Friedrich Leisch, and Roger D. Peng. Chapman;
Hall/CRC. <http://www.crcpress.com/product/isbn/9781466561595>.

</div>

<div id="ref-rmarkdown" class="csl-entry">

Xie, Yihui, Christophe Dervieux, and Emily Riederer. 2020. *R Markdown
Cookbook*. Boca Raton, Florida: Chapman; Hall/CRC.
<https://bookdown.org/yihui/rmarkdown-cookbook>.

</div>

</div>

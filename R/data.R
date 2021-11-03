#' Table of midi notes
#'
#' A table containing the midi pitches and their note names
#'
#' @examples
#' midi_defs
#'
#' @format A data frame with 127 rows and 2 variables:
#' \describe{
#'   \item{note}{integer from 0 - 127 containing the midi pitches}
#'   \item{note_name}{name of the note and the octave}
#'   ...
#' }
"midi_defs"


#' Table of piano keys coordinates
#'
#' A table containing the piano keys coordinates. Each piano key is centered at
#' the midi note value it represents.
#'
#' @examples
#' library(ggplot2)
#' # Print dataframe:
#' piano_keys_coordinates
#' # Plot the keyboard:
#' piano_keys_coordinates %>%
#'   # plot white keys first that they don't cover half of the black keys:
#'   dplyr::arrange(layer) %>%
#'   ggplot(aes(ymin = ymin, ymax = ymax, xmin = xmin, xmax = xmax, fill = factor(layer))) +
#'   geom_rect(color = "black", show.legend = FALSE) +
#'   scale_fill_manual(values = c("#ffffdd", "#113300")) +
#'   coord_fixed(ratio = 10)
#'
#' @format A data frame with 127 rows and 6 variables:
#' \describe{
#'   \item{midi}{integer from 0 - 127 containing the midi pitches}
#'   \item{layer}{integer 1 or 2 depending on whether key is white (1) or black (2)}
#'   \item{xmin}{xmin coordinate of the key}
#'   \item{ymin}{ymin coordinate of the key}
#'   \item{xmax}{xmax coordinate of the key}
#'   \item{ymax}{ymax coordinate of the key}
#'   ...
#' }
"piano_keys_coordinates"



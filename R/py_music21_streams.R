dt_stuff <- function(s) {
  stream2df <- function(s) {
    # s$makeMeasures(inPlace = TRUE)
    tibble(event = reticulate::iterate(s$recurse())) %>%
      mutate(classes2 = map(event, ~ .x$classes)) %>% #if not renamed, vis_drake_graphs will mix both together
      mutate(
        i = row_number(),
        name = map(event, as.character),
        temp = TRUE
      ) %>%
      unnest(classes2) %>%
      spread(classes2, temp, fill = FALSE) %>%
      data.table::as.data.table()

  }
  # s <- (ms$corpus$parse('bwv66.6'))
  ss <- stream2df(s) %>% as_tibble()
  dt <- ss %>% data.table::as.data.table()

  get_pitch <- function(x) {map_chr(x, ~.x$name)}
  get_octave <- function(x) {map_dbl(x, ~.x$pitch$implicitOctave)}
  get_offset <- function(x) {map_dbl(x, ~.x$offset)}
  get_name <- function(x) {map_chr(x, ~.x$nameWithOctave)}
  get_id <- function(x) {map_chr(x, ~.x$id)}

  if_midi <- possibly(function(x) x$pitch$midi, NA)
  get_midi <- function(event) event %>% map_dbl(if_midi)

  data.table::setDT(dt)[Note == TRUE,
                        c("midi",
                          "i_offset",
                          "nameWithOctave") :=
                          list(get_midi(event),
                               get_offset(event),
                               get_name(event))][
                                 Measure == TRUE,
                                 c("m_offset") :=
                                   get_offset(event)


                                 ]
  data.table::setDT(dt)[Note == TRUE,
                        `:=`(
                          "pitch" = get_pitch(event),
                          "midi" = get_midi(event),
                          "offset" = get_offset(event),
                          "nameWithOctave" = get_name(event)
                        )]
  data.table::setDT(dt)[Measure == TRUE,
                        `:=`(
                          # "m_id" = get_id(event),
                          "m_offset" = get_offset(event)
                        )]
  get_act_site <- function(x) {map(x, ~.x$activeSite$id)}

  data.table::setDT(dt)[,
                        `:=`(
                          "global_offset" = get_offset(event),
                          "id" = get_id(event),
                          "active_site" = get_act_site(event) %>% as.character() %>% na_if("NULL")
                        )]
  dt
}

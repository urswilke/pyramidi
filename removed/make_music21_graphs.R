#
#
#
#
#
# meta_names <- c("metadata.Metadata>", "Inst",
#                 "clef.TrebleClef>", "f#", "meter.TimeSignature",
#                 "layout.SystemLayout>", "bar.Barline", "clef.BassClef>", "layout.StaffGroup",
#                 NA)
#
#
#
# plot_measure_graphs <- function(dt) {
#   edges =
#     dt[]  %>%
#     as_tibble() %>%
#     # drop_na() %>%
#     select(from = active_site, to = id, global_offset, type = name, Instrument) %>%
#     mutate(type = as.character(type) %>% str_remove(" .*") %>% str_remove("^<music21.")) %>%
#     mutate(type = case_when(Instrument  | type %in% meta_names ~ "meta",
#                             TRUE ~ type)) %>%
#     filter(type != "meta")
#   # %>%
#   #   mutate(from = ifelse(is.na(from), "main", from))
#   nodes =
#     dt %>%
#     as_tibble() %>%
#     fill(m_offset) %>% fill(offset, .direction = "up") %>% mutate(o = offset + m_offset) %>%
#     select(name = id, type = name, Instrument, midi, o, pitch, Part) %>%
#     mutate(part_id = cumsum(Part)) %>%
#     mutate(type = as.character(type) %>% str_remove(" .*") %>% str_remove("^<music21.")) %>%
#     mutate(type = case_when(Instrument  | type %in% meta_names ~ "meta",
#                             TRUE ~ type)) %>%
#     arrange(desc(type == "stream.Part"),
#             desc(type == "meta"),
#             # desc(type == "stream.Measure"),
#             o) %>%
#     filter(type != "meta") %>%
#     bind_rows(tibble(name = edges$from[1]))
#
#
#   norm_midi_diff <- function(midi) {
#     ma <- max(midi, na.rm = T)
#     mi <- min(midi, na.rm = T)
#     (midi - mean(mi + ma) / 2) / (ma - mi)
#   }
#
#   # nodes <-
#   #   nodes %>%
#   #   bind_cols(df_coord_sugi) %>%
#   #   mutate(y = ifelse(y == 1 & !is.na(midi),
#   #                     y = y + norm_midi_diff(midi),
#   #                     y),
#   #          z = ifelse(!is.na(part_id), part_id, 0),
#   #          x = row_number())
#
#   #2nd design:
#   edges2 <- edges %>% left_join(nodes %>% select(name, pitch), by = c("to" = "name"))
#   dfg <- tbl_graph(nodes, edges)
#   df_coord_sugi <- igraph::layout.sugiyama(dfg) %>% .$layout %>% as_tibble() %>% rename(x = V1, y = V2)
#   nodes2 <-
#     nodes %>%
#     bind_cols(df_coord_sugi) %>%
#     mutate(z = ifelse(!is.na(part_id), part_id, 0),
#            z = ifelse(type == "note.Note" & y == 1 & !is.na(midi),
#                       2.5 - norm_midi_diff(midi),
#                       z),
#            x = row_number())
#   dfg2 <- tbl_graph(nodes2, edges2)
#
#
#   aa <- rglplot(dfg, vertex.label = NA, vertex.color = factor(rev(nodes$pitch)) %>% as.numeric(), vertex.size = 6, xlab = "x", ylab = "y")
#   # df_coord_circle <- igraph::layout.circle(dfg) %>% .$layout %>% as_tibble() %>% rename(x = V1, y = V2)
#
#   g1 <- dfg %>%
#     ggraph(layout = 'dendrogram') +
#     # geom_edge_link(aes(color = global_offset)) +
#     geom_edge_link() +
#     geom_node_point(aes(color = type), size = 8) +
#     geom_node_text(aes(label = name), colour = 'black', vjust = 0.4) +
#     theme_graph()
#
#   g2 <- dfg %>%
#     ggraph(layout = 'dendrogram', circular = TRUE) +
#     # geom_edge_link(aes(color = global_offset)) +
#     geom_edge_diagonal() +#aes(color= global_offset)) +
#     geom_node_point(aes(color = pitch), size = 8) +
#     geom_node_text(aes(label = name), colour = 'white', vjust = 0.4) +
#     theme_graph()
#   g3 <-
#     dfg %>%
#     ggraph(layout = 'linear') +
#     geom_edge_arc(aes(colour = global_offset)) +
#     geom_node_point(aes(color = type))
#   g4 <-
#     dfg2 %>%
#     ggraph(layout = 'linear', circular = T) +
#     # geom_edge_density(aes(edge_fill = pitch)) +
#     geom_edge_arc(aes(colour = pitch)) +
#     geom_node_point(aes(color = pitch)) +
#     theme_graph()
#   list(g1, g2, g3, g4) %>% set_names()
#   mget(c("g1", "g2", "g3", "g4"))
# }

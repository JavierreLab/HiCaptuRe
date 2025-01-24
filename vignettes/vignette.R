## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- comment=F, message=F,R.options------------------------------------------
library(HiCaptuRe)

## -----------------------------------------------------------------------------
seqmonk <- system.file("extdata", "seqmonk_example.seqmonk", package="HiCaptuRe")
ibed <- system.file("extdata", "ibed_example.ibed", package="HiCaptuRe")
annotation <- system.file("extdata", "annotation_example.txt", package="HiCaptuRe")
regions <- system.file("extdata", "regions_example.bed", package="HiCaptuRe")

## -----------------------------------------------------------------------------
interactions_seqmonk <- load_interactions(file = seqmonk)
interactions_seqmonk

## -----------------------------------------------------------------------------
interactions_ibed <- load_interactions(file = ibed)
interactions_ibed

## -----------------------------------------------------------------------------
interactions_seqmonk <- annotate_interactions(interactions = interactions_seqmonk, annotation = annotation)
interactions_seqmonk

## -----------------------------------------------------------------------------
distances <- distance_summary(interactions = interactions_seqmonk, breaks = seq(0,10^6,10^5), sample = "Example")

## ---- eval=F------------------------------------------------------------------
#  distances

## ----echo=F-------------------------------------------------------------------
DT::datatable(distances)

## ---- eval=T------------------------------------------------------------------
plot_distance_summary(distances = distances,type_of_value = "absolute")

## ---- eval=T------------------------------------------------------------------
plot_distance_summary(distances = distances,type_of_value = "by_int_type")

## ---- eval=T------------------------------------------------------------------
plot_distance_summary(distances = distances,type_of_value = "by_total")

## ---- warning=FALSE-----------------------------------------------------------
interactions_list <- list(seqmonk=interactions_seqmonk,
                          ibed=interactions_ibed)
intersections <- intersect_interactions(interactions_list = interactions_list, distance.boxplot = T)

## -----------------------------------------------------------------------------
names(intersections$intersections)

## ---- eval=T------------------------------------------------------------------
plot(intersections$venn)

## ---- eval=T------------------------------------------------------------------
intersections$upset_plot

## -----------------------------------------------------------------------------
int_regions <- interactionsByRegions(interactions = interactions_seqmonk,
                                 regions = regions)
int_regions[,3:9]

## -----------------------------------------------------------------------------
HOXA <- c("HOXA1","HOXA2","HOXA3","HOXA4","HOXA5","HOXA6","HOXA7","HOXA8","HOXA9","HOXA10","HOXA11","HOXA12","HOXA13")

int_genes <- interactionsByBaits(interactions = interactions_seqmonk, baits = HOXA)


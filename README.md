# Aggregate_MCD12

Determine land cover in gridcells of any size from MCD12Q1 (500-m)

This repo was created to determine:

1. The 500-m land cover classification for a list of sites, such as Fluxnet.
2. Calculate the percentage of each land cover class at coarser resolutions, such as 0.5 degree.
3. Extract these percentages for the gridcells in which Flux sites fall.

## Notes

There are 240 MODIS gridcells (500-m) in 1 degree. The aggregate function scales by the number of gridcells on each side. For 1 degree, this would be 240, half-degree 120, quarter-degree 60, and so on.

The MCD12Q1 is in sinusoidal. This code does no reprojection; the sites are projected into sinusoidal for extraction.

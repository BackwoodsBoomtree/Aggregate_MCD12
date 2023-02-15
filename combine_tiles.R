
library(terra)
library(ncdf4)

hdf_input <- "G:/MCD12Q1/original"
output    <- "G:/MCD12Q1/combined/MCD12Q1.061.2021.nc"

hdf_list <- list.files(hdf_input, pattern = "*.hdf$", full.names = TRUE, recursive = TRUE)

for (i in 1:length(hdf_list)) {
  tile <- rast(hdf_list[i])[[1]]

  if (i == 1) {
    combo_list <- list(tile)
  } else {
    combo_list <- c(combo_list, tile)
  }
  print(paste0("Done with ", i, " of ", length(hdf_list)))
}

collection <- sprc(combo_list)
combo      <- merge(collection)

writeCDF(combo, filename = output, varname = "IGBP Land Cover", unit = "", compression = 4, missval = -9999, overwrite = TRUE)

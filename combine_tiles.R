
library(terra)

hdf_input <- "G:/MCD12Q1/original"
output    <- "G:/MCD12Q1/combined/MCD12Q1.061.2021.nc"

hdf_list <- list.files(hdf_input, pattern = "*.hdf$", full.names = TRUE, recursive = TRUE)
# 
# for (i in 1:length(hdf_list)) {
#   tile <- rast(hdf_list[i])[[1]]
#   
#   if (i == 1) {
#     combo <- tile
#   } else {
#     combo <- merge(combo, tile)
#   }
# }

collection <- sprc(hdf_list)

combo <- merge(collection)

combo <- combo[[1]] # subset for first layer (can not be done during sprc or merge)


writeCDF(combo, filename = output, varname = "Land Cover Type", unit = "", compression = 4, missval = -9999, overwrite = TRUE)

# for (i in 1:length(hdf_list)) {
#   r <- rast(hdf_list[i])[[1]]
#   
#   if (i == 1) {
#     collection <- sprc(r)
#   } else {
#     collection <- c(collection, r)
#   }
# }

collection <- sprc(hdf_list)

combo <- merge(collection)

combo <- combo[[1]]


hdf_list2 <- hdf_list[1:3]

test <- sprc(hdf_list2, sds = 1)

test2 <- merge(test)

test3 <- subset(test, 1)

test <- sprc(rast(hdf_list[1])[[1]])

test <- rast(hdf_list2[1], xmin = -20015109, xmax = 20015109, ymin = -10007555, ymax= 10007555)[[1]]

, xmin = -20015109, xmax = 20015109, ymin = -10007555, ymax= 10007555
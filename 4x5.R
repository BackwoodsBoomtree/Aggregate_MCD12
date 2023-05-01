library(terra)

mcd12c1 <- rast("G:/MCD12C1/v061/MCD12C1.A2014001.061.2022165213124.hdf")

mcd12proj <- project(mcd12c1, "+proj=longlat +datum=WGS84")

writeCDF(mcd12proj, "G:/MCD12C1/v061/MCD12C1.A2014001.061.nc", varname = "LC_TYPE", longname = "MCD12C1 V061 in WGS84", compression = 4)


mcd12c1 <- rast("G:/MCD12C1/v061/MCD12C1.A2001001.061.2022146170409.hdf")

mcd12proj <- project(mcd12c1, "+proj=longlat +datum=WGS84")

writeCDF(mcd12proj, "G:/MCD12C1/v061/MCD12C1.A2001001.061.nc", varname = "LC_TYPE", longname = "MCD12C1 V061 in WGS84", compression = 4)
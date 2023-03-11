
library(terra)

lc_input   <- "G:/MCD12Q1/combined/MCD12Q1.061.2021.nc"
tower_csv  <- "C:/Russell/Git/R_personal/Aggregate_MCD12/tower_sites_2023_03_11.csv"
csv_out    <- "C:/Russell/Git/R_personal/Aggregate_MCD12/fluxnet_tower_lc_1.0.csv"
sample_res <- 240 # In number of gridcells in each direction

# Import Data
lc_sin   <- rast(lc_input)
df_tower <- read.csv(tower_csv, header = TRUE, sep = ",")

vect_tower <- vect(df_tower, geom=c("lon", "lat"), crs = "EPSG:4326", keepgeom = FALSE)
vect_tower <- project(vect_tower, lc_sin)

# plot(lc_sin)
# plot(vect_tower, add = TRUE)

# Fill NAs with water (missing tiles over ocean)
m      <- matrix(c(NA, 17), ncol = 2, byrow = TRUE)
lc_sin <- classify(lc_sin, m)

ext_lc              <- extract(lc_sin, vect_tower)
df_tower$LC_MCD12Q1 <- ext_lc[,2]

# Replace
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 1]  <- "ENF"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 2]  <- "EBF"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 3]  <- "DNF"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 4]  <- "DBF"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 5]  <- "MF"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 6]  <- "CSH"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 7]  <- "OSH"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 8]  <- "WSA"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 9]  <- "SAV"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 10] <- "GRA"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 11] <- "WET"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 12] <- "CRO"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 13] <- "URB"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 14] <- "CVM"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 15] <- "SNO"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 16] <- "BSV"
df_tower["LC_MCD12Q1"][df_tower["LC_MCD12Q1"] == 17] <- "WAT"


# Get aggregate percentage of pixels at coarser resolution
lc_total <- aggregate(lc_sin, sample_res, fun=function(x) {length(x)})
lc_enf   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 1])}) / lc_total * 100
lc_ebf   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 2])}) / lc_total * 100
lc_dnf   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 3])}) / lc_total * 100
lc_dbf   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 4])}) / lc_total * 100
lc_mf    <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 5])}) / lc_total * 100
lc_csh   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 6])}) / lc_total * 100
lc_osh   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 7])}) / lc_total * 100
lc_wsa   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 8])}) / lc_total * 100
lc_sav   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 9])}) / lc_total * 100
lc_gra   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 10])}) / lc_total * 100
lc_wet   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 11])}) / lc_total * 100
lc_cro   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 12])}) / lc_total * 100
lc_urb   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 13])}) / lc_total * 100
lc_cvm   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 14])}) / lc_total * 100
lc_sno   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 15])}) / lc_total * 100
lc_bsv   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 16])}) / lc_total * 100
lc_wat   <- aggregate(lc_sin, sample_res, fun=function(x) {length(x[x == 17])}) / lc_total * 100

# Extract LC Percentages from aggregated data
df_tower$ENF <- extract(lc_enf, vect_tower)[,2]
df_tower$EBF <- extract(lc_ebf, vect_tower)[,2]
df_tower$DNF <- extract(lc_dnf, vect_tower)[,2]
df_tower$DBF <- extract(lc_dbf, vect_tower)[,2]
df_tower$MF  <- extract(lc_mf, vect_tower)[,2]
df_tower$CSH <- extract(lc_csh, vect_tower)[,2]
df_tower$OSH <- extract(lc_osh, vect_tower)[,2]
df_tower$WSA <- extract(lc_wsa, vect_tower)[,2]
df_tower$SAV <- extract(lc_sav, vect_tower)[,2]
df_tower$GRA <- extract(lc_gra, vect_tower)[,2]
df_tower$WET <- extract(lc_wet, vect_tower)[,2]
df_tower$CRO <- extract(lc_cro, vect_tower)[,2]
df_tower$URB <- extract(lc_urb, vect_tower)[,2]
df_tower$CVM <- extract(lc_cvm, vect_tower)[,2]
df_tower$SNO <- extract(lc_sno, vect_tower)[,2]
df_tower$BSV <- extract(lc_bsv, vect_tower)[,2]
df_tower$WAT <- extract(lc_wat, vect_tower)[,2]

write.csv(df_tower, csv_out, row.names = FALSE)

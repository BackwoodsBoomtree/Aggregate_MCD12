
library(terra)

lc_input   <- "G:/ChloFluo/product/v01/1deg/ChloFluo.GPP.v01.1deg.CF80.2019.nc"
# lc_input  <- "G:/MCD12Q1/combined/MCD43Q1.061.2021.nc"
tower_csv  <- "C:/Russell/Git/R_personal/Aggregate_MCD12/location_fluxnet.csv"
csv_out    <- "C:/Russell/Git/R_personal/Aggregate_MCD12/fluxnet_tower_lc_0.5.csv"
sample_res <- 2 # In number of gridcells in each direction

# Import Data
lc       <- rast(lc_input)
df_tower <- read.csv(tower_csv, header = TRUE, sep = ",")

# Get aggregate percentage of pixels at coarser resolution
lc_total <- aggregate(lc, sample_res, fun=function(x) {length(x)})
lc_enf   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 1])}) / lc_total * 100
lc_ebf   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 2])}) / lc_total * 100
lc_dnf   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 3])}) / lc_total * 100
lc_dbf   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 4])}) / lc_total * 100
lc_mf    <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 5])}) / lc_total * 100
lc_csh   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 6])}) / lc_total * 100
lc_osh   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 7])}) / lc_total * 100
lc_wsa   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 8])}) / lc_total * 100
lc_sav   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 9])}) / lc_total * 100
lc_gra   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 10])}) / lc_total * 100
lc_wet   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 11])}) / lc_total * 100
lc_cro   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 12])}) / lc_total * 100
lc_urb   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 13])}) / lc_total * 100
lc_cvm   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 14])}) / lc_total * 100
lc_sno   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 15])}) / lc_total * 100
lc_bsv   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 16])}) / lc_total * 100
lc_wat   <- aggregate(lc, sample_res, fun=function(x) {length(x[x == 17])}) / lc_total * 100

# Extract LC from 500-m map and add to df
ext_lc                   <- extract(lc, df_tower[, 3:4])
df_tower$LC_MCD12Q1_2021 <- ext_lc[,2]
# Replace
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 1]  <- "ENF"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 2]  <- "EBF"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 3]  <- "DNF"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 4]  <- "DBF"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 5]  <- "MF"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 6]  <- "CSH"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 7]  <- "OSH"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 8]  <- "WSA"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 9]  <- "SAV"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 10] <- "GRA"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 11] <- "WET"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 12] <- "CRO"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 13] <- "URB"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 14] <- "CVM"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 15] <- "SNO"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 16] <- "BSV"
df_tower["LC_MCD12Q1_2021"][df_tower["LC_MCD12Q1_2021"] == 17] <- "WAT"

# Extract LC Percentages from aggregated data
df_tower$ENF <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$EBF <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$DNF <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$DBF <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$MF  <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$CSH <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$OSH <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$WSA <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$SAV <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$GRA <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$WET <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$CRO <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$URB <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$CVM <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$SNO <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$BSV <- extract(lc_enf, df_tower[, 3:4])[,2]
df_tower$WAT <- extract(lc_enf, df_tower[, 3:4])[,2]

write.csv(df_tower, csv_out, row.names = FALSE, col.names = TRUE)



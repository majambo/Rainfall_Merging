#CDTMergingccc
install.packages("devtools")
library(devtools)
install_github("rijaf-iri/CDT")
library(tcltk)
library(CDT)
startCDT() #step 1: download CHIRPS v2p0 data in netcdf format from IRI Data Library (use the following bounding box to download over Africa: Longitude: -20 (or 20W), 60 (60E), Latitude: -40 (40S), 40 (40N))

# step 2: need to format rainfall data from gauge stations into CDT format. YOu do this inside the CDT GUI
#step 3: CHIRPS merging with station data

cdtMergingPrecipCMD(time.step = "dekadal",
                    dates = list(from = "range", pars = list(start = "1981011", end = "2020123")),
                    station.data = list(file = "C:/Users/Public.SERVIR-LAWRENCE/Documents/repo/Rainfall_Merging/test.csv", sep = ",", na.strings = "-99"),
                    netcdf.data = list(dir = "C:/Users/Public.SERVIR-LAWRENCE/Documents/repo/Rainfall_Merging/CHIRPSv2_dekadal", 
                                       format = "chirps_%s%s%s.nc", varid = "prcp", ilon = 1, ilat = 2),
                    merge.method = list(method = "SBA", nrun = 3, pass = c(1, 0.75, 0.5)),
                    interp.method = list(method = "idw", nmin = 1, nmax = 10, maxdist = 2.5, use.block =
                                           TRUE, vargrd = FALSE, vgm.model = "Gau"), #c("Sph", "Exp", "Gau", "Pen")),
                    # auxvar = list(dem = FALSE, slope = FALSE, aspect = FALSE, lon = FALSE, lat = FALSE),
                    # dem.data = list(file = "", varid = "dem", ilon = 1, ilat = 2),
                    grid = list(from = "data", pars = NULL),
                    RnoR = list(use = FALSE, wet = 1, smooth = FALSE),
                    blank = list(data = FALSE, shapefile = ""),
                    output = list(dir = "C:/Users/Public.SERVIR-LAWRENCE/Documents/repo/Rainfall_Merging/CHIRPSv2_dekadal/output", format = "bwb_chirpsv2p0_%s%s%s.nc"),
                    precision = list(from.data = TRUE, prec = "short"),
                    GUI = FALSE
)

#end

#CHIRPS monthly merging with station monthly data

cdtMergingPrecipCMD(time.step = "monthly",
                    dates = list(from = "range", pars = list(start = "198101", end = "201812")),
                    station.data = list(file = "C:/Users/Public.SERVIR-LAWRENCE/Documents/repo/Rainfall_Merging/Monthly_CDT.csv", sep = ",", na.strings = "-99"),
                    netcdf.data = list(dir = "C:/Users/Public.SERVIR-LAWRENCE/Documents/repo/Rainfall_Merging/CHIRPSv2_monthly", 
                                       format = "chirps_%s%s.nc", varid = "precipitation", ilon = 1, ilat = 2),
                    merge.method = list(method = "SBA", nrun = 3, pass = c(1, 0.75, 0.5)),
                    interp.method = list(method = "idw", nmin = 2, nmax = 10, maxdist = 2.5, use.block =
                                           TRUE, vargrd = FALSE, vgm.model = "Gau"), #c("Sph", "Exp", "Gau", "Pen")),
                    # auxvar = list(dem = FALSE, slope = FALSE, aspect = FALSE, lon = FALSE, lat = FALSE),
                    # dem.data = list(file = "", varid = "dem", ilon = 1, ilat = 2),
                    grid = list(from = "data", pars = NULL),
                    RnoR = list(use = FALSE, wet = 1, smooth = FALSE),
                    blank = list(data = FALSE, shapefile = ""),
                    output = list(dir = "C:/Users/Public.SERVIR-LAWRENCE/Documents/repo/Rainfall_Merging/CHIRPSv2_monthly/output", format = "bwb_chirpsv2p0_%s%s.nc"),
                    precision = list(from.data = TRUE, prec = "short"),
                    GUI = FALSE
)


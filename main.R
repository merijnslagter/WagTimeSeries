#This is the main file to compare two rasters with different extent
library(raster)

source("NDVIcalc.R")
source("maskcloud.R")

untar(tarfile = '../WagTimeSeriesData/LC81970242014109-SC20141230042441.tar.gz', exdir = '../WagTimeSeriesData/wag8/')
untar(tarfile = '../WagTimeSeriesData/LT51980241990098-SC20150107121947.tar.gz', exdir = '../WagTimeSeriesData/wag5/')

list8 <- list.files(path='../WagTimeSeriesData/wag8/', pattern = glob2rx('*.tif'), full.names=TRUE)
list5 <- list.files(path='../WagTimeSeriesData/wag5/', pattern = glob2rx('*.tif'), full.names=TRUE)

wag8 <- stack(list8)
wag5 <- stack(list5)

wagCF8 <- overlay(x = wag8, y = wag8[[1]], fun = cloud2NA)
wagCF5 <- overlay(x = wag5, y = wag5[[1]], fun = cloud2NA)

ndvi8 <- ndvifun(wagCF8[[5]], wagCF8[[4]])
ndvi5 <- ndvifun(wagCF5[[4]], wagCF5[[3]])

ndvi5 <- intersect(ndvi5,ndvi8)
ndvi8 <- intersect(ndvi8,ndvi5)

ndvidiff <- ndvi8 -ndvi5

plot(ndvidiff)

#This is the main file to compare two rasters with different extent

#load libaries
library(raster)

#load other functions
source("NDVIcalc.R")
source("maskcloud.R")

#untar tar.gz files
untar(tarfile = '../WagTimeSeriesData/LC81970242014109-SC20141230042441.tar.gz', exdir = '../WagTimeSeriesData/wag8/')
untar(tarfile = '../WagTimeSeriesData/LT51980241990098-SC20150107121947.tar.gz', exdir = '../WagTimeSeriesData/wag5/')

#list all tif files  for both images
list8 <- list.files(path='../WagTimeSeriesData/wag8/', pattern = glob2rx('*.tif'), full.names=TRUE)
list5 <- list.files(path='../WagTimeSeriesData/wag5/', pattern = glob2rx('*.tif'), full.names=TRUE)

#create raster stacks
wag8 <- stack(list8)
wag5 <- stack(list5)

#remove clouded pixels; give NA values
wagCF8 <- overlay(x = wag8, y = wag8[[1]], fun = cloud2NA)
wagCF5 <- overlay(x = wag5, y = wag5[[1]], fun = cloud2NA)

#calculate ndvi values
ndvi8 <- ndvifun(wagCF8[[5]], wagCF8[[4]])
ndvi5 <- ndvifun(wagCF5[[4]], wagCF5[[3]])

#make sure extent is equal
ndvi5 <- intersect(ndvi5,ndvi8)
ndvi8 <- intersect(ndvi8,ndvi5)

#compare the two raster stacks
ndvidiff <- ndvi8 - ndvi5

plot(ndvidiff)

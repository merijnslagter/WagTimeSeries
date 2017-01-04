ndvifun <- function(red, nir) 
  {
    ndvi <- (nir - red)/(nir+red)
      return(ndvi)
        }
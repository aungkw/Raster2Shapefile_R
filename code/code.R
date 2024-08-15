library(terra)

r <- rast("data/Goulburn_DEM_Final.tif")
plot(r)

#reproject GDA94 Vicgrid (EPSG:3111) to WGS 84

WGS84 <- "+init=EPSG:4326"
r1 <- terra::project(r,WGS84)
plot(r1) #now r1 is in WGS84



#Create logical raster 'ras'.
#Compare every cell of 'r1' to -Inf (lowest possible value)
#Every cell in r1 will be greater than -Inf, making all cells in 'ras' TRUE.
ras <- r1 > -Inf
plot(ras)
#so it mark if r1 have cell value, it will me mark as TRUE. So it reduce the computation time.
#Compared to cells with data.

p <- as.polygons(ras, dissolve = TRUE)
plot(p)

#Check
#Extract spatial extent of r1
ext <- ext(r1)
plot(ext, lwd = 3, border = "cyan")
str(ext)

poly <- as.polygons(ext)
plot(poly,lwd = 3, border = "red")

plot(r1) #To make sure add=T works, leading plot
plot(poly, lwd = 3, border = "red", add = TRUE)
plot(p, lwd = 2, border = "blue", add = TRUE)

#Write .shp file

writeVector(p, file = "output/goulburn.shp", overwrite = T)


## ----setup, echo=FALSE, results="asis"----------------------------------------
source("setup.R")
setupKnitr(autoprint=TRUE)
set.seed(123L)

rgl_webshot_org <- Sys.setenv("RGL_USE_WEBSHOT"=FALSE)

## -----------------------------------------------------------------------------
## package installation directory depends on system
d <- system.file("data-raw", package="SurfaceMesh")
list.files(d)

## -----------------------------------------------------------------------------
view3d(0, -35, zoom=0.8)
shade3d(dataCyclide, color="orangered")

## -----------------------------------------------------------------------------
view3d(-55, -20, zoom=0.8)
shade3d(dataEntzenStar, col="steelblue2")

## -----------------------------------------------------------------------------
view3d(35, -20, zoom=0.8)
shade3d(toRGL(dataHopfTorus), color="darkred")

## -----------------------------------------------------------------------------
view3d(35, -20, zoom=0.8)
shade3d(dataICN5Deight, color="violetred")

## -----------------------------------------------------------------------------
view3d(20, 15, zoom=0.8)
shade3d(toRGL(dataOloid), color="darkviolet")

## -----------------------------------------------------------------------------
view3d(-15, -10, zoom=0.8)
shade3d(dataOrthoCircle, color="darkolivegreen4")

## -----------------------------------------------------------------------------
meshPentaPrism <- makeMesh(dataPentaPrism, triangulate=TRUE)
view3d(-15, -15, zoom=0.8)
shade3d(toRGL(meshPentaPrism), color="forestgreen")

## -----------------------------------------------------------------------------
view3d(-10, -20, zoom=0.8)
shade3d(dataSeptuaginta, color="orangered")

## -----------------------------------------------------------------------------
view3d(-10, -20, zoom=0.8)
shade3d(dataSolidMobiusStrip, color="darkred")

## -----------------------------------------------------------------------------
view3d(-25, -45, zoom=0.8)
shade3d(dataSphere, color="darkgoldenrod")
wire3d(dataSphere)

## -----------------------------------------------------------------------------
view3d(-25, -45, zoom=0.8)
shade3d(dataSpiderCage, color="mediumseagreen")

## -----------------------------------------------------------------------------
view3d(15, -20, zoom=0.8)
shade3d(dataToroHelix, color="violetred")

## -----------------------------------------------------------------------------
view3d(-20, -20, zoom=0.75)
shade3d(dataTorus, color="green")
wire3d(dataTorus)

## -----------------------------------------------------------------------------
meshTruncIcos <- makeMesh(dataTruncIcosahedron, triangulate=TRUE)
view3d(-15, -10, zoom=0.8)
shade3d(toRGL(meshTruncIcos), color="wheat2")

## -----------------------------------------------------------------------------
view3d(-15, -15, zoom=0.8)
shade3d(dataTubularKnot, color="royalblue3")

## -----------------------------------------------------------------------------
f_mesh   <- system.file("extdata", "dataCorner.off", package="SurfaceMesh")
mesh     <- makeMesh(f_mesh, verbose=FALSE)
mesh_rgl <- toRGL(mesh)

view3d(85, -65, zoom=0.8)
shade3d(mesh_rgl, col="turquoise4")

## -----------------------------------------------------------------------------
view3d(-5, -90, zoom=0.8)
shade3d(toRGL(dataHeart1), color="tomato")

## -----------------------------------------------------------------------------
view3d(-5, -90, zoom=0.8)
shade3d(toRGL(dataHeart2), color="gray")


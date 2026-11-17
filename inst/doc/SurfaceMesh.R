## ----setup, echo=FALSE, results="asis"----------------------------------------
source("setup.R")
setupKnitr(autoprint=TRUE)
set.seed(123)

rgl_webshot_org <- Sys.setenv("RGL_USE_WEBSHOT"=FALSE)

## -----------------------------------------------------------------------------
f_mesh   <- system.file("extdata", "dataCorner.off", package="SurfaceMesh")
mesh     <- makeMesh(f_mesh, verbose=FALSE)
mesh_rgl <- toRGL(mesh)

view3d(85, -65, zoom=0.8)
shade3d(mesh_rgl, col="wheat2")

## -----------------------------------------------------------------------------
dataTubularKnot

mesh <- makeMesh(dataTubularKnot)
mesh

## -----------------------------------------------------------------------------
mesh     <- makeMesh(dataSeptuaginta, triangulate=FALSE, verbose=FALSE)
mesh_rgl <- toRGL(mesh)
isTriangle(mesh)

mesh_tri     <- triangulateMesh(mesh)
mesh_tri_rgl <- toRGL(mesh_tri)

mfrow3d(1, 2)
view3d(0, 30, zoom=0.8)
wire3d(mesh_rgl)
next3d()
view3d(0, 30, zoom=0.8)
wire3d(mesh_tri_rgl)

## -----------------------------------------------------------------------------
mesh <- makeMesh(dataToroHelix, normals=TRUE)
mesh

## -----------------------------------------------------------------------------
mesh    <- makeMesh(dataToroHelix, normals=FALSE)
mesh_vn <- addVertexNormals(mesh)

mfrow3d(1, 2)
view3d(0, 30, zoom=0.8)
shade3d(toRGL(mesh), col="tomato")
next3d()
view3d(0, 30, zoom=0.8)
shade3d(toRGL(mesh_vn), col="turquoise4")

## -----------------------------------------------------------------------------
mesh <- makeMeshValid(dataSphere, normals=TRUE)
vn   <- getVertexNormals(mesh)
head(vn)

## -----------------------------------------------------------------------------
## random unit normal vectors
mesh    <- makeMesh(dataPentaPrism, triangulate=TRUE, normals=FALSE)
nVerts  <- nrow(mesh[["vertices"]])
nrmls0  <- matrix(runif(nVerts*3), ncol=3)
lens    <- sqrt(rowSums(nrmls0^2))
nrmls   <- diag(1/lens) %*% nrmls0

## set vertex normals
mesh_vn <- setVertexNormals(mesh, nrmls)
head(mesh_vn[["normals"]])
head(nrmls)

## -----------------------------------------------------------------------------
mesh <- makeMeshValid(dataTorus)
isValid(mesh)
hasGarbage(mesh)
isTriangle(mesh)
isQuad(mesh)
doesBoundVolume(mesh)
isClosed(mesh)
doesSelfIntersect(mesh)

## -----------------------------------------------------------------------------
mesh_rgl <- meshIsoCuboid(c(-1, -2, -3), c(1, 2, 3))
mesh     <- makeMeshValid(mesh_rgl)
mesh_rfo <- reverseFaceOrientations(mesh)
isOutwardOriented(mesh)
isOutwardOriented(mesh_rfo)

## -----------------------------------------------------------------------------
vertices <- rbind(
    c(0, 0, 0),
    c(2, 2, 0),
    c(2, 0, 2),
    c(0, 2, 2),
    c(3, 3, 3),
    c(5, 5, 3),
    c(5, 3, 5),
    c(3, 5, 5))

faces <- rbind(
    c(3, 2, 1),
    c(3, 4, 2),
    c(1, 2, 4),
    c(4, 3, 1),
    c(5, 6, 7),
    c(6, 8, 7),
    c(8, 6, 5),
    c(5, 7, 8))

mesh    <- makeMesh(vertices, faces=faces)
mesh_bv <- orientToBoundVolume(mesh)
doesBoundVolume(mesh)
doesBoundVolume(mesh_bv)

## -----------------------------------------------------------------------------
mesh <- makeMesh(dataPentaPrism, triangulate=TRUE)
getCentroid(mesh)

## -----------------------------------------------------------------------------
mesh <- makeMesh(dataTruncIcosahedron, triangulate=TRUE)
getArea(mesh)

## -----------------------------------------------------------------------------
mesh <- makeMesh(dataSeptuaginta, triangulate=TRUE)
getVolume(mesh)

## -----------------------------------------------------------------------------
mesh <- makeMesh(dataToroHelix, triangulate=TRUE)
getAverageSpacing(mesh[["vertices"]], nNeighbors=12L)

## -----------------------------------------------------------------------------
f_mesh <- system.file("extdata", "dataCornerHole.off", package="SurfaceMesh")
mesh   <- makeMesh(f_mesh, triangulate=TRUE, verbose=TRUE)
mesh_rgl  <- toRGL(mesh)
mesh_fill <- fillBoundaryHoles(mesh, verbose=TRUE)
mesh_fill_rgl <- toRGL(mesh_fill)

mfrow3d(1, 2)
view3d(70, 25, zoom=0.8)
shade3d(mesh_rgl, col="orangered")
next3d()
view3d(70, 25, zoom=0.8)
shade3d(mesh_fill_rgl, col="violetred")

## -----------------------------------------------------------------------------
mesh     <- makeMesh(dataPentaPrism, triangulate=TRUE)
mesh_nsi <- removeSelfIntersections(mesh)
getVolume(mesh_nsi)

## -----------------------------------------------------------------------------
mesh      <- makeMesh(dataPentaPrism, triangulate=TRUE)
ptsOnMesh <- samplePoints(mesh, ptsOnFaces=2L)
head(ptsOnMesh)

## -----------------------------------------------------------------------------
# mesh one: a cube
mesh1_rgl  <- cube3d()   # (from the rgl package)
mesh2_rgl  <- translate3d(cube3d(), 1, 1, 1)
mesh_u     <- boolUnion(list(mesh1_rgl, mesh2_rgl))
mesh_u_rgl <- toRGL(mesh_u)

shade3d(mesh_u_rgl, color="red")

## -----------------------------------------------------------------------------
mesh1_rgl  <- cube3d()   # (from the rgl package)
mesh2_rgl  <- translate3d(cube3d(), 1, 1, 0)
mesh_d     <- boolDifference(mesh1_rgl, mesh2_rgl)
mesh_d_rgl <- toRGL(mesh_d)

shade3d(mesh1_rgl,  color="yellow", alpha=0.2)
shade3d(mesh2_rgl,  color="cyan",   alpha=0.2)
shade3d(mesh_d_rgl, color="red")

## -----------------------------------------------------------------------------
mesh1      <- makeMesh(dataTruncIcosahedron, triangulate=TRUE)
mesh1_rgl  <- toRGL(mesh1)
mesh2_rgl  <- translate3d(cube3d(), 2, 0, 0)
mesh2      <- makeMesh(mesh2_rgl, triangulate=TRUE)
mesh_i     <- boolIntersection(list(mesh1, mesh2))
mesh_i_rgl <- toRGL(mesh_i)

shade3d(mesh1_rgl,  color="yellow", alpha=0.2)
shade3d(mesh2_rgl,  color="cyan",   alpha=0.2)
shade3d(mesh_i_rgl, color="red")

## -----------------------------------------------------------------------------
mesh       <- makeMeshValid(dataOloid)
mesh_rgl   <- toRGL(mesh)
mesh_d     <- remeshACVD(mesh, method="uniform_iso_qem", nVerts=100L)
mesh_d_rgl <- toRGL(mesh_d)

mfrow3d(1, 2)
view3d(0, 30, zoom=0.8)
wire3d(mesh_rgl)
next3d()
view3d(0, 30, zoom=0.8)
wire3d(mesh_d_rgl)

## -----------------------------------------------------------------------------
mesh     <- makeMesh(dataPentaPrism, triangulate=TRUE)
mesh_rgl <- toRGL(mesh)
mesh_d   <- remeshDelaunay(mesh,
                           edgeSize=0.2,
                           facetDist=0.2,
                           protectConstraints=TRUE)
mesh_d_rgl <- toRGL(mesh_d)

mfrow3d(1, 2)
view3d(0, 30, zoom=0.8)
wire3d(mesh_rgl)
next3d()
view3d(0, 30, zoom=0.8)
wire3d(mesh_d_rgl)

## -----------------------------------------------------------------------------
mesh       <- makeMesh(dataTruncIcosahedron, triangulate=TRUE)
mesh_rgl   <- toRGL(mesh)
mesh_i     <- remeshIsotropic(mesh, targetEdgeLen=0.7)
mesh_i_rgl <- toRGL(mesh_i)

mfrow3d(1, 2)
view3d(0, 0, zoom=0.7)
wire3d(mesh_rgl)
next3d()
view3d(0, 0, zoom=0.7)
wire3d(mesh_i_rgl)

## -----------------------------------------------------------------------------
mesh       <- makeMesh(dataHopfTorus, triangulate=TRUE)
mesh_rgl   <- toRGL(mesh)
mesh_s     <- remeshSimplify(mesh, method="LT-R", stopUeRatio=0.1)
mesh_s_rgl <- toRGL(mesh_s)

mfrow3d(1, 2)
view3d(0, 0, zoom=0.7)
wire3d(mesh_rgl)
next3d()
view3d(0, 0, zoom=0.7)
wire3d(mesh_s_rgl)

## -----------------------------------------------------------------------------
mesh       <- dataHeart1
mesh_rgl   <- toRGL(mesh)
mesh_s     <- remeshSmoothShape(mesh, nIter=5L, time=1)
mesh_s_rgl <- toRGL(mesh_s)

mfrow3d(1, 2)
view3d(0, -90, zoom=0.7)
shade3d(mesh_rgl, col="forestgreen")
next3d()
view3d(0, -90, zoom=0.7)
shade3d(mesh_s_rgl, col="darkolivegreen4")

## -----------------------------------------------------------------------------
mesh       <- makeMesh(dataSeptuaginta, triangulate=TRUE)
mesh_rgl   <- toRGL(mesh)
mesh_s     <- remeshSmoothAngle(mesh, nIter=5L)
mesh_s_rgl <- toRGL(mesh_s)

mfrow3d(1, 2)
view3d(45, -45, zoom=0.7)
shade3d(mesh_rgl, col="darkviolet")
next3d()
view3d(45, -45, zoom=0.7)
shade3d(mesh_s_rgl, col="gray")

## -----------------------------------------------------------------------------
mesh       <- makeMesh(dataSeptuaginta, triangulate=TRUE)
mesh_rgl   <- toRGL(mesh)
mesh_s     <- remeshSmoothTangentRelax(mesh, nIter=5L)
mesh_s_rgl <- toRGL(mesh_s)

mfrow3d(1, 2)
view3d(45, -45, zoom=0.7)
shade3d(mesh_rgl, col="gray")
next3d()
view3d(45, -45, zoom=0.7)
shade3d(mesh_s_rgl, col="royalblue3")

## -----------------------------------------------------------------------------
mesh        <- makeMesh(dataPentaPrism, triangulate=TRUE)
mesh_rgl    <- toRGL(mesh)
mesh_cc     <- subdivide(mesh, method="CC", nIter=2L)
mesh_cc_rgl <- toRGL(mesh_cc)

mfrow3d(1, 2)
view3d(0, 30, zoom=0.8)
wire3d(mesh_rgl)
next3d()
view3d(0, 30, zoom=0.8)
wire3d(mesh_cc_rgl)

## -----------------------------------------------------------------------------
mesh        <- makeMesh(dataSeptuaginta, triangulate=TRUE)
mesh_rgl    <- toRGL(mesh)
mesh_ds     <- subdivide(mesh, method="DS", nIter=1L)
mesh_ds_rgl <- toRGL(mesh_ds)

mfrow3d(1, 2)
view3d(0, 30, zoom=0.8)
wire3d(mesh_rgl)
next3d()
view3d(0, 30, zoom=0.8)
wire3d(mesh_ds_rgl)

## -----------------------------------------------------------------------------
mesh       <- makeMesh(dataSeptuaginta, triangulate=TRUE)
mesh_rgl   <- toRGL(mesh)
mesh_l     <- subdivide(mesh, method="Loop", nIter=1L)
mesh_l_rgl <- toRGL(mesh_l)

mfrow3d(1, 2)
view3d(0, 30, zoom=0.8)
wire3d(mesh_rgl)
next3d()
view3d(0, 30, zoom=0.8)
wire3d(mesh_l_rgl)

## -----------------------------------------------------------------------------
mesh        <- makeMesh(dataPentaPrism, triangulate=TRUE)
mesh_rgl    <- toRGL(mesh)
mesh_s3     <- subdivide(mesh, method="Sqrt3", nIter=2L)
mesh_s3_rgl <- toRGL(mesh_s3)

mfrow3d(1, 2)
view3d(0, 30, zoom=0.8)
wire3d(mesh_rgl)
next3d()
view3d(0, 30, zoom=0.8)
wire3d(mesh_s3_rgl)

## -----------------------------------------------------------------------------
ptsBefore <- matrix(rnorm(120L, mean=0, sd=1), ncol=3L)
getAverageSpacing(ptsBefore, nNeighbors=6L)

## contaminate
idx              <- sample(seq_len(nrow(ptsBefore)), 4L, replace=FALSE)
ptsBefore[idx, ] <- matrix(rnorm(12L, mean=10, sd=1), ncol=3L)
ptsAfter         <- removeOutliers(ptsBefore, nNeighbors=6L)
dim(ptsBefore)
dim(ptsAfter)

## -----------------------------------------------------------------------------
mesh         <- dataHeart1
mesh_rgl     <- toRGL(mesh)
mesh_afs     <- reconstructAFS(mesh[["vertices"]], nNeighbors=30)
mesh_afs_rgl <- toRGL(mesh_afs)

mfrow3d(1, 2)
view3d(0, -90, zoom=0.7)
shade3d(mesh_rgl, col="mediumorchid4")
next3d()
view3d(0, -90, zoom=0.7)
shade3d(mesh_afs_rgl, col="maroon2")

## -----------------------------------------------------------------------------
mesh     <- dataHeart1
mesh_rgl <- toRGL(mesh)
mesh_sss <- reconstructSSS(mesh[["vertices"]],
                           nScaleIter   =2L,
                           forceManifold=TRUE,
                           nNeighbors   =12L)
mesh_sss_rgl <- toRGL(mesh_sss)

mfrow3d(1, 2)
view3d(0, -90, zoom=0.7)
shade3d(mesh_rgl, col="yellowgreen")
next3d()
view3d(0, -90, zoom=0.7)
shade3d(mesh_sss_rgl, col="rosybrown4")

## -----------------------------------------------------------------------------
mesh     <- makeMesh(dataSeptuaginta)
mesh_rgl <- toRGL(mesh)
mesh_psr <- reconstructPoisson(mesh[["vertices"]],
                               normalsFun=getNormalsFun(6L),
                               smAngle=20,
                               smRadius=1,
                               smDistance=20)
mesh_psr_rgl <- toRGL(mesh_psr)

mfrow3d(1, 2)
shade3d(mesh_rgl, col="gray")
next3d()
shade3d(mesh_psr_rgl, col="gray")

## -----------------------------------------------------------------------------
mesh        <- dataHeart1
mesh_rgl    <- toRGL(mesh)
mesh_aw     <- alphaWrap(mesh,
                         alphaRel =10,
                         offsetRel=300)
mesh_aw_rgl <- toRGL(mesh_aw)

mfrow3d(1, 2)
view3d(0, -90, zoom=0.7)
shade3d(mesh_rgl, col="olivedrab3")
next3d()
view3d(0, -90, zoom=0.7)
shade3d(mesh_aw_rgl, col="mediumseagreen")

## -----------------------------------------------------------------------------
mesh1     <- makeMesh(dataTubularKnot)
mesh1_rgl <- toRGL(mesh1)
bb1       <- getBoundingBox(mesh1[["vertices"]])
bb1_rgl   <- toRGL(bb1)

view3d(10, 25, zoom=0.9)
shade3d(mesh1_rgl, color="mediumaquamarine")
wire3d(bb1_rgl)

## -----------------------------------------------------------------------------
mesh2     <- dataHeart1
mesh2_rgl <- toRGL(mesh2)
bb2       <- getBoundingBox(mesh2[["vertices"]], oriented=TRUE)
bb2_rgl   <- toRGL(bb2)
shade3d(mesh2_rgl, color="peachpuff")
wire3d(bb2_rgl)

## -----------------------------------------------------------------------------
bs_rgl <- getBoundingSphere(dataToroHelix, out="rgl")
shade3d(dataToroHelix, color="plum2")
wire3d(bs_rgl)

## -----------------------------------------------------------------------------
mesh     <- dataHeart1
mesh_rgl <- toRGL(mesh)
bell_rgl <- getBoundingEll(mesh, out="rgl", eps=0.01)
shade3d(mesh_rgl, color="lightgreen")
wire3d(bell_rgl)

## -----------------------------------------------------------------------------
mesh     <- makeMesh(dataToroHelix)
mesh_rgl <- toRGL(mesh)
hull     <- getConvexHull(mesh[["vertices"]])
hull_rgl <- toRGL(hull)

mfrow3d(1, 2)
view3d(15, 45, zoom=0.8)
wire3d(mesh_rgl)
next3d()
view3d(15, 45, zoom=0.8)
wire3d(hull_rgl)

## -----------------------------------------------------------------------------
mesh   <- makeMesh(dataPentaPrism, triangulate=TRUE)
points <- matrix(2*runif(3*4), ncol=3)
getDistance(mesh, points)

## -----------------------------------------------------------------------------
getDCOM(dataHeart1, dataHeart2)

## -----------------------------------------------------------------------------
getHausdorff(dataHeart1, dataHeart2, symmetric=TRUE)

## -----------------------------------------------------------------------------
getHausdorff(dataHeart1, dataHeart2, symmetric=TRUE, errBound=0.01)

## -----------------------------------------------------------------------------
getHausdorff(dataHeart1, dataHeart2, symmetric=TRUE, p=0.95)

## -----------------------------------------------------------------------------
sd_heart <- getSurfaceDist(dataHeart1, dataHeart2, p=0.95, ptsOnFaces=100L)
sd_heart[["ASSD"]]
sd_heart[["RMSE"]]

## -----------------------------------------------------------------------------
mesh1_rgl <- cube3d()      # (from the rgl package)
mesh2_rgl <- translate3d(cube3d(), 1, 1, 1)
jsc_dsc   <- getJSCDSC(mesh1_rgl, mesh2_rgl)
jsc_dsc[["JSC"]]
jsc_dsc[["DSC"]]

## ----echo=FALSE, results="asis"-----------------------------------------------
Sys.setenv("RGL_USE_WEBSHOT"=rgl_webshot_org)


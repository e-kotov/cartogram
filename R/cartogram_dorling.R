#' @title Calculate Non-Overlapping Circles Cartogram
#' @description Construct a cartogram which represents each geographic region
#' as non-overlapping circles (Dorling 1996).
#' @name cartogram_dorling
#' @param x a polygon or multiplogyon sf object
#' @param weight Name of the weighting variable in x
#' @param k Share of the bounding box of x filled by the larger circle
#' @param m_weight Circles' movements weights. An optional vector of numeric weights
#' (0 to 1 inclusive) to
#' apply to the distance each circle moves during pair-repulsion. A weight of 0
#' prevents any movement. A weight of 1 gives the default movement distance. A
#' single value can be supplied for uniform weights. A vector with length less
#' than the number of circles will be silently extended by repeating the final
#' value. Any values outside the range \[0, 1\] will be clamped to 0 or 1.
#' @param itermax Maximum iterations for the cartogram transformation.
#' @return Non overlaping proportional circles of the same class as x.
#' @export
#' @references Dorling, D. (1996). Area Cartograms: Their Use and Creation. In Concepts and Techniques in Modern Geography (CATMOG), 59.
#' @examples
#'library(sf)
#'library(cartogram)
#'
# Load North Carolina SIDS data
#'nc = st_read(system.file("shape/nc.shp", package="sf"), quiet = TRUE)
#'
#'# transform to NAD83 / UTM zone 16N
#'nc_utm <- st_transform(nc, 26916)
#'
#'# Create cartogram
#'nc_utm_carto <- cartogram_dorling(nc_utm, weight = "BIR74")
#'
#'# Plot
#'par(mfrow = c(2,1))
#'plot(nc[,"BIR74"], main="original", key.pos = NULL, reset = FALSE)
#'plot(nc_utm_carto[, "BIR74"], main="distorted", key.pos = NULL, reset = FALSE)
#'
cartogram_dorling <- function(x, weight, k = 5, m_weight = 1, itermax = 1000) {
  UseMethod("cartogram_dorling")
}

#' @rdname cartogram_dorling
#' @importFrom sf st_is_longlat st_as_sf st_geometry st_coordinates st_geometry st_centroid st_crs
#' @importFrom packcircles circleRepelLayout
#' @export
cartogram_dorling.sf <- function(x, weight, k = 5, m_weight = 1, itermax = 1000) {
  # proj or unproj
  if (sf::st_is_longlat(x)) {
    stop('Using an unprojected map. This function does not give correct centroids and distances for longitude/latitude data:\nUse "st_transform()" to transform coordinates to another projection.', call. = FALSE)
  }
  # no 0 values
  x <- x[x[[weight]] > 0, ]
  # data prep
  dat.init <- data.frame(sf::st_coordinates(sf::st_centroid(sf::st_geometry(x))),
                         v = x[[weight]])
  surf <- (max(dat.init[, 1]) - min(dat.init[, 1])) *  (max(dat.init[, 2]) - min(dat.init[, 2]))
  dat.init$v <- dat.init$v * (surf * k / 100) / max(dat.init$v)
  # circles layout and radiuses
  res <- packcircles::circleRepelLayout(x = dat.init, xysizecols = 1:3,
                                        wrap = FALSE, sizetype = "area",
                                        maxiter = itermax, weights = m_weight)
  # sf object creation
  . <- sf::st_buffer(sf::st_as_sf(res$layout,
                                  coords = c('x', 'y'),
                                  crs = sf::st_crs(x)),
                     dist = res$layout$radius)
  sf::st_geometry(x) <- sf::st_geometry(.)
  return(x)
}

#' @rdname cartogram_dorling
#' @export
cartogram_dorling.SpatialPolygonsDataFrame <- function(x, weight, k = 5, m_weight = 1, itermax = 1000) {
  as(cartogram_dorling.sf(sf::st_as_sf(x), weight = weight, k = k, m_weight = m_weight, itermax = itermax), "Spatial")
}

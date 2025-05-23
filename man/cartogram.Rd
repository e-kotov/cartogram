% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cartogram_cont.R
\name{cartogram}
\alias{cartogram}
\title{Calculate Contiguous Cartogram Boundaries}
\usage{
cartogram(shp, ...)
}
\arguments{
\item{shp}{SpatialPolygonDataFrame or an sf object}

\item{...}{
  Arguments passed on to \code{\link[=cartogram_cont]{cartogram_cont}}
  \describe{
    \item{\code{weight}}{Name of the weighting variable in x}
    \item{\code{itermax}}{Maximum iterations for the cartogram transformation, if maxSizeError ist not reached}
    \item{\code{maxSizeError}}{Stop if meanSizeError is smaller than maxSizeError}
    \item{\code{prepare}}{Weighting values are adjusted to reach convergence much earlier. Possible methods are:
\itemize{
\item "adjust", adjust values to restrict the mass vector to the quantiles defined by threshold and 1-threshold (default),
\item "remove", remove features with values lower than quantile at threshold,
\item "none", don't adjust weighting values
}}
    \item{\code{threshold}}{"auto" or a threshold value between 0 and 1. With “auto”, the value is 0.05 or, if the proportion of zeros in the weight is greater than 0.05, the value is adjusted accordingly.}
    \item{\code{verbose}}{print meanSizeError on each iteration}
    \item{\code{n_cpu}}{Number of cores to use. Defaults to "respect_future_plan". Available options are:
\itemize{
\item "respect_future_plan" - By default, the function will run on a single core, unless the user specifies the number of cores using \code{\link[future]{plan}} (e.g. \code{future::plan(future::multisession, workers = 4)}) before running the \code{cartogram_cont} function.
\item "auto" - Use all except available cores (identified with \code{\link[parallelly]{availableCores}}) except 1, to keep the system responsive.
\item a \code{numeric} value - Use the specified number of cores. In this case \code{cartogram_cont} will use set the specified number of cores internally with \code{future::plan(future::multisession, workers = n_cpu)} and revert that back by switching the plan back to whichever plan might have been set before by the user. If only 1 core is set, the function will not require \code{future} and \code{future.apply} and will run on a single core.
}}
    \item{\code{show_progress}}{A \code{logical} value. If TRUE, show progress bar. Defaults to TRUE.}
  }}
}
\description{
This function has been renamed: Please use cartogram_cont() instead of cartogram().
}
\keyword{internal}

\name{overplot}
\alias{overplot}
\alias{panel.overplot}
\title{Plot Variables on Same X Region}
\description{
  \code{overplot} graphs a set of variables defined on the same x-range
  but which have varying y-ranges on the same plotting area. For each
  set of y-values it uses a different color and line-type and and draws
  a correspondingly colored and line-typed axis. \code{panel.overplot}
  is used by \code{overplot} to draw the individual graphs.
}
\usage{
overplot(formula, data=parent.frame(), same.scale=FALSE, xlab, ylab,
         xlim, ylim, min.y, max.y, log="", panel="panel.overplot",
         subset, plot=TRUE, groups, main, f=2/3, \dots)
}
\arguments{
  \item{formula}{formula describing the x and y variables. It should be
    of the form \code{x ~ y | z}. The conditioning variable (\code{z})
    should be a factor.}
  \item{same.scale}{logical value indicating whether the plot region
    should have the same range for all plots. Defaults to \code{FALSE}.}
  \item{xlab, ylab, xlim, ylim, main}{standard plotting parameters. See
    \code{\link{plot}} for details.}
  \item{min.y, max.y}{scalar or vector values used to specify the y
    plotting limits for individual plots. If a single scalar value is
    provided, it will be used for all plots. These parameters can be
    used specify one end of the individual plot ranges, while allowing
    the other end to vary with the data. E.g. to force 0 to always be
    within the plot region.}
  \item{log}{character string \code{""}, \code{"x"}, \code{"y"}, or
    \code{"xy"}, indicating which axes should be plotted on a log scale.
    Defaults to \code{""} (neither).}
  \item{panel}{a plotting function to be called to draw the individual
    plots. Defaults to \code{overplot.panel}, which plots the points and
    a \code{lowess} smooth.}
  \item{plot}{logical value indicating whether to draw the plot.}
  \item{groups}{(optional) character vector giving the names of levels
    of the conditioning variable to plot. Defaults to all levels of the
    conditioning variable.}
  \item{f}{smoothing parameter for \code{lowess}.}
  \item{data, subset, \dots}{parameters passed to \code{model.frame} to
    obtain the data to be plotted from the formula.}
}
\details{
  This function essentially performs

  \verb{  tmp <- split(data, z)
  for(i in levels(z))
    plot(x ~ y, data=tmp[[z]])}

  except that all of the plots are shown on the same plotting region and
  varying scales for each value of \code{z} are handled nicely.
}
\value{A copy of the data split by the conditioning variable.}
\author{Gregory R. Warnes \email{greg@warnes.net}.}
\seealso{
  \code{\link{interaction.plot}},
  \code{\link{coplot}} for alternative visualizations of 3-way data.

  \code{\link{gplots-package}} gives an overview of the package.
}
\examples{
# Same scale
overplot(RQ ~ Conc..ug.ml. | Test.Substance,
         data=rtPCR,
         subset=Detector=="ProbeType 1" & Conc..ug.ml. > 0,
         same.scale=TRUE,
         log="xy",
         f=3/4,
         main="Detector=ProbeType 1",
         xlab="Concentration (ug/ml)",
         ylab="Relative Gene Quantification")

# Different scales, but force lower limit to 0.01
overplot(RQ ~ Conc..ug.ml. | Test.Substance,
         data=rtPCR,
         subset=Detector=="ProbeType 8" & Conc..ug.ml. > 0,
         log="xy",
         f=3/4,
         main="Detector=ProbeType 8",
         xlab="Concentration (ug/ml)",
         ylab="Relative Gene Quantification",
         min.y=0.01)
}
\keyword{hplot}

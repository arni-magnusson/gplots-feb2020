\name{ci2d}
\alias{ci2d}
\alias{print.ci2d}
\title{Two-Dimensional Confidence Regions}
\description{
  Create 2-dimensional empirical confidence regions from provided data.
}
\usage{
ci2d(x, y=NULL, nbins=51, method=c("bkde2D","hist2d"), bandwidth,
     factor=1.0, ci.levels=c(0.50,0.75,0.90,0.95,0.975),
     show=c("filled.contour","contour","image","none"),
     col=topo.colors(length(breaks)-1), show.points=FALSE,
     pch=par("pch"), points.col="red", xlab, ylab, \dots)
\method{print}{ci2d}(x, \dots)
}
\arguments{
  \item{x}{either a vector containing the x coordinates or a matrix with
    2 columns.}
  \item{y}{a vector containing the y coordinates, not required if
    \code{x} is a matrix.}
  \item{nbins}{number of bins in each dimension. May be a scalar or a
    2-element vector. Defaults to \code{51}.}
  \item{method}{one of \code{"bkde2D"} (for \code{KernSmooth::bdke2d})
    or \code{"hist2d"} (for \code{gplots::hist2d}) specifyting the name
    of the method to create the 2-d density summarizing the data.
    Defaults to \code{"bkde2D"}.}
  \item{bandwidth}{bandwidth to use for \code{KernSmooth::bkde2D}. See
    below for default value.}
  \item{factor}{numeric scaling factor for bandwidth. Useful for
    exploring effect of changing the bandwidth. Defaults to \code{1.0}.}
  \item{ci.levels}{Confidence level(s) to use for plotting data.
    Defaults to \code{c(0.5, 0.75, 0.9, 0.95, 0.975)}.}
  \item{show}{plot type to be displayed. One of \code{"filled.contour"},
    \code{"contour"}, \code{"image"}, or \code{"none"}. Defaults to
    \code{"filled.contour"}.}
  \item{show.points}{boolean indicating whether original data values
    should be plotted. Defaults to \code{TRUE}.}
  \item{pch}{point symbol for plots. See \code{points} for details.}
  \item{points.col}{point color for plotting original data. Defaults to
    \code{"red"}.}
  \item{col}{colors to use for plots.}
  \item{xlab, ylab}{axis labels}
  \item{\dots}{additional arguments passed to \code{KernSmooth::bkde2D}
    or \code{gplots::hist2d}.}
}
\details{
  This function utilizes either \code{KernSmooth::bkde2D} or
  \code{gplots::hist2d} to estmate a 2-dimensional density of the data
  passed as an argument. This density is then used to create and
  (optionally) display confidence regions.

  When \code{bandwidth} is omitted and \code{method="bkde2d"},
  \code{KernSmooth::dpik} is applied in x and y dimensions to select the
  bandwidth.
}
\note{
  Confidence intervals generated by \code{ci2d} are \emph{approximate},
  and are subject to biases and/or artifacts induced by the binning or
  kernel smoothing method, bin locations, bin sizes, and kernel
  bandwidth.

  The \code{\link[r2d2]{conf2d}} function in the \pkg{r2d2} package may
  create a more accurate confidence region, and reports the actual
  proportion of points inside the region.
}
\value{
  A \code{ci2d} object consisting of a list containing (at least) the
  following elements:
  \item{nobs}{Number of original data points}
  \item{x}{x position of each density estimate bin}
  \item{y}{y position of each density estimate bin}
  \item{density}{Matrix containing the probability density of each bin
    (count in bin/total count)}
  \item{cumDensity}{Matrix where each element contains the cumulative
    probability density of all elements with the same density (used to
    create the confidence region plots)}
  \item{contours}{List of contours of each confidence region.}
  \item{call}{Call used to create this object}
}
\author{Gregory R. Warnes \email{greg@warnes.net}.}
\seealso{
  \code{\link[KernSmooth]{bkde2D}}, \code{\link[r2d2]{conf2d}},
  \code{\link[KernSmooth]{dpik}}, \code{\link{hist2d}}.

  \code{\link{gplots-package}} gives an overview of the package.
}
\examples{
# 1  Basic usage
data(geyser, package="MASS")

x <- geyser$duration
y <- geyser$waiting

# 2-d confidence intervals based on binned kernel density estimate
ci2d(x, y)                    # filled contour plot
ci2d(x, y, show.points=TRUE)  # show original data

# Image plot
ci2d(x, y, show="image")
ci2d(x, y, show="image", show.points=TRUE)

# Contour plot
ci2d(x, y, show="contour", col="black")
ci2d(x, y, show="contour", col="black", show.points=TRUE)


# 2  Control axis scales
x <- rnorm(2000, sd=4)
y <- rnorm(2000, sd=1)

# 2-d confidence intervals based on binned kernel density estimate
ci2d(x, y)

# 2-d confidence intervals based on 2d histogram
ci2d(x, y, method="hist2d", nbins=25)

# Require same scale for each axis, this looks oval
ci2d(x, y, range.x=list(c(-20,20), c(-20,20)))
ci2d(x, y, method="hist2d", same.scale=TRUE, nbins=25)  # hist2d


# 3  Control smoothing and binning
x <- rnorm(2000, sd=4)
y <- rnorm(2000, mean=x, sd=2)

# Default 2-d confidence intervals
# based on binned kernel density estimate
ci2d(x, y)

# Change the smoother bandwidth
ci2d(x, y, bandwidth=c(sd(x)/8, sd(y)/8))

# Change the smoother number of bins
ci2d(x, y, nbins=10)
ci2d(x, y)
ci2d(x, y, nbins=100)

# Default 2-d confidence intervals based on 2d histogram
ci2d(x, y, method="hist2d", show.points=TRUE)

# Change the number of histogram bins
ci2d(x, y, nbin=10, method="hist2d", show.points=TRUE)
ci2d(x, y, nbin=25, method="hist2d", show.points=TRUE)


# 4  Perform plotting manually
data(geyser, package="MASS")

# Let ci2d handle plotting contours...
ci2d(geyser$duration, geyser$waiting, show="contour", col="black")

# Call contour() directly, show the 90 percent CI, and the mean point
est <- ci2d(geyser$duration, geyser$waiting, show="none")
contour(est$x, est$y, est$cumDensity, xlab="duration", ylab="waiting",
        levels=0.90, lwd=4, lty=2)
points(mean(geyser$duration), mean(geyser$waiting), col="red", pch="X")


# 5  Extract confidence region values
data(geyser, package="MASS")

# Empirical 90 percent confidence limits
quantile(geyser$duration, c(0.05, 0.95))
quantile(geyser$waiting, c(0.05, 0.95))

# Bivariate 90 percent confidence region
est <- ci2d(geyser$duration, geyser$waiting, show="none")
names(est$contours)  # show available contours

ci.90 <- est$contours[names(est$contours)=="0.9"]        # get region(s)
ci.90 <- rbind(ci.90[[1]], NA, ci.90[[2]], NA, ci.90[[3]])  # join them

print(ci.90)                # show full contour
range(ci.90$x, na.rm=TRUE)  # range for duration
range(ci.90$y, na.rm=TRUE)  # range for waiting


# 6  Visually compare confidence regions
data(geyser, package="MASS")

# Bivariate smoothed 90 percent confidence region
est <- ci2d(geyser$duration, geyser$waiting, show="none")
names(est$contours)  # show available contours

ci.90 <- est$contours[names(est$contours)=="0.9"]        # get region(s)
ci.90 <- rbind(ci.90[[1]],NA, ci.90[[2]], NA, ci.90[[3]])  # join them

plot(waiting ~ duration, data=geyser,
     main="Comparison of 90 percent confidence regions")
polygon(ci.90, col="green", border="green", density=10)

# Univariate Normal-Theory 90 percent confidence region
mean.x <- mean(geyser$duration)
mean.y <- mean(geyser$waiting)
sd.x <- sd(geyser$duration)
sd.y <- sd(geyser$waiting)

t.value <- qt(c(0.05,0.95), df=length(geyser$duration), lower=TRUE)
ci.x <- mean.x + t.value * sd.x
ci.y <- mean.y + t.value * sd.y

plotCI(mean.x, mean.y, li=ci.x[1], ui=ci.x[2], barcol="blue",
       col="blue", err="x", pch="X", add=TRUE)

plotCI(mean.x, mean.y, li=ci.y[1], ui=ci.y[2], barcol="blue",
       col="blue", err="y", pch=NA, add=TRUE)

# rect(ci.x[1], ci.y[1], ci.x[2], ci.y[2], border="blue",
#      density=5,
#      angle=45,
#      col="blue")


# Empirical univariate 90 percent confidence region
box <- cbind(x=quantile(geyser$duration, c(0.05, 0.95)),
             y=quantile(geyser$waiting, c(0.05, 0.95)))

rect(box[1,1], box[1,2], box[2,1], box[2,2], border="red", density=5,
     angle=-45, col="red")

# Now a nice legend
legend("topright", legend=c("       Region type",
       "Univariate Normal Theory", "Univarite Empirical",
       "Smoothed Bivariate"), lwd=c(NA,1,1,1),
       col=c("black","blue","red","green"), lty=c(NA,1,1,1))


# 7  Test with a large number of points
\dontrun{
x <- rnorm(60000, sd=1)
y <- c(rnorm(40000, mean=x, sd=1),
       rnorm(20000, mean=x+4, sd=1))

hist2d(x, y)
ci <- ci2d(x, y)
ci
}
}
\keyword{dplot}
\keyword{hplot}
\keyword{nonparametric}

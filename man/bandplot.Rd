\name{bandplot}
\alias{bandplot}
\alias{bandplot.formula}
\alias{bandplot.default}
\title{Smoothed Mean and Standard Deviation}
\description{
  Plot x-y points with curves for locally smoothed mean and standard
  deviation.
}
\usage{
bandplot(x,\dots)
\method{bandplot}{formula}(x, data, subset, na.action, \dots,
         xlab=NULL, ylab=NULL, add=FALSE, sd=c(-2:2),
         sd.col=c("magenta", "blue", "red", "blue", "magenta"),
         sd.lwd=c(2, 2, 3, 2, 2), sd.lty=c(2, 1, 1, 1, 2),
         method="frac", width=1/5, n=50)
\method{bandplot}{default}(x, y, \dots, add=FALSE, sd=c(-2:2),
         sd.col=c("magenta", "blue", "red", "blue", "magenta"),
         sd.lwd=c(2, 2, 3, 2, 2), sd.lty=c(2, 1, 1, 1, 2),
         method="frac", width=1/5, n=50)
}
\arguments{
  \item{x}{either a formula providing a single dependent variable (y)
    and an single independent variable (x) to use as coordinates in the
    scatterplot or a numeric vector of x locations.}
  \item{y}{numeric vector of y locations.}
  \item{data}{an optional \code{data.frame}, list, or environment
    containing the variables used in the model (and in \code{subset}).}
  \item{subset}{an optional vector specifying a subset of observations
    to be used in the fitting process.}
  \item{na.action}{a function which indicates what should happen when
    the data contain \code{NA} values. The default is set by the
    \code{na.action} setting of \code{options}, and is \code{na.fail} if
    that is unset. The factory-fresh default is \code{na.omit}. Another
    possible value is \code{NULL}, no action. Value \code{na.exclude}
    can be useful.}
  \item{\dots}{additional plotting parameters.}
  \item{xlab, ylab}{x and y axis labels.}
  \item{add}{boolean indicating whether the local mean and standard
    deviation lines should be added to an existing plot. Defaults to
    \code{FALSE}.}
  \item{sd}{vector of multiples of the standard devation that should be
    plotted. \code{0} gives the mean, \code{-1} gives the mean minus
    one standard deviation, etc. Defaults to \code{-2:2}.}
  \item{sd.col, sd.lwd, sd.lty}{color, line width, and line type of each
    plotted line.}
  \item{method, width, n}{parameters controlling the smoothing. See the
    help page for \code{\link{wapply}} for details.}
}
\details{
  \code{bandplot} was created to look for changes in the mean or
  variance of scatterplots, particularly plots of regression residuals.

  The local mean and standard deviation are calculated by calling
  \code{wapply}. By default, \code{bandplot} calls \code{wapply} to
  smooth using intervals that include the nearest 1/5 of the data. See
  the documentation of that function for details on the algorithm.
}
\value{
  Invisibly returns a list containing the x,y points plotted for each
  line.
}
\author{Gregory R. Warnes \email{greg@warnes.net}.}
\seealso{
  \code{\link{wapply}}, \code{\link{lowess}}.

  \code{\link{gplots-package}} gives an overview of the package.
}
\examples{
# Fixed mean, changing variance
x <- 1:1000
y <- rnorm(1000, mean=1, sd=1 + x/1000)
bandplot(x,y)
bandplot(y~x)

# Fixed varance, changing mean
x <- 1:1000
y <- rnorm(1000, mean=x/1000, sd=1)
bandplot(x,y)

# Changing mean and variance
x <- abs(rnorm(500))
y <- rnorm(500, mean=2*x, sd=2+2*x)

# The changing mean and dispersion
# are hard to see whith the points alone
plot(x,y)

# Regression picks up the mean trend, but not the change in variance
reg <- lm(y~x)
summary(reg)
abline(reg=reg, col="blue", lwd=2)

# Using bandplot on the original data helps to show the mean and
# variance trend
bandplot(y~x)

# Using bandplot on the residuals helps to see that regression removes
# the mean trend but leaves the trend in variability
bandplot(predict(reg), resid(reg))
}
\keyword{dplot}

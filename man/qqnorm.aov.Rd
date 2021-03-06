\name{qqnorm.aov}
\alias{qqnorm.aov}
\title{Normal QQ Plot for Analysis of Variance}
\description{
  Makes a half or full normal plot for the effects from a model
  inheriting from class \code{aov}. One can interactively label the
  points in the plot.
}
\usage{
\method{qqnorm}{aov}(y, full=FALSE, label=FALSE, omit=NULL,
       xlab=paste(if(full) "" else "Half ", "Normal plot"),
       ylab="Effects", \dots)
}
\arguments{
  \item{y}{a model object inheriting from \code{aov}.}
   \item{full}{full or half normal plot (half is default).}
   \item{label}{if \code{TRUE}, function allows interactive labelling of
     points in plot, using the mouse.}
   \item{omit}{numeric or character vector of effects to omit, the
     intercept is always omitted.}
   \item{xlab}{horizontal axix label.}
   \item{ylab}{vertical axis label.}
   \item{\dots}{further arguments to be given to the plot function.}
}
\details{
   Produces a (half) normal plot of the effects from an AOV model. The
   idea behind the plot is that most effects will be small or null, and
   this effects can be used as a basis for estimation of the
   experimental variance. This small effects will show up in the plot as
   a straight line, other effects can be judged against this as a
   background. Heavily used by Box, Hunter & Hunter, who attribute the
   idea to Daniel.
}
\value{
  If \code{label=TRUE}, the vector of points identified, else nothing of
  interest.
}
\references{
   Box, Hunter and Hunter: Statistics for Experimenters. An Introduction
   to Design, Data Analysis and Model Building. Wiley.\cr
   Daniel, C (1976): Applications of Statistics to Industrial
   Experimentation. Wiley.\cr
   Daniel, C (1959): Use of half-normal plot in interpreting factorial
   two-level experiments. \emph{Technometrics} \bold{1}, 149.
}
\author{Kjetil Halvorsen \email{kjetil@entelnet.bo}.}
\seealso{
  \code{\link{qqnorm}}.

  \code{\link{gplots-package}} gives an overview of the package.
}
\examples{
npk.aov <- aov(yield ~ block + N*P*K, npk)
qqnorm(npk.aov)

# Interactive labeling of points. Click mouse on points to show label
if(dev.interactive()) qqnorm(npk.aov, omit=2:6, label=TRUE)
}
\keyword{hplot}
\keyword{design}

\name{colorpanel}
\alias{colorpanel}
\alias{redgreen}
\alias{greenred}
\alias{bluered}
\alias{redblue}
\title{Smoothly Varying Colors}
\description{
  The \code{colorpanel} function generates a set of colors that varies
  smoothly, while \code{redgreen}, \code{greenred}, \code{bluered}, and
  \code{redblue} generate red-black-green, green-black-red,
  red-white-blue, and blue-white-red color ranges, respectively.
}
\usage{
colorpanel(n, low, mid, high)
redgreen(n)
greenred(n)
bluered(n)
redblue(n)
}
\arguments{
  \item{n}{desired number of color elements in the panel.}
  \item{low, mid, high}{colors to use for the lowest, middle, and
    highest values (\code{mid} may be omitted).}
}
\details{
  The values for \code{low, mid, high} can be given as color names
  (\code{"red"}), index (2=red), or RGB values (\code{"\#FF0000"}=red).

  If \code{mid} is supplied, then the returned color panel will consist
  of \code{n - floor(n/2)} RGB elements which vary smoothly between
  \code{low} and \code{mid}, then between \code{mid} and \code{high}.
  Note that if \code{n} is even, the color \code{mid} will occur twice
  at the center of the sequence.

  If \code{mid} is omitted, the color panel will vary smoothly beween
  \code{low} and \code{high}.
}
\value{Vector of RGB colors.}
\author{Gregory R. Warnes \email{greg@warnes.net}.}
\seealso{
  \code{\link{colors}}.

  \code{\link{gplots-package}} gives an overview of the package.
}
\examples{
showpanel <- function(col)
{
  image(z=matrix(1:100, ncol=1), col=col, xaxt="n", yaxt="n")
}

par(mfrow=c(3,3))

# Two colors
showpanel(colorpanel(8, low="red", high="green"))

# Three colors
showpanel(colorpanel(8, "red", "black", "green"))

# Note the duplicatation of black at the center,
# using an odd number of elements resolves this
showpanel(colorpanel(9, "red", "black", "green"))

showpanel(greenred(64))
showpanel(redgreen(64))
showpanel(bluered(64))
showpanel(redblue(64))
}
\keyword{color}

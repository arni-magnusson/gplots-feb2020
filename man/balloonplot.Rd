\name{balloonplot}
\alias{balloonplot}
\alias{balloonplot.default}
\alias{balloonplot.table}
\title{Balloon Plot}
\description{
  Plot a graphical matrix where each cell contains a dot whose size
  reflects the relative magnitude of the corresponding component.
}
\usage{
balloonplot(x, \dots)
\method{balloonplot}{table}(x, xlab, ylab, zlab, show.zeros=FALSE,
            show.margins=TRUE, \dots)
\method{balloonplot}{default}(x, y, z,
            xlab,
            ylab,
            zlab=deparse(substitute(z)),
            dotsize=2/max(strwidth(19),strheight(19)),
            dotchar=19,
            dotcolor="skyblue",
            text.size=1,
            text.color=par("fg"),
            main,
            label=TRUE,
            label.digits=2,
            label.size=1,
            label.color=par("fg"),
            scale.method=c("volume","diameter"),
            scale.range=c("absolute","relative"),
            colsrt=par("srt"),
            rowsrt=par("srt"),
            colmar=1,
            rowmar=2,
            show.zeros=FALSE,
            show.margins=TRUE,
            cum.margins=TRUE,
            sorted=TRUE,
            label.lines=TRUE,
            fun=function(x)sum(x,na.rm=TRUE),
            hide.duplicates=TRUE,
            \dots)
}
\arguments{
  \item{x}{a \code{table} object, or either a vector or a list of
    several categorical vectors containing grouping variables for the
    first (x) margin of the plotted matrix.}
  \item{y}{vector or list of vectors for grouping variables for the
    second (y) dimension of the plotted matrix.}
  \item{z}{vector of values for the size of the dots in the plotted
    matrix.}
  \item{xlab}{text label for the x dimension. This will be displayed on
    the x axis and in the plot title.}
  \item{ylab}{text label for the y dimension. This will be displayed on
    the y axis and in the plot title.}
  \item{zlab}{text label for the dot size. This will be included in the
    plot title.}
  \item{dotsize}{maximum dot size. You may need to adjust this value for
    different plot devices and layouts.}
  \item{dotchar}{plotting symbol or character used for dots. See the
    help page for the \code{points} function for symbol codes.}
  \item{dotcolor}{scalar or vector specifying the color(s) of the dots
    in the plot.}
  \item{text.size, text.color}{character size and color for row and
    column headers.}
  \item{main}{plot title text.}
  \item{label}{boolean flag indicating whether the actual value of the
    elements should be shown on the plot.}
  \item{label.digits}{number of digits used in formatting value labels.}
  \item{label.size, label.color}{character size and color for value
    labels.}
  \item{scale.method}{method of scaling the sizes of the dot, either
    \code{"volume"} or \code{"diameter"}. See below.}
  \item{scale.range}{method for scaling original data to compute circle
    diameter. \code{scale.range="absolute"} scales the data
    relative to 0 (i.e, maps [0,max(z)] --> [0,1]), while
    \code{scale.range="relative"} scales the data relative to min(z)
    (i.e. maps [min(z), max(z)] --> [0,1]).}
  \item{rowsrt, colsrt}{angle of rotation for row and column labels.}
  \item{rowmar, colmar}{space allocated for row and column labels. Each
    unit is the width/height of one cell in the table.}
  \item{show.zeros}{boolean. If \code{FALSE}, entries containing zero
    will be left blank in the plotted matrix. If \code{TRUE}, zeros will
    be displayed.}
  \item{show.margins}{boolean. If \code{TRUE}, row and column sums are
    printed in the bottom and right margins, respectively.}
  \item{cum.margins}{boolean. If \code{TRUE}, marginal fractions are
    graphically presented in grey behind the row/column label area.}
  \item{sorted}{boolean. If \code{TRUE}, the rows will be arranged in
    sorted order by using the levels of the first y factor, then the
    second y factor, etc. The same process is used for the columns,
    based on the x factors.}
  \item{label.lines}{boolean. If \code{TRUE}, borders will be drawn for
    row and column level headers.}
  \item{hide.duplicates}{boolean. If \code{TRUE}, column and row headers
    will omit duplicates within row/column to reduce clutter. Defaults
    to \code{TRUE}.}
  \item{fun}{function to be used to combine data elements with the same
    levels of the grouping variables \code{x} and \code{y}. Defaults to
    \code{sum}.}
  \item{\dots}{additional arguments passed to \code{balloonplot.default}
    or \code{plot}, as appropriate.}
}
\details{
  This function plots a visual matrix. In each \code{x},\code{y} cell a
  dot is plotted which reflects the relative size of the corresponding
  value of \code{z}. When \code{scale.method="volume"} the volume of the
  dot is proportional to the relative size of \code{z}. When
  \code{scale.method="diameter"}, the diameter of the dot is
  proportional to the the relative size of \code{z}. The \code{"volume"}
  method is default because the \code{"diameter"} method visually
  exaggerates differences.
}
\note{
  \code{z} is expected to be non-negative. The function will still
  operate correctly if there are negative values of \code{z}, but the
  corresponding dots will have 0 size and a warning will be generated.
}
\references{
  Jain, N. and Warnes, G. R. (2006) Balloon Plot: Graphical tool for
  displaying tabular data.
  \href{https://cran.r-project.org/doc/Rnews/Rnews_2006-2.pdf#page=35}{
    \emph{R News}, \bold{6}(2), 35--38}.

  Function inspired by question posed on R-help by Ramon Alonso-Allende
  \email{allende@cnb.uam.es}.}
\author{Gregory R. Warnes \email{greg@warnes.net}.}
\seealso{
  \code{\link{plot.table}}.

  \code{\link{bubbleplot}} provides an alternative interface and style
  of plot.

  \code{\link{gplots-package}} gives an overview of the package.
}
\examples{
\testonly{
set.seed(12425421)
}
# Create an example data frame containing Car x Color data
carnames <- c("bmw","renault","mercedes","seat")
carcolors <- c("red","white","silver","green")
datavals <- round(rnorm(16, mean=100, sd=60), 1)
data <- data.frame(Car=rep(carnames,4),
                   Color=rep(carcolors, c(4,4,4,4)),
                   Value=datavals)
# Show the data
data

# Generate balloon plot with default scaling
balloonplot(data$Car, data$Color, data$Value)


# Show margin label rotation & space expansion, using some long labels
levels(data$Car) <- c("BMW: High End, German",
  "Renault: Medium End, French", "Mercedes: High End, German",
  "Seat: Imaginary, Unknown Producer")

# Generate balloon plot with default scaling
balloonplot(data$Car, data$Color, data$Value, colmar=3, colsrt=90)

# Create an example using table
xnames <- sample(letters[1:3], 50, replace=2)
ynames <- sample(1:5, 50, replace=2)

tab <- table(xnames, ynames)

balloonplot(tab)

# Example of multiple classification variables using the Titanic data
dframe <- as.data.frame(Titanic)  # convert to 1 entry per row format
attach(dframe)
balloonplot(x=Class, y=list(Survived, Age, Sex), z=Freq, sort=TRUE)

# Colorize: surviors lightblue, non-survivors grey
Colors <- Titanic
Colors[,,,"Yes"] <- "skyblue"
Colors[,,,"No"] <- "grey"
colors <- as.character(as.data.frame(Colors)$Freq)

balloonplot(x=list(Age,Sex),
            y=list(Class=Class, Survived=relevel(Survived,"Yes")),
            z=Freq,
            zlab="Number of Passengers",
            sort=TRUE,
            dotcol=colors,
            show.zeros=TRUE,
            show.margins=TRUE)
}
\keyword{dplot}
\keyword{hplot}

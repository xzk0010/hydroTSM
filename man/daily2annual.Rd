%% File daily2annual.Rd
%% Part of the hydroTSM R package, http://www.rforge.net/hydroTSM/ ; 
%%                                 http://cran.r-project.org/web/packages/hydroTSM/
%% Copyright 2008-2013 Mauricio Zambrano-Bigiarini
%% Distributed under GPL 2 or later

\name{(sub)daily2annual}
\Rdversion{1.1}
\alias{daily2annual}
\alias{daily2annual.default}
\alias{daily2annual.zoo}
\alias{daily2annual.data.frame}
\alias{daily2annual.matrix}
\alias{monthly2annual}
\alias{monthly2annual.default}
\alias{monthly2annual.zoo}
\alias{monthly2annual.data.frame}
\alias{monthly2annual.matrix}
\alias{subdaily2annual}
\alias{subdaily2annual.default}
\alias{subdaily2annual.zoo}
\alias{subdaily2annual.data.frame}
\alias{subdaily2annual.matrix}


\title{
(sub)Daily/Monthly -> Annual 
}
\description{
Generic function for transforming a (sub)DAILY/MONTHLY (weekly and quarterly) regular time series into an ANNUAL one.
}
\usage{
daily2annual(x, ...)
subdaily2annual(x, ...)
monthly2annual(x, ...)

\method{daily2annual}{default}(x, FUN, na.rm = TRUE, out.fmt = "\%Y", ...)

\method{daily2annual}{zoo}(x, FUN, na.rm = TRUE, out.fmt = "\%Y-\%m-\%d", ...)

\method{daily2annual}{data.frame}(x, FUN, na.rm = TRUE, out.fmt = "\%Y", dates=1, 
        date.fmt = "\%Y-\%m-\%d", out.type = "data.frame", verbose = TRUE, ...)

\method{daily2annual}{matrix}(x, FUN, na.rm = TRUE, out.fmt = "\%Y", dates=1, 
        date.fmt = "\%Y-\%m-\%d", out.type = "data.frame", verbose = TRUE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
zoo, xts, data.frame or matrix object, with (sub)daily/monthly time series. \cr
Measurements at several gauging stations can be stored in a data.frame or matrix object, and in that case, each column of \code{x} represent the time series measured in each gauging station, and the column names of \code{x} have to correspond to the ID of each station (starting by a letter).
}
  \item{FUN}{
Function that have to be applied for aggregating from (sub)daily/monthly into annual time step (e.g., for precipitation \code{FUN=sum} and for temperature and streamflows ts, \code{FUN=mean}).
}
  \item{na.rm}{
Logical. Should missing values be removed? \cr
-) \kbd{TRUE} : the monthly and annual values  are computed considering only those values different from NA \cr
-) \kbd{FALSE}: if there is AT LEAST one NA within a year, the corresponding annual value is NA.
}
  \item{out.fmt}{
Character indicating the date format for the output time series. See \code{format} in \code{\link[base]{as.Date}}. Possible values are: \cr
-) \kbd{\%Y}        : only the year will be used for the time. Default option. (e.g., "1961" "1962"...) \cr
-) \kbd{\%Y-\%m-\%d}: a complete date format will be used for the time. (e.g., "1961-01-01" "1962-01-01"...)
}
  \item{dates}{
numeric, factor or Date object indicating how to obtain the dates for corresponding to each gauging station \cr
If \code{dates} is a number (default), it indicates the index of the column in \code{x} that stores the dates \cr
If \code{dates} is a factor, it is converted into Date class, using the date format specified by \code{date.fmt} \cr
If \code{dates} is already of Date class, the code verifies that the number of days on it be equal to the number of element in \code{x}
}
  \item{date.fmt}{
character indicating the format in which the dates are stored in \var{dates}, e.g. \kbd{\%Y-\%m-\%d}. See \code{format} in \code{\link[base]{as.Date}}. \cr
ONLY required when \code{class(dates)=="factor"} or \code{class(dates)=="numeric"}.
}
  \item{out.type}{
Character that defines the desired type of output. Valid values are: \cr
-) \kbd{data.frame}: a data.frame, with as many columns as stations are included in \code{x}, and row names indicating the Year \cr
-) \kbd{db}        : a data.frame, with 3 columns will be produced. \cr
                     The first column (StationID) will store the ID of the station \cr
                     The second column (Year) will store the year, \cr
                     The third column (Value) will contain the annual value corresponding to the two previous columns.
}
  \item{verbose}{
logical; if TRUE, progress messages are printed 
}
  \item{\dots}{
further arguments passed to or from other methods.
}
}
%%\details{
%%  ~~ If necessary, more details than the description above ~~
%%}
\value{
a zoo object with annual frequency
}
%%\references{
%% ~put references to the literature/web site here ~
%%}
\author{
Mauricio Zambrano-Bigiarini, \email{mzb.devel@gmail}
}
%%\note{
%%  ~~further notes~~
%%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{daily2monthly}}, \code{\link{monthly2annual}}, \code{\link{hydroplot}}, \code{\link{annualfunction}}, \code{\link{vector2zoo}}, \code{\link{as.Date}}
}
\examples{
######################
## Ex1: Loading the DAILY precipitation data at SanMartino
data(SanMartinoPPts)
x <- SanMartinoPPts

## Daily to Annual
daily2annual(x, FUN=sum, na.rm=TRUE)

######################
## Ex2: Monthly to Annual (same result as )
m <- daily2monthly(x, FUN=sum, na.rm=TRUE)
monthly2annual(m, FUN=sum, na.rm=TRUE)


######################
## Ex3: Loading the time series of HOURLY streamflows for the station Karamea at Gorge
data(KarameaAtGorgeQts)
x <- KarameaAtGorgeQts

# Sub-daily to monthly ts
subdaily2annual(x, FUN=mean, na.rm=TRUE)

############
## Ex4: Loading the monthly time series of precipitation within the Ebro River basin
data(EbroPPtsMonthly)

# computing the annual values for the first 10 gauging station in 'EbroPPtsMonthly'
a <- monthly2annual(EbroPPtsMonthly[,1:11], FUN=sum, dates=1)

# same as before, but with a nicer format of years
a <- monthly2annual(EbroPPtsMonthly[,1:11], FUN=sum, dates=1, out.fmt="\%Y")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{manip}
%%\keyword{ ~kwd2 }

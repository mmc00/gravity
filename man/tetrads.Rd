% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tetrads.R
\name{tetrads}
\alias{tetrads}
\title{Tetrads}
\usage{
tetrads(
  dependent_variable,
  distance,
  additional_regressors,
  code_origin,
  code_destination,
  filter_origin = NULL,
  filter_destination = NULL,
  multiway = FALSE,
  data,
  ...
)
}
\arguments{
\item{dependent_variable}{(Type: character) name of the dependent variable. This variable is logged and then used as
the dependent variable in the estimation.}

\item{distance}{(Type: character) name of the distance variable that should be taken as the key independent variable
in the estimation. The distance is logged automatically when the function is executed.}

\item{additional_regressors}{(Type: character) names of the additional regressors to include in the model (e.g. a dummy
variable to indicate contiguity). Unilateral metric variables such as GDP should be inserted via the arguments
\code{income_origin} and \code{income_destination}.

Write this argument as \code{c(contiguity, common currency, ...)}. By default this is set to \code{NULL}.}

\item{code_origin}{(Type: character) country of origin variable (e.g. ISO-3 country codes). The variables are grouped
using this parameter.}

\item{code_destination}{(Type: character) country of destination variable (e.g. country ISO-3 codes). The variables are
grouped using this parameter.}

\item{filter_origin}{(Type: character) Reference exporting country.}

\item{filter_destination}{(Type: character) Reference importing country.}

\item{multiway}{(Type: logical) in case \code{multiway = TRUE}, the
\code{\link[multiwayvcov]{cluster.vcov}} function is used for estimation following
\insertCite{Cameron2011;textual}{gravity} multi-way clustering of
variance-covariance matrices. The default value is set to \code{TRUE}.}

\item{data}{(Type: data.frame) the dataset to be used.}

\item{...}{Additional arguments to be passed to the function.}
}
\value{
The function returns the summary of the estimated gravity model as an
\code{\link[stats]{lm}}-object.
}
\description{
\code{tetrads} estimates gravity models
by taking the ratio of the ratio of flows.
}
\details{
\code{tetrads} is an estimation method for gravity models
developed by \insertCite{Head2010;textual}{gravity}.

The function \code{tetrads} utilizes the multiplicative form of the
gravity equation. After choosing a reference exporter \code{A} and
importer \code{B} one can eliminate importer and exporter fixed effects
by taking the ratio of ratios.

Only those exporters trading with the
reference importer and importers trading with the reference exporter will
remain for the estimation. Therefore, reference countries should
preferably be countries which trade with every other country in the dataset.

After restricting the data in this way, \code{tetrads} estimates the gravity
equation in its additive form by OLS.

By taking the ratio of ratios, all monadic effects diminish, hence no
unilateral variables such as GDP can be included as independent variables.

\code{tetrads} estimation can be used for both, cross-sectional as well as
panel data. Nonetheless, the function is designed to be consistent with the
Stata code for cross-sectional data provided on the website
\href{https://sites.google.com/site/hiegravity/}{Gravity Equations: Workhorse, Toolkit, and Cookbook}
when choosing robust estimation.

The function \code{tetrads} was therefore tested for cross-sectional data.

If tetrads is used for panel data, the user may have to drop distance as an
independent variable as time-invariant effects drop.

For applying \code{tetrads} to panel data see \insertCite{Head2010;textual}{gravity}.
}
\examples{
# Example for CRAN checks:
# Executable in < 5 sec
library(dplyr)
data("gravity_no_zeros")

# Choose 5 countries for testing
countries_chosen <- c("AUS", "CHN", "GBR", "BRA", "CAN")
grav_small <- filter(gravity_no_zeros, iso_o \%in\% countries_chosen)

fit <- tetrads(
  dependent_variable = "flow",
  distance = "distw",
  additional_regressors = "rta",
  code_origin = "iso_o",
  code_destination = "iso_d",
  filter_origin = countries_chosen[1],
  filter_destination = countries_chosen[2],
  data = grav_small
)
}
\references{
For more information on gravity models, theoretical foundations and
estimation methods in general see

\insertRef{Anderson1979}{gravity}

\insertRef{Anderson2001}{gravity}

\insertRef{Anderson2010}{gravity}

\insertRef{Baier2009}{gravity}

\insertRef{Baier2010}{gravity}

\insertRef{Feenstra2002}{gravity}

\insertRef{Head2010}{gravity}

\insertRef{Head2014}{gravity}

\insertRef{Santos2006}{gravity}

and the citations therein.

See \href{https://sites.google.com/site/hiegravity/}{Gravity Equations: Workhorse, Toolkit, and Cookbook} for gravity datasets and Stata code for estimating gravity models.

For estimating gravity equations using panel data see

\insertRef{Egger2003}{gravity}

\insertRef{Gomez-Herrera2013}{gravity}

and the references therein.
}
\seealso{
\code{\link[stats]{lm}}, \code{\link[lmtest]{coeftest}},
}

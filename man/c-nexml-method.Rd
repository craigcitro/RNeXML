\docType{methods}
\name{c,nexml-method}
\alias{c,nexml-method}
\title{Concatenate nexml files}
\usage{
\S4method{c}{nexml}(x, ..., recursive = FALSE)
}
\arguments{
  \item{x,...}{nexml objects to be concatenated, e.g. from
  \code{\link{write.nexml}} or \code{\link{read.nexml}}.
  Must have unique ids on all elements}

  \item{recursive}{logical.  If 'recursive = TRUE', the
  function recursively descends through lists (and
  pairlists) combining all their elements into a vector.
  (Not implemented).}
}
\value{
a concatenated nexml file
}
\description{
Concatenate nexml files
}
\examples{
f1 <- system.file("examples", "trees.xml", package="RNeXML")
f2 <- system.file("examples", "comp_analysis.xml", package="RNeXML")
nex1 <- read.nexml(f1)
nex2 <- read.nexml(f2)
nex <- c(nex1, nex2)
}


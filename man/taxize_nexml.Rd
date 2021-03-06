\name{taxize_nexml}
\alias{taxize_nexml}
\title{taxize nexml}
\usage{
taxize_nexml(nexml, type = c("NCBI"), ...)
}
\arguments{
  \item{nexml}{a nexml object}

  \item{type}{the name of the identifier to use}

  \item{...}{additional arguments (not implemented yet)}
}
\description{
Check taxanomic names against the specified service and add
appropriate semantic metadata to the nexml OTU unit
containing the corresponding identifier.
}


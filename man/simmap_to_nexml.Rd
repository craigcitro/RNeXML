\name{simmap_to_nexml}
\alias{simmap_to_nexml}
\title{simmap_to_nexml}
\usage{
simmap_to_nexml(phy, state_ids = NULL)
}
\arguments{
  \item{phy}{a phy object containing simmap phy$maps
  element, from the phytools pacakge}

  \item{state_ids}{a named character vector giving the
  state names corresponding to the ids used to refer to
  each state in nexml.  If null ids will be generated and
  states taken from the phy$states names.}
}
\value{
a nexml representation of the simmap
}
\description{
simmap_to_nexml
}


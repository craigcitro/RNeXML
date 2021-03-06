\name{get_rdf}
\alias{get_rdf}
\title{Extract rdf-xml from a NeXML file}
\usage{
get_rdf(file)
}
\arguments{
  \item{file}{the name of a nexml file, or otherwise a
  nexml object.}
}
\value{
an RDF-XML object (XMLInternalDocument).  This can be
manipulated with tools from the XML R package, or converted
into a triplestore for use with SPARQL queries from the
rrdf R package.
}
\description{
Extract rdf-xml from a NeXML file
}
\examples{
\dontrun{
f <- system.file("examples", "meta_example.xml", package="RNeXML")
rdf <- get_rdf(f)

## Query the rdf with XPath:
xpathSApply(rdf, "//dc:title", xmlValue)

## Write to a file and read in with rrdf
saveXML(rdf, "rdf_meta.xml")
library(rrdf)
lib <- load.rdf("rdf_meta.xml")

## Perform a SPARQL query:
sparql.rdf(lib, "SELECT ?title WHERE { ?x <http://purl.org/dc/elements/1.1/title> ?title}")
}
}


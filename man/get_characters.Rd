\name{get_characters}
\alias{get_characters}
\title{Get character data.frame, accepts either nexml object, or a list of data.frames}
\usage{
get_characters(input, suffixes = FALSE)
}
\arguments{
  \item{input}{A nexml object (e.g., as output from
  \code{\link{read.nexml}}), or a list of data.frame's
  (e.g., as output from \code{\link{get_characters_list}})}

  \item{suffixes}{Add list element names as suffixes to
  output data.frame column names.}
}
\description{
Get character data.frame, accepts either nexml object, or a
list of data.frames
}
\examples{
\dontrun{
# A simple exmample with a discrete and a continous trait
f <- system.file("examples", "comp_analysis.xml", package="RNeXML")
nex <- read.nexml(f)
get_characters(nex)

# with different row.names
char_list <- get_characters_list(nex)
row.names(char_list[[1]])[1:3] <- c("taxon_18","taxon_20","taxon_30")
get_characters(char_list)

# A more complex example -- currently ignores sequence-type characters
f <- system.file("examples", "characters.xml", package="RNeXML")
nex <- read.nexml(f)
get_characters(nex)
}
}


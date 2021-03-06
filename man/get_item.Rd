\name{get_item}
\alias{get_item}
\title{Get the desired element from the nexml object}
\usage{
get_item(nexml, element = c("trees", "trees_list", "flat_trees", "metadata",
  "otu", "characters", "characters_list"), level = c("nexml", "otus", "otu",
  "trees", "tree"))
}
\arguments{
  \item{nexml}{a nexml object (from read_nexml)}

  \item{element}{the kind of object desired, see details.}

  \item{level}{metadata argument only.  Define whose
  metadata we want. See examples for details.}
}
\value{
return type depends on the element requested.  See details.
}
\description{
Get the desired element from the nexml object
}
\details{
\itemize{ \item{"tree"}{ an ape::phylo tree, if only one
tree is represented.  Otherwise returns a list of lists of
multiphylo trees.  To consistently recieve the list of
lists format (preserving the heriarchical nature of the
nexml), use \code{trees} instead.} \item{"trees"}{ returns
a list of lists of multiphylo trees, even if all trees are
in the same `trees` node (and hence the outer list will be
of length 1) or if there is only a single tree (and hence
the inner list will also be of length 1.  This guarentees a
consistent return type regardless of the number of trees
present in the nexml file, and also preserves any
heirarchy/grouping of trees.  } \item{"flat_trees"}{ a
multiPhylo object (list of ape::phylo objects) Note that
this method collapses any heirachical structure that may
have been present as multiple `trees` nodes in the original
nexml (though such a feature is rarely used).  To preserve
that structure, use `trees` instead.} \item{"metadata"}{Get
metadata from the specified level (default is top/nexml
level) } \item{"otu"}{ returns a named character vector
containing all available metadata.  names indicate
\code{property} (or \code{rel} in the case of
links/resourceMeta), while values indicate the
\code{content} (or \code{href} for links). } } For a
slightly cleaner interface, each of these elements is also
defined as an S4 method for a nexml object.  So in place of
`get_item(nexml, "tree")`, one could use `get_tree(nexml)`,
and so forth for each element type.
}
\seealso{
\code{\link{get_trees}}
}


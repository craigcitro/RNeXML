<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{An Introduction to the RNeXML package}
-->

[![Build Status](https://api.travis-ci.org/ropensci/RNeXML.png)](https://travis-ci.org/ropensci/RNeXML)

RNeXML: The next-generation phylogenetics format comes to R
=====================================================


An R package for reading, writing, integrating and publishing data using the Ecological Metadata Language (EML) format.   

* **Note:** This package is still in active development and not yet submitted to CRAN.  Functions and documentation may be incomplete and subject to change.  
* Maintainer: Carl Boettiger
* Authors: Carl Boettiger, Scott Chamberlain, Hilmar Lapp, Kseniia Shumelchyk, Rutger Vos
* License: BSD-3 
* [Issues](https://github.com/ropensci/RNeXML/issues): Bug reports, feature requests, and development discussion.

An extensive and rapidly growing collection of richly annotated phylogenetics data is now available in the NeXML format. NeXML relies on state-of-the-art data exchange technology to provide a format that can be both validated and extended, providing a data quality assurance and and adaptability to the future that is lacking in other formats [Vos et al 2012](http://doi.org/10.1093/sysbio/sys025 "NeXML: Rich, Extensible, and Verifiable Representation of Comparative Data and Metadata."). 





Getting Started
---------------

The development version of RNeXML is [available on Github](https://github.com/ropensci/RNeXML).  With the `devtools` package installed on your system, RNeXML can be installed using:


```r
library(devtools)
install_github("RNeXML", "ropensci")
library(RNeXML)
```





Read in a `nexml` file into the `ape::phylo` format:


```r
f <- system.file("examples", "comp_analysis.xml", package="RNeXML")
nexml <- nexml_read(f)
tr <- get_trees(nexml) # or: as(nexml, "phylo")
plot(tr[[1]])
```

![plot of chunk unnamed-chunk-4](http://farm8.staticflickr.com/7296/12662932795_51f8b84960_o.png) 


Write an `ape::phylo` tree into the `nexml` format:


```r
data(bird.orders)
nexml_write(bird.orders, "test.xml")
```

```
## [1] "test.xml"
```


A key feature of NeXML is the ability to formally validate the construction of the data file against the standard (the lack of such a feature in nexus files had lead to inconsistencies across different software platforms, and some files that cannot be read at all).  While it is difficult to make an invalid NeXML file from `RNeXML`, it never hurts to validate just to be sure:


```r
nexml_validate("test.xml")
```

```
## [1] TRUE
```




Extract metadata from the NeXML file: 


```r
birds <- nexml_read("test.xml")
get_taxa(birds)
```

```
##  [1] "Struthioniformes" "Tinamiformes"     "Craciformes"     
##  [4] "Galliformes"      "Anseriformes"     "Turniciformes"   
##  [7] "Piciformes"       "Galbuliformes"    "Bucerotiformes"  
## [10] "Upupiformes"      "Trogoniformes"    "Coraciiformes"   
## [13] "Coliiformes"      "Cuculiformes"     "Psittaciformes"  
## [16] "Apodiformes"      "Trochiliformes"   "Musophagiformes" 
## [19] "Strigiformes"     "Columbiformes"    "Gruiformes"      
## [22] "Ciconiiformes"    "Passeriformes"
```

```r
get_metadata(birds) 
```

```
##                                          dc:pubdate 
##                                        "2014-02-20" 
##                                          cc:license 
## "http://creativecommons.org/publicdomain/zero/1.0/"
```


--------------------------------------------


Add basic additional metadata:  


```r
  nexml_write(bird.orders, file="meta_example.xml",
              title = "My test title",
              description = "A description of my test",
              creator = "Carl Boettiger <cboettig@gmail.com>",
              publisher = "unpublished data",
              pubdate = "2012-04-01")
```

```
## [1] "meta_example.xml"
```

By default, `RNeXML` adds certain metadata, including the NCBI taxon id numbers for all named taxa.  This acts a check on the spelling and definitions of the taxa as well as providing a link to additional metadata about each taxonomic unit described in the dataset.  


### Advanced annotation


We can also add arbitrary metadata to a NeXML tree by define `meta` objects:


```r
modified <- meta(property = "prism:modificationDate",
                 content = "2013-10-04")
```


Advanced use requires specifying the namespace used.  Metadata follows the RDFa conventions.  Here we indicate the modification date using the prism vocabulary. This namespace is included by default, as it is used for some of the basic metadata shown in the previous example.  We can see from this list:


```r
RNeXML:::nexml_namespaces
```

```
##                                                      nex 
##                              "http://www.nexml.org/2009" 
##                                                      xsi 
##              "http://www.w3.org/2001/XMLSchema-instance" 
##                                                      xml 
##                   "http://www.w3.org/XML/1998/namespace" 
##                                                     cdao 
## "http://www.evolutionaryontology.org/cdao/1.0/cdao.owl#" 
##                                                      xsd 
##                      "http://www.w3.org/2001/XMLSchema#" 
##                                                       dc 
##                       "http://purl.org/dc/elements/1.1/" 
##                                                  dcterms 
##                              "http://purl.org/dc/terms/" 
##                                                    prism 
##         "http://prismstandard.org/namespaces/1.2/basic/" 
##                                                       cc 
##                         "http://creativecommons.org/ns#" 
##                                                     ncbi 
##                  "http://www.ncbi.nlm.nih.gov/taxonomy#" 
##                                                       tc 
##          "http://rs.tdwg.org/ontology/voc/TaxonConcept#"
```


This next block defines a resource (link), described by the `rel` attribute as a homepage, a term in the `foaf` vocabulalry.  Becuase `foaf` is not a default namespace, we will have to provide its URL in the full definition below. 


```r
website <- meta(href = "http://carlboettiger.info", 
                rel = "foaf:homepage")
```


Here we create a history node using the `skos` namespace.  We can also add id values to any metadata element to make the element easier to reference externally: 


```r
  history <- meta(property = "skos:historyNote", 
                  content = "Mapped from the bird.orders data in the ape package using RNeXML",
                  id = "meta123")
```


Once we have created the `meta` elements, we can pass them to our `nexml_write` function, along with definitions of the namespaces.  


```r
  nexml_write(bird.orders, 
              file = "example.xml", 
              meta = list(history, modified, website), 
              namespaces = c(skos = "http://www.w3.org/2004/02/skos/core#",
                             foaf = "http://xmlns.com/foaf/0.1/"))
```

```
## Error: unused arguments (meta = list(<S4 object of class "meta">, <S4
## object of class "meta">, <S4 object of class "meta">), namespaces =
## c("http://www.w3.org/2004/02/skos/core#", "http://xmlns.com/foaf/0.1/"))
```


### Taxonomic identifiers

Add taxonomic identifier metadata to the OTU elements:



```r
nex <- add_trees(bird.orders)
nex <- taxize_nexml(nex)
```

```
## Error: no slot of name "otu" for this object of class "ListOfotus"
```




## Working with character data

NeXML also provides a standard exchange format for handling character data.  The R platform is particularly popular in the context of phylogenetic comparative methods, which consider both a given phylogeny and a set of traits.  NeXML provides an ideal tool for handling this metadata.  

### Extracting character data

We can load the library, parse the NeXML file and extract both the characters and the phylogeny.  


```r
library(RNeXML)
nexml <- read.nexml(system.file("examples", "comp_analysis.xml", package="RNeXML"))
traits <- get_characters(nexml)
tree <- get_trees(nexml)
```


(Note that `get_characters` would return both discrete and continuous characters together in the same data.frame, but we use `get_characters_list` to get separate data.frames for the continuous `characters` block and the discrete `characters` block).  

We can then fire up `geiger` and fit, say, a Brownian motion model the continuous data and a Markov transition matrix to the discrete states:  


```r
library(geiger)
fitContinuous(tree, traits[[1]])
```

```
## Error: names for 'data' must be supplied
```

```r
fitDiscrete(tree, traits[[2]])
```

```
## Error: names for 'data' must be supplied
```







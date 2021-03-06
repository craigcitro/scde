% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/functions.R
\name{pagoda.subtract.aspect}
\alias{pagoda.subtract.aspect}
\title{Control for a particular aspect of expression heterogeneity in a given population}
\usage{
pagoda.subtract.aspect(varinfo, aspect, center = TRUE)
}
\arguments{
\item{varinfo}{normalized variance info (from pagoda.varnorm())}

\item{aspect}{a vector giving a cell-to-cell variation pattern that should be controlled for (length should be corresponding to ncol(varinfo$mat))}

\item{center}{whether the matrix should be re-centered following pattern subtraction}
}
\value{
a modified varinfo object with adjusted expression matirx (varinfo$mat)
}
\description{
Similar to subtracting n-th principal component, the current procedure determines
(weighted) projection of the expression matrix onto a specified aspect (some pattern
across cells, for instance sequencing depth, or PC corresponding to an undesired process
such as ribosomal pathway variation) and subtracts it from the data so that it is controlled
for in the subsequent weighted PCA analysis.
}
\examples{
\donttest{
data(pollen)
cd <- pollen.counts
cd <- cd[,colSums(cd>0)>1.8e3]
cd <- cd[rowSums(cd)>10,]
cd <- cd[rowSums(cd>0)>5,]
knn <- knn.error.models(cd, k=ncol(cd)/4, n.cores=10, min.count.threshold=2, min.nonfailed=5, max.model.plots=10)
varinfo <- pagoda.varnorm(knn, counts = cd, trim = 3/ncol(cd), max.adj.var = 5, n.cores = 1, plot = FALSE)
data(go.env)  # Load GO annotations as an environment
cc.pattern <- pagoda.show.pathways(ls(go.env)[1:2], varinfo, go.env, show.cell.dendrogram = TRUE, showRowLabels = TRUE)  # Look at pattern from 2 GO annotations
# subtract the pattern
varinfo.cc <- pagoda.subtract.aspect(varinfo, cc.pattern)
}
}


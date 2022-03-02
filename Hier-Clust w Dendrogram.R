# Compute distances and hierarchical clustering
dd <- dist(scale(df), method = "euclidean")
hc <- hclust(dd, method = "cen") 

plot(x, labels = NULL, hang = 0.1, 
     main = "Cluster dendrogram", sub = NULL,
     xlab = NULL, ylab = "Height")

# Default plot
plot(hc)

# Put the labels at the same height: hang = -1
plot(hc, hang = -1, cex = 0.6)

# To visualize the result of a hierarchical clustering analysis using the function plot.dendrogram(), 
# we must firstly convert it as a dendrogram.

# The format of the function plot.dendrogram() is:

# type of plot. Possible values are “rectangle” or “triangle”
# horiz: logical indicating if the dendrogram should be drawn horizontally or no

# Convert hclust into a dendrogram and plot
hcd <- as.dendrogram(hc)
# Default plot
plot(hcd, type = "rectangle", ylab = "Height")

# Triangle plot
plot(hcd, type = "triangle", ylab = "Height")

# Zoom in to the first dendrogram
plot(hcd, xlim = c(1, 20), ylim = c(1,8))

# nodePar: a list of plotting parameters to use for the nodes (see ?points). Default value is NULL. The list may contain components named pch, cex, col, xpd, and/or bg each of which can have length two for specifying separate attributes for inner nodes and leaves.
# edgePar: a list of plotting parameters to use for the edge segments (see ?segments). The list may contain components named col, lty and lwd (for the segments). As with nodePar, each can have length two for differentiating leaves and inner nodes.
# leaflab: a string specifying how leaves are labeled. The default “perpendicular” write text vertically; “textlike” writes text horizontally (in a rectangle), and “none” suppresses leaf labels.

# Define nodePar
nodePar <- list(lab.cex = 0.6, pch = c(NA, 19), 
                cex = 0.7, col = "blue")
# Customized plot; remove labels
plot(hcd, ylab = "Height", nodePar = nodePar, leaflab = "none")

# Horizontal plot
plot(hcd,  xlab = "Height",
     nodePar = nodePar, horiz = TRUE)

# Change edge color
plot(hcd,  xlab = "Height", nodePar = nodePar, 
     edgePar = list(col = 2:3, lwd = 2:1))

XXXXXXXX=================================================XXXXXXXX

Produce a more sophisticated dendrogram.

# install.packages("ape")
library("ape")
# Default plot
plot(as.phylo(hc), cex = 0.6, label.offset = 0.5)

# Cladogram
plot(as.phylo(hc), type = "cladogram", cex = 0.6, 
     label.offset = 0.5)

# Unrooted
plot(as.phylo(hc), type = "unrooted", cex = 0.6,
     no.margin = TRUE)

# Fan
plot(as.phylo(hc), type = "fan")

# Radial
plot(as.phylo(hc), type = "radial")

# Cut the dendrogram into 4 clusters
colors = c("red", "blue", "green", "black")
clus4 = cutree(hc, 4)
plot(as.phylo(hc), type = "fan", tip.color = colors[clus4],
     label.offset = 1, cex = 0.7)

# Change the appearance
# change edge and label (tip)
plot(as.phylo(hc), type = "cladogram", cex = 0.6,
     edge.color = "steelblue", edge.width = 2, edge.lty = 2,
     tip.color = "steelblue")

# Package: pvclust is for calculating p-values for hierarchical clustering.

library(pvclust)
Classification tree diagrams
===========================
if(require(rpart)){
  model <- rpart(RID ~ D1 + D2, 
                   method = "class", data = df)
  ddata <- dendro_data(model)
  ggplot() + 
    geom_segment(data = df$RID, 
            aes(x = x, y = y, xend = xend, yend = yend)) + 
    geom_text(data = df$D1, 
            aes(x = x, y = y, label = label), size = 3, vjust = 0) +
    geom_text(data = df$D2, 
            aes(x = x, y = y, label = label), size = 3, vjust = 1) +
      theme_dendro()
  }
#> Loading required package: rpart

Twins diagrams: agnes and diana
===============================
  
if(require(cluster)){
  model <- agnes(df, metric = "manhattan", stand = TRUE)
  dg <- as.dendrogram(model)
  ggdendrogram(dg)
    
  model <- diana(df, metric = "manhattan", stand = TRUE)
  dg <- as.dendrogram(model)
  ggdendrogram(dg)
}
#> Loading required package: cluster

## we scale the coordinates to normalize our features

RID <- c(1:6)
D1 <- c(8, 5, 2, 2, 2, 8)
D2 <- c(4, 4, 4, 6, 8, 6)
df = c(RID, D1, D2)
df = data.frame(RID, D1, D2)
.cluster <-  KMeans(model.matrix(~-1 + D1 + D2 + RID, df), centers = 3, iter.max = 10, num.seeds = 10)
.cluster$size # Cluster Sizes
.cluster$centers # Cluster Centroids
.cluster$withinss # Within Cluster Sum of Squares
.cluster$tot.withinss # Total Within Sum of Squares
.cluster$betweenss # Between Cluster Sum of Squares
biplot(princomp(model.matrix(~-1 + D1 + D2 + RID, df)), xlabs = as.character(.cluster$cluster))
df$KMeans <- assignCluster(model.matrix(~-1 + D1 + D2 + RID, df), df, .cluster$cluster)
remove(.cluster)
editDataset(df)

print(df)

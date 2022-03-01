set.seed(4304)

# Make a sequence of values from 1 to the number of rows of your dataset by 2s.
s <- seq(1, nrow(df), by=2)
# Use sapply() to make the distance between each pair of points.
out <- sapply(s, function(i){
  sqrt(sum((df[i,] - df[(i+1), ])^2))
})

# Organize the distances into a data frame
res <- data.frame(
  pair = paste(rownames(df)[s], rownames(df)[(s+1)], sep="-"), 
  dist=out)
head(res)
summary(res)

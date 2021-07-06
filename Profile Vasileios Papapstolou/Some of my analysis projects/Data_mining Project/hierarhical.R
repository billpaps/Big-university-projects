# Generate 1000 random numbers from unit gaussian distribution
Xrandom = 10*rnorm(100)

# Generate 1000 numbers from unit Gaussian
Yrandom = 10*rnorm(100)

# plot the scatter plot. We choose color in Hexadecimal system
plot(Xrandom, Yrandom, col="#FF5533", main="Scatter plot", xlim=c(-40,40), ylim=c(-40,40))



data <- data.frame(Xrandom, Yrandom)
data=as.matrix(data)

n = dim(data)[1]
d = dim(data)[2]
## calculate Euclidean distance
Distance <- function(X, c) {
  dists = apply(X, 1, function(point)
    sapply(1:nrow(c), function(dim)
      dist(rbind(point, c[dim, ]))))
  return(t(dists))
}


dist_matrix = Distance(data,data)

clusters = matrix(0, nrow = n, ncol = 1)
clust = 1
for (i in 1:n){
  clusters[i] = clust
  clust = clust + 1
}



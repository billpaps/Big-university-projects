wines <- as.matrix(read.table("wine.data", header = FALSE, sep = ","))

i = 1

#Features
column_names = list("Index", "Alcohol", "Malic acid", "Ash", "Alcalinity of ash", "Magnesium", "Total phenols", "Flavanoids", 
                "Nonflavanoid phenols", "Proanthocyanins", "Color intensity", "Hue", "OD280/OD315 of diluted wines", 
                "Proline")

for (index in colnames(wines)) {
  colnames(wines)[i] = column_names[i]
  i = i + 1
}


# Select rows and columns
n = dim(wines)[1]
d = dim(wines)[2]

# Preprocessing
for (feauture in 2:d) {
  wines[, feauture] = wines[, feauture] / max(wines[, feauture])
}


## select 3 random points for initial means
ids = sample(1:n, 3)
centroids = wines[ids, ]
dist = matrix(0, nrow = 3, ncol = 1)

point_centroid = matrix(0, nrow = n, ncol = 1)
mean_centroid = matrix(0, nrow = 3, ncol = d+1)

flag = TRUE
i = 1
times = 0




while (times < 100) {
  for (point in 1:n) {
    dist = matrix(0, nrow = 3, ncol = 1)
    for (features in 2:d) {
      for (i in 1:3) {
        dist[i] = dist[i] + (wines[point, features] - centroids[i, features])^2
      }
    }
    point_centroid[point] = which.min(dist)
  }
  for (i in 1:n) {
    for (j in 2:d) {
      mean_centroid[point_centroid[i,1], j] = mean_centroid[point_centroid[i,1], j] + wines[i,j] 
    }
    mean_centroid[point_centroid[i,1], d+1] = mean_centroid[point_centroid[i,1], d+1] + 1
  }
  for (i in 1:3){
    mean_centroid[i,] = mean_centroid[i,] / mean_centroid[i, d+1]
  }
  
  times = times + 1
}
  
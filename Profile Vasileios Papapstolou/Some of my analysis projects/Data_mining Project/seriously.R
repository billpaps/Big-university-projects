
wines <- as.matrix(read.csv("forestfires.csv", header = FALSE, sep = ","))

dist_matrix <- as.matrix(dist(wines))

hclust(dist_matrix, method="complete")

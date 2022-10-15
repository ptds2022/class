# Lecture 4: data structure
# vectors
# 1.
x <- 3 * seq_len(4)
x[2]
x[-c(1,3,4)]
x[c(F, T, FALSE, FALSE)]

# 2. 
x[length(x):1]
sort(x, decreasing = TRUE)

# matrix
set.seed(1)
A <- matrix(rnorm(20), ncol = 2)
B <- matrix(rnorm(20), ncol = 2)
# 1.
t(A) %*% B # or crossprod(A,B)
A %*% t(B) # or tcrossprod(A,B)

# 2.
C <- rbind(A,B)

# 3.
m <- colMeans(C)
D <- matrix(nrow = nrow(C), ncol = ncol(C))
D[,1] <- C[,1] - m[1]
D[,2] <- C[,2] - m[2]
crossprod(D) / (nrow(D) - 1)
cov(C)

source("kalmanFilter.R")

library(MASS)
library(matlib)

F = matrix(c(1,0.2,0,1), byrow = TRUE, ncol = 2)
H = matrix(c(1,0,0,1), byrow = TRUE, ncol = 2)
iteration = 100

cov0 = matrix(c(10, 0, 0, 11), ncol = 2, byrow = TRUE)
covX = matrix(c(0.1, 0, 0, 0.1), ncol = 2, byrow = TRUE)
covZ = matrix(c(1, 0, 0, 1), ncol = 2, byrow = TRUE)
covT = matrix(c(1, 0, 0, 1), ncol = 2, byrow = TRUE)

filter = (kalmanFilter(F,H,cov0,covX,covZ,covT,iteration))
x = filter$real
z = filter$observed
t = filter$kalman

par(mfrow = c(1, 1))
plot(t, col="red", type="b", pch="F")
points(z, col="green", type="b", pch="O")
points(x, col="blue", type="b", pch="R")
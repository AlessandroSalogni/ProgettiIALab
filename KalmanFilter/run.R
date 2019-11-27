library(MASS)
library(matlib)

F = matrix(c(1,0.2,0,1), byrow = TRUE, ncol = 2)
H = matrix(c(1,0,0,1), byrow = TRUE, ncol = 2)

cov0 = matrix(c(10, 0, 0, 11), ncol = 2, byrow = TRUE)
x0 = mvrnorm(1, c(0,0), cov0)

covX = matrix(c(10, 0, 0, 10), ncol = 2, byrow = TRUE)
covZ = matrix(c(10, 0, 0, 9), ncol = 2, byrow = TRUE)
x = (simulateProcess(F,H,x0,covX,covZ))$real
z = (simulateProcess(F,H,x0,covX,covZ))$observed

t0 = mvrnorm(1, c(0,0), cov0)
t = kalmanFilter(z,F,H,t0,covX, covZ, cov0)

par(mfrow = c(1, 1))
plot(t, col="red", type="b", pch="f")
points(z, col="green", type="b", pch="O")
points(x, col="blue", type="b", pch="R")
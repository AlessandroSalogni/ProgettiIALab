source("kalmanFilter.R")

library(MASS)
library(matlib)

F = matrix(c(1,0.2,0,1), byrow = TRUE, ncol = 2)
H = matrix(c(1,0,0,1), byrow = TRUE, ncol = 2)
iteration = 20

cov0 = matrix(c(10, 0, 0, 11), ncol = 2, byrow = TRUE)
covX = matrix(c(0.1, 0, 0, 0.1), ncol = 2, byrow = TRUE)
covZ = matrix(c(1, 0, 0, 1), ncol = 2, byrow = TRUE)
covT = matrix(c(1, 0, 0, 1), ncol = 2, byrow = TRUE)

filter = kalmanFilter(F,H,cov0,covX,covZ,covT,iteration)
x = filter$real
z = filter$observed
t = filter$kalman

par(mfrow = c(1, 1))
plot(z, col="green", type="b", main="Kalman Filter", xlab ="X", ylab="Y", lty=2, pch=8, xlim=c(0, max(z[,1], na.rm = TRUE)), ylim=c(0, max(z[,2], na.rm = TRUE)))
lines(t, col="red", type="b", pch=4)
lines(x, col="blue", type="b", lty=4, pch=0)
legend("bottomright", legend = c("Observed","Filtered", "Real"), pch=c(8,4,0), col = c("green", "red","blue"))
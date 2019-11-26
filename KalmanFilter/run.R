source("C:/Users/Alessandro/Desktop/Università/Magistrale/Intelligenza Artificiale/Progetti/KalmanFilter/simulateProcess.R")
source("C:/Users/Alessandro/Desktop/Università/Magistrale/Intelligenza Artificiale/Progetti/KalmanFilter/kalmanFilter.R")
library(MASS)

F = matrix(c(1,0.2,0,1), byrow = TRUE, ncol = 2)
H = matrix(c(1,0,0,1), byrow = TRUE, ncol = 2)

cov0 = matrix(c(100, 0, 0, 100), ncol = 2, byrow = TRUE)
x0 = mvrnorm(1, c(0,0), cov0)

covX = matrix(c(10, 0, 0, 10), ncol = 2, byrow = TRUE)
covZ = matrix(c(100, 0, 0, 100), ncol = 2, byrow = TRUE)
z = simulateProcess(F,H,x0,covX,covZ)

t0 = mvrnorm(1, c(0,0), cov0)
t = kalmanFilter(z,F,H,t0,covX, covZ, cov0)

par(mfrow = c(1, 2))
plot(t[,1], t[,2])
plot(z[,1], z[,2])
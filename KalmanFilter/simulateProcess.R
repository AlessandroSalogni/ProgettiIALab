simulateProcess = function(F, H, x0, covX, covZ, covT) {
  x = matrix(ncol = length(x0), nrow = 100)
  z = matrix(ncol = length(x0), nrow = 100)
  x[1,] = x0
  
  for(i in 1 : (nrow()-1)) {
    muF = F%*%x[i,]
    transNoise = (mvrnorm(1, muF, covX) - muF) / diag(covX)
    x[i+1,] = muF + transNoise
    
    muH = H%*%x[i+1,]
    obsNoise = (mvrnorm(1, muH, covZ) - muH) / diag(covZ)
    z[i+1,] = muH + obsNoise
  }
  
  par(mfrow = c(1, 2))
  plot(x[,1], x[,2])
  plot(z[,1], z[,2])
}

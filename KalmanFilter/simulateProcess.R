simulateProcess = function(F, H, x0, covX, covZ) {
  x = matrix(ncol = length(x0), nrow = 100)
  z = matrix(ncol = length(x0), nrow = 100)
  x[1,] = x0
  
  for(i in 1 : (nrow(x)-1)) {
    transNoise = mvrnorm(1, 0, covX) ##errore di transizione centrato in 0 per ogni variabile
    x[i+1,] = F%*%x[i,] + transNoise ##muF + errore di transizione
    
    obsNoise = mvrnorm(1, muH, covZ) ##errore di misurazione centrato in 0 per ogni variabile
    z[i+1,] = H%*%x[i+1,] + obsNoise ##muH + errore di misurazione
  }
  
  par(mfrow = c(1, 2))
  plot(x[,1], x[,2])
  plot(z[,1], z[,2])
}

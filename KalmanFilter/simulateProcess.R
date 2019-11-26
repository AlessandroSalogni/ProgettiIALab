simulateProcess = function(F, H, x0, covX, covZ) {
  x = matrix(ncol = length(x0), nrow = 10)
  z = matrix(ncol = length(x0), nrow = 10)
  x[1,] = x0
  
  for(i in 1 : (nrow(x)-1)) {
    muF = F%*%x[i,]
    transNoise = mvrnorm(1, muF, covX) - muF ##errore di transizione centrato in 0 per ogni variabile
    x[i+1,] = muF + transNoise ##stato successivo = muF + errore di transizione
    
    muH = H%*%x[i+1,]
    obsNoise = mvrnorm(1, muH, covZ) - muH ##errore di misurazione centrato in 0 per ogni variabile
    z[i+1,] = muH + obsNoise ##osservazione sullo stato successivo = muH + errore di misurazione
  }
  
  return(z)
}

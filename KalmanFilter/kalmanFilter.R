kalmanFilter = function(F, H, cov0, covX, covZ, covT, iteration) {
  x = matrix(ncol = dim(cov0)[1], nrow = iteration)
  z = matrix(ncol = dim(cov0)[1], nrow = iteration)
  t = matrix(ncol = length(t0), nrow = iteration)
  
  x[1,] = mvrnorm(1, c(0,0), cov0)
  t[1,] = mvrnorm(1, c(0,0), cov0)
  
  for(i in 1 : (nrow(x)-1)) {
    muF = F%*%x[i,]
    transNoise = mvrnorm(1, muF, covX) - muF ##errore di transizione centrato in 0 per ogni variabile
    x[i+1,] = muF + transNoise ##stato successivo = muF + errore di transizione
    
    muH = H%*%x[i+1,]
    obsNoise = mvrnorm(1, muH, covZ) - muH ##errore di misurazione centrato in 0 per ogni variabile
    z[i+1,] = muH + obsNoise ##osservazione sullo stato successivo = muH + errore di misurazione
    
    p = F*covT*t(F) + covX
    kalmanGain = p*t(H)*inv(H*p*t(H) + covZ)
    covT = (diag(dim(covT)[1]) - kalmanGain*H)*p
    t[i+1,] = F%*%t[i,] + kalmanGain%*%(z[i+1,] - (H%*%F%*%t[i,]))   
  }
  
  return(list("real" = x, "observed" = z, "kalman" = t))
}

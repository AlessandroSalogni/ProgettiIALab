kalmanFilter = function(z, F, H, t0, covX, covZ, sigmaT) {
  t = matrix(ncol = length(t0), nrow = 10)
  t[1,] = t0
  
  for(i in 1 : (nrow(t)-1)) {
    tmp = F*sigmaT*t(F) + covX
    kalmanGain = tmp*t(H)*(H*tmp*t(H) + covZ + matrix(rep(0.000001, 4), nrow=2))^-1
    sigmaT = (diag(length(t0)) - kalmanGain*H)*tmp
    t[i+1,] = F%*%t[i,] + kalmanGain%*%t(z[i+1,] - t(H%*%F%*%t[i,])) 
  }
  
  return(t)
}
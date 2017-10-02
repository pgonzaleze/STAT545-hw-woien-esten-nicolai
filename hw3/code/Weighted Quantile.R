weighted.quantile <- function(x, probs=seq(0, 1 ,0.25), weight=rep(1,length(x))) {
  
  x <- sort(x)
  n.probs    <- length(probs)
  quantiles  <- numeric(n.probs)
  cum.weight <- cumsum(weight)
  cum.weight <- cum.weight/tail(cum.weight,n=1)
  
  for (i in 1:n.probs) {
    p = probs[i]
    
    for (j in 1:length(cum.weight)) {
      if (cum.weight[j] >= p) {
        quantiles[i] = x[j]
        break
      }
    }
  }
  return(quantiles)
}
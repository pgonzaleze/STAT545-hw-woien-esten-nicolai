weighted.quantile <- function(x, probs=seq(0, 1 ,0.25), weight=rep(1,length(x))) {
  
  
  
  #id <- order(x)
  #sort(x)
  dat <- sort(x, index.return=TRUE) # Sort x and obtain the original indices
  x   <- dat$x
  weight     <- weight[dat$ix]          # Sort the weights based on the sorting of x
  n.probs    <- length(probs)
  quantiles  <- numeric(n.probs)
  cum.weight <- cumsum(weight)      # Cumulative sum of the weights
  cum.weight <- cum.weight/tail(cum.weight,n=1) # then normalized
  
  # For each quantile we want to compute
  for (i in 1:n.probs) {
    p = probs[i]
    
   
    for (j in 1:length(cum.weight)) {
      
      # Iterate through the cumulative weight until we have exceeded the desiered probability
      if (cum.weight[j] >= p) {
        
        # Then, extract the quantile
        quantiles[i] = x[j]
        break
      }
    }
  }
  return(quantiles)
}

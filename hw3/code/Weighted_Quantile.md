Code documentation
================

### Abstract

This document includes documentation of the functions constructed for the purpose.

### Table of Content

-   [Weighted Quantile](#weighted_quantile)

Weighted Quantile
-----------------

``` r
weighted.quantile <- function(x, probs=seq(0, 1 ,0.25), weight=rep(1,length(x))) {
  
  id <- sort(x, index.return=TRUE) # Sort x and obtain the original indices
  weight     <- weight[id]         # Sort the weights based on the sorting of x
  n.probs    <- length(probs)
  quantiles  <- numeric(n.probs)
  cum.weight <- cumsum(weight)     # Cumulative sum of the weights
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
```

The weighted quantile is computed with the inverse cumulative distribution method. The weights are normalized, and then considered as probabilites assigned to corresponding elements in x. The cumulative sum of the weights is computed. Then, a iterative search for the desired probability in the vector of cumulative sum of weights determines where to extract the quantile.

Note that the method is not opimized in terms of computational complexity.

regress <- function(y, x, beta = c(0, 0), alpha = 0.05) {
  
  dataset <- data.frame(y, x)
  
  # Sample Size
  n <- nrow(dataset)
  
  # Find mean of data
  meanX <- mean(dataset[, 2])
  meanY <- mean(dataset[, 1])
  
  # Calculating Beta 
  Covariance <- sum((x - meanX) * (y - meanY))
  Variance <- sum((x - meanX) ^ 2)
  
  # Calculating Estimators 
  slope <- Covariance / Variance
  intercept <- meanY - slope * meanX 
  
  # Calculate error term
  error <- rep(0, n)
  for (i in 1:n){
    error[i] <- dataset[i, 1] - intercept -  slope * dataset[i, 2]
  }
  
  # SE of Slope
  var.slope <- sum(error^2) / ((n - 2) * Variance)
  se.slope <- sqrt(var.slope)
  
  # T(X) of Slope
  T.slope <- (slope - beta[2]) / se.slope
  
  # P-value of T(X)
  p.slope <- pt(T.slope, df = n - 1, lower.tail = FALSE)
  
  # Confidence Interval for slope
  p <- alpha / 2
  level <- 1 - alpha
  
  # Bounds
  Lower <- slope - qt(p, n - 1, lower.tail = FALSE) * se.slope  
  Upper <- slope + qt(p, n - 1, lower.tail = FALSE) * se.slope 
 
  # Residuals
  minResid = min(error)
  medResid = median(error)
  maxResid = max(error)
  meanResid = mean(error)
  seResid = sd(error)

  # SE of Intercept
  var.intercept = ((seResid^2) * sum(x^2)) / (n * Variance)
  se.intercept = sqrt(var.intercept)

  # T(X) of intercept
  T.intercept = (intercept - beta[1]) / se.intercept

  # P-value of T(X)
  p.intercept <- pt(T.intercept, df = n - 1, lower.tail = FALSE)

  # Confidence Interval for intercept
  # Bounds
  Lower.int <- intercept - qt(p, n - 1, lower.tail = FALSE) * se.intercept 
  Upper.int <- intercept + qt(p, n - 1, lower.tail = FALSE) * se.intercept


  # store Output 
  Estimate <- c(intercept, slope)
  StdError <- c(se.intercept, se.slope)
  Tstat <- c(T.intercept, T.slope)
  Pvalue <- c(p.intercept, p.slope)
  LowerCI <- c(Lower.int, Lower)
  UpperCI <- c(Upper.int, Upper)

  residuals <- data.frame(minResid, medResid, maxResid, "|", meanResid, seResid, row.names = "")
  colnames(residuals) <- c("Min", "Median", "Max", "|", "Mean", "Std Error")

  summary <- data.frame(Estimate, StdError, Tstat, Pvalue, LowerCI, UpperCI, row.names = c("Intercept", "Slope"))
  colnames(summary) <- c("Estimate", "Std error", "T value", "P value", "Lower Bound", "Upper Bound")
  
  cat("Regression: \n")
  cat("Method: Ordinary Least Squares \n")
  cat("\n")
  print(summary)
  cat("\n")
  cat("Residuals: \n")
  print(residuals)
}

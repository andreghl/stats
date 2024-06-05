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

set.seed(2024)

# Sample Creation

x <- rnorm(n = 300, mean = 3, sd = sqrt(2))

y <- 3 + 2*x + rnorm(n = 300, mean = 0, sd = 1)

start <- Sys.time()
regress(y,x)
end <- Sys.time() 

regressTime <- end - start

begin <- Sys.time()
test <- lm(y ~ x)
summary(test)
finish <- Sys.time()

lmTime <- finish - begin

regressTime
lmTime

confint(test, level = 0.95)

speed <- function(n = 10) 
{

time <- rep(0, n)
timeR <- rep(0, n)
timeLM <- rep(0, n)

for (i in 1:n){

  # Sample creation
  x <- rnorm(n = 300, mean = 3, sd = sqrt(2))
  y <- 3 + 2*x + rnorm(n = 300, mean = 0, sd = 1)

  # Regress()
  startR <- Sys.time()
  regress(y, x)
  endR <- Sys.time()

  # Time Difference for regress()
  timeR[i] <- endR - startR

  # lm()
  startLM <- Sys.time()
  test <- lm(y ~ x)
  summary(test)
  confint(test, level = 0.95)
  endLM <- Sys.time()

  # Time Difference for lm()
  timeLM[i] <- endLM - startLM

  # Compare
  time[i] <- timeR[i] - timeLM[i]

  cat("Test n°: ", i, "\n")
}

output <- data.frame(timeR, timeLM, time)
colnames(output) <- c("regress()", "lm()", "Difference")

return(output)
}

test <- speed(50)

barplot(test[,3], width = 1, space = 1, 
names.arg = rownames(test), beside = TRUE,
main = "Time difference test", sub = "between regress() and lm()",
xlab = "Iteration n°", ylab = "Seconds")

mean(test[, 1])
mean(test[, 2])
mean(test[, 3])

performance <- function(n = 10, m = 1000){

time <- rep(0, n)
timeR <- rep(0, n)
timeLM <- rep(0, n)
size <- rep(0, n)

for (i in 1:n){

  j <- round(runif(1, min = 300, max = m), 0)
  
  # Sample creation
  x <- rnorm(n = j, mean = 3, sd = sqrt(2))
  y <- 3 + 2*x + rnorm(n = j, mean = 0, sd = 1)

  # Regress()
  startR <- Sys.time()
  regress(y, x)
  endR <- Sys.time()

  # Time Difference for regress()
  timeR[i] <- endR - startR

  # lm()
  startLM <- Sys.time()
  test <- lm(y ~ x)
  summary(test)
  confint(test, level = 0.95)
  endLM <- Sys.time()

  # Time Difference for lm()
  timeLM[i] <- endLM - startLM

  # Compare
  time[i] <- timeR[i] - timeLM[i]
  size[i] <- j
  
  cat("Test n°: ", i, "\n")

}

output <- data.frame(timeR, timeLM, time, size)
colnames(output) <- c("regress()", "lm()", "Difference", "Sample size")

output <- output[order(output[, 4]),]

return(output)

}

perf <- performance(1000, 100000)

plot(perf[, 4], perf[, 1], xlab = "Sample size", ylab = "Seconds",
     main = "Time difference as sample size increases", las = 1)
abline(a = 9.453547e-02 , b = 7.402285e-05, col = "red", lwd = "2")

regress(perf[,1], perf[, 4])

plot(perf[, 4], perf[, 2], xlab = "Sample size", ylab = "Seconds",
     main = "Time difference as sample size increases", las = 1)
regress(perf[,2], perf[, 4])

2.362159e-06 * 1000

write.csv(test, file = "speed.csv", row.names = T)
write.csv(perf, file = "performance.csv", row.names = T)

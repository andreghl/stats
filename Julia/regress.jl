using DataFrames, Distributions, LinearAlgebra



function pt(T, df = 300) 

   Dist = TDist(df)
   Pvalue = 1 - cdf(Dist, T)

   return Pvalue
end

function lm(y, X)

    n = size(X, 1) # Sample size
    K = size(X, 2) # Number of regressors
    
    y = values(y)
    i = ones(n)
    X = [i X]
    X = values(X)

    beta = inv(X'X)X'y # Estimated coefficients
    yHat = X * beta # Estimates for dependent
    e = y - (X * beta) # Residuals

    SSR = e'e
    s2 = SSR / (n - K)
    s = sqrt(s2)

    i = ones(n)
    yMean = inv(i'i)i'y
    T = (y .- yMean)
    TSS = T'T

    RSq = 1 - (SSR / TSS)
    Adj = 1 - (SSR / (n - K)) / (TSS / (n - 1))

    betaSE = sqrt.(diag(inv(X'X) * s2))

    Tvalue = beta ./ betaSE
    df = n - 1
    Pvalue = [pt(t, df) for t in Tvalue]

    Lower = beta .- 1.96 .* betaSE
    Upper = beta .+ 1.96 .* betaSE

    output = DataFrame(beta = beta, StdErr = betaSE, Tvalue = Tvalue, 
    Pvalue = Pvalue, LowerBound = Lower, UpperBound = Upper)

    return (output)
end
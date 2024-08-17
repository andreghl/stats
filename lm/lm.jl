using DataFrames, Distributions, LinearAlgebra

function pt(T, df = 100) 

   Dist = TDist(df)
   Pvalue = 1 - cdf(Dist, T)

   return Pvalue
end

function lm(y::Vector{Float64}, X::Matrix{Float64})

    beta = inv(X'X)X'y

    n = length(y)
    k = size(X, 2)
    e = y - (X * beta)

    s2 = e'e / (n - k)
    betaSE = sqrt.(diag(inv(X'X) * s2))
    tstat = beta ./ betaSE
    pvalue = [pt(t, n - 1) for t in tstat]

    return DataFrame(beta = beta, betaSE = betaSE, tstat = tstat, 
    pvalue = pvalue)
end




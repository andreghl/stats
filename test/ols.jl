include("../src/ols.jl")

using Distributions, Random

Random.seed!(2024)

n = 250
X = rand(Normal(0, 2), n)
u = rand(Normal(0, 1), n)
i = ones(n)
X = [i X]
beta = [5, 2]
y = (X * beta) .+ u
model = lm(y, X)

#2×4 DataFrame
# Row │ beta     betaSE     tstat    pvalue  
#     │ Float64  Float64    Float64  Float64 
#─────┼──────────────────────────────────────
#   1 │ 4.9808   0.0642877  77.4767      0.0
#   2 │ 1.96143  0.0313061  62.6535      0.0
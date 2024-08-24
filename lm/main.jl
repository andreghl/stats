include("lm.jl")

using  CSV, Distributions, HypothesisTests, Plots, Random

Random.seed!(2024)

n = 250
X = rand(Normal(0, 2), n)
u = rand(Normal(0, 1), n)
i = ones(n)
X = [i X]
beta = [5, 2]
y = (X * beta) .+ u
model = lm(y, X)


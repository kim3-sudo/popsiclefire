library(pwr)
library(pwr2)

## power test for sample size
pwr.t.test(d = 1, sig.level = 0.05, power = 0.9, type = "two.sample", alternative = "two.sided")

## 1 way power for each factor, then take the larger one
ss.1way(k = 4, alpha = 0.05, beta = 0.1, f = 1, B = 100) # Liquids
ss.1way(k = 6, alpha = 0.05, beta = 0.1, f = 1, B = 100) # Trial run
# Let's use total sample of 24, since it's the larger n*k

## 2 way power
ss.2way(a = 4, b = 10, alpha = .05, beta = .1, f.A = 0.2, f.B = 0, B = 100)

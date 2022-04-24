# power.R
# E. Croffoot-Suede, S. Kim
# Popsicle Fire
# Power calculations for determining adequate sample size

library(pwr)
library(pwr2)

## 1 way power for each factor, then take the larger one
ss.1way(k = 4, alpha = 0.05, beta = 0.1, f = 1, B = 100) # Liquids
ss.1way(k = 6, alpha = 0.05, beta = 0.1, f = 1, B = 100) # Trial run
# Let's use total sample of 24, since it's the larger n*k


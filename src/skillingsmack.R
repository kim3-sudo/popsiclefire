# anova.R
# E. Croffoot-Suede, S. Kim
# Popsicle Fire
# ANOVA

fire <- read.csv(url("https://raw.githubusercontent.com/kim3-sudo/popsiclefire/main/data/data_filled.csv"))

# Check conditions
plot(aov(distance ~ type * run, data = fire), which = 1:2) # only to get residual plots
plot(aov(distance ~ type * run, data = fire), which = 1:2) # only to get residual plots

# Check full model ANOVA
fire.mod.full <- aov(distance ~ type * run, data = fire)
fire.mod.null <- aov(distance ~ 1, data = fire)
anova(fire.mod.null, fire.mod.full)
plot(fire.mod.full, which = 1:2)

# Friedman's test!
library(NSM3)
pSkilMack(fire$distance, b = as.factor(fire$run), trt = fire$type)

# for shits n giggles
kruskal.test(fire$distance, fire$type)
pSDCFlig(fire$distance, g = as.factor(fire$type))


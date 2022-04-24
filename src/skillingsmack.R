# anova.R
# E. Croffoot-Suede, S. Kim
# Popsicle Fire
# Skillings-Mack procedure

fire <- read.csv(url("https://raw.githubusercontent.com/kim3-sudo/popsiclefire/main/data/data_filled.csv"))

# Check conditions
plot(aov(distance ~ type * run, data = fire), which = 1:2) # only to get residual plots
plot(aov(distance ~ type * run, data = fire), which = 1:2) # only to get residual plots

# Skillings-Mack's test!
# This is an distribution-free test for general alternatives for data from an arbitrary incomplete block design (Hollander - Nonparametric Statistical Methods, 3ed, p. 343)
library(NSM3)
pSkilMack(fire$distance, b = as.factor(fire$run), trt = fire$type)
# A significant p-value here means there is some strong evidence to support the hypothesis that the accelerant used does influence the length of burnt popsicle stick.
# This does NOT tell us which of the accelerants works the best, only that at least one of them works better than the others.


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
pSkilMack(fire$distance, b = as.factor(fire$run), trt = fire$type, method = "Asymptotic")
# A significant p-value here means there is some strong evidence to support the hypothesis that the accelerant used does influence the length of burnt popsicle stick.
# This does NOT tell us which of the accelerants works the best, only that at least one of them works better than the others.

# Make a vector of ordered accelerants
accelerants <- c()
for (i in 1:6) {
  accelerants <- append(accelerants, "dry")
  accelerants <- append(accelerants, "ethanol")
  accelerants <- append(accelerants, "isopropyl")
  accelerants <- append(accelerants, "acetone")
}

# Get vectors for run and distance from the original dataset
run <- fire$run
distance <- fire$distance

# "Hartlaub-Leatherman" Pairwise Multiple Comparisons Procedure for Data from an Arbitrary Incomplete Block Design
# Make a vector for each of the pairwise comparisons
sim.accelerant <- c()
sim.eth.dry <- c()
sim.eth.ace <- c()
sim.eth.iso <- c()
sim.ace.dry <- c()
sim.ace.iso <- c()
sim.iso.dry <- c()
for (i in 0:1000) {
  rand.df <- data.frame(run, sample(accelerants), distance)
  colnames(rand.df) <- c("run", "accelerant", "distance")
  
  sim.accelerant <- append(sim.accelerant, pSkilMack(rand.df$distance, b = as.factor(rand.df$run), trt = rand.df$accelerant, method = "Asymptotic")[['obs.stat']])
  sim.eth.dry <- c(sim.eth.dry, wilcox.test(distance ~ accelerant, data = subset(rand.df, accelerant == 'ethanol' | accelerant == 'dry'))[['statistic']])
  sim.eth.ace <- c(sim.eth.ace, wilcox.test(distance ~ accelerant, data = subset(rand.df, accelerant == 'ethanol' | accelerant == 'acetone'))[['statistic']])
  sim.eth.iso <- c(sim.eth.iso, wilcox.test(distance ~ accelerant, data = subset(rand.df, accelerant == 'ethanol' | accelerant == 'isopropyl'))[['statistic']])
  sim.ace.dry <- c(sim.ace.dry, wilcox.test(distance ~ accelerant, data = subset(rand.df, accelerant == 'acetone' | accelerant == 'dry'))[['statistic']])
  sim.ace.iso <- c(sim.ace.iso, wilcox.test(distance ~ accelerant, data = subset(rand.df, accelerant == 'acetone' | accelerant == 'isopropyl'))[['statistic']])
  sim.iso.dry <- c(sim.iso.dry, wilcox.test(distance ~ accelerant, data = subset(rand.df, accelerant == 'isopropyl' | accelerant == 'dry'))[['statistic']])
}
differences <- data.frame(sim.eth.dry, sim.eth.ace, sim.eth.iso, sim.ace.dry, sim.ace.iso, sim.iso.dry)
boxplot(differences, xlab="Simulated Pairwise Comparisons", ylab="Mann-Whitney U Statistic", 
        main="Collected Test Statistic from 1000 Simulated Pairwise Comparisons")

# Compare randomized accelerant (treatment) Mann-Whitney-Wilcoxon tests against pairwise comparisons from the actual dataset
actual.wilcox <- c()
actual.wilcox <- append(actual.wilcox, wilcox.test(distance ~ type, data = subset(fire, type == 'ethanol' | type == 'dry'))[['statistic']])
actual.wilcox <- append(actual.wilcox, wilcox.test(distance ~ type, data = subset(fire, type == 'ethanol' | type == 'acetone'))[['statistic']])
actual.wilcox <- append(actual.wilcox, wilcox.test(distance ~ type, data = subset(fire, type == 'ethanol' | type == 'isopropyl'))[['statistic']])
actual.wilcox <- append(actual.wilcox, wilcox.test(distance ~ type, data = subset(fire, type == 'acetone' | type == 'dry'))[['statistic']])
actual.wilcox <- append(actual.wilcox, wilcox.test(distance ~ type, data = subset(fire, type == 'acetone' | type == 'isopropyl'))[['statistic']])
actual.wilcox <- append(actual.wilcox, wilcox.test(distance ~ type, data = subset(fire, type == 'isopropyl' | type == 'dry'))[['statistic']])

# Comparison Matrix
sim.wilcox <- c()
sim.wilcox <- append(sim.wilcox, median(differences$sim.eth.dry))
sim.wilcox <- append(sim.wilcox, median(differences$sim.eth.ace))
sim.wilcox <- append(sim.wilcox, median(differences$sim.eth.iso))
sim.wilcox <- append(sim.wilcox, median(differences$sim.ace.dry))
sim.wilcox <- append(sim.wilcox, median(differences$sim.ace.iso))
sim.wilcox <- append(sim.wilcox, median(differences$sim.iso.dry))
comparisons <- c("Ethanol-Dry", "Ethanol-Acetone", "Ethanol-Isopropyl", "Acetone-Dry", "Acetone-Isopropyl", "Isopropyl-Dry")
percentile.05 <- c()
percentile.05 <- append(percentile.05, quantile(differences$sim.eth.dry, .05))
percentile.05 <- append(percentile.05, quantile(differences$sim.eth.ace, .05))
percentile.05 <- append(percentile.05, quantile(differences$sim.eth.iso, .05))
percentile.05 <- append(percentile.05, quantile(differences$sim.ace.dry, .05))
percentile.05 <- append(percentile.05, quantile(differences$sim.ace.dry, .05))
percentile.05 <- append(percentile.05, quantile(differences$sim.iso.dry, .05))

percentile.95 <- c()
percentile.95 <- append(percentile.95, quantile(differences$sim.eth.dry, .95))
percentile.95 <- append(percentile.95, quantile(differences$sim.eth.ace, .95))
percentile.95 <- append(percentile.95, quantile(differences$sim.eth.iso, .95))
percentile.95 <- append(percentile.95, quantile(differences$sim.ace.dry, .95))
percentile.95 <- append(percentile.95, quantile(differences$sim.ace.dry, .95))
percentile.95 <- append(percentile.95, quantile(differences$sim.iso.dry, .95))

comparison <- data.frame(comparisons, actual.wilcox, sim.wilcox, percentile.05, percentile.95)
comparison

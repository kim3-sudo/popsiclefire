# eda.R
# E. Croffoot-Suede, S. Kim
# Popsicle Fire
# Exploratory data analysis

fire <- read.csv(url("https://raw.githubusercontent.com/kim3-sudo/popsiclefire/main/data/data_filled.csv"))

boxplot(fire$distance)

boxplot(distance ~ type, data = fire)

interaction.plot(fire$type, fire$run, fire$distance)
interaction.plot(fire$run, fire$type, fire$distance)

# eda.R
# E. Croffoot-Suede, S. Kim
# Popsicle Fire
# Exploratory data analysis

fire <- read.csv(url("https://raw.githubusercontent.com/kim3-sudo/popsiclefire/main/data/data_filled.csv"))

boxplot(fire$distance, ylab="Distance (mm)", main="Distance Unburnt")

boxplot(distance ~ type, data = fire, ylab="Disrance (mm)", 
        xlab="Accelerant", main="Unburnt Distance by Accelerant")
boxplot(distance ~ run, data = fire, ylab="Distance (mm)", 
        xlab="Block", main="Unburnt Distance by Block")

interaction.plot(fire$type, fire$run, fire$distance, ylab="Mean Distance (mm)", 
                 xlab="Accelerant", main="Interaction Plot")
interaction.plot(fire$run, fire$type, fire$distance, ylab="Mean Distance (mm)", 
                 xlab="Accelerant", main="Interaction Plot")

# regen.py
# E. Croffoot-Suede, S. Kim
# Popsicle Fire
# Regenerate empty data file

# To run this file, run the command `python3 regen.py` (or use the alias for Python in your terminal - on Windows, it's `py`) from the src directory.
# Alternatively, you can use a Python IDE to run the file.

import random
import pandas as pd

# First acknowledgement and confirmation
print("This script will erase the existing data file and regenerate a new data file in ../data To preserve the old data file, you should rename it to something other than `data.csv`.")
ack1 = input("Do you wish to continue? (y/N)\n>>> ").lower()
if ack1 != 'y':
    raise Exception("No changes made. Exiting now.")
# Give user option to explicitly set a seed.
# The seed must be an integer, otherwise a TypeError will be thrown and execution is terminated
try:
    seed = input("To set an explicit seed, enter it here. Otherwise, the default seed will be used (based on system time).\n>>> ")
    if isinstance(seed, int) and seed != '':
        raise TypeError("Not an integer seed. Exiting now.")
    elif seed != '':
        random.seed = int(seed)
    else:
        pass
except Exception as e:
    raise Exception(e)
# Create empty Pandas dataframe object
df = pd.DataFrame()
# Get the order of runs
temp = []
for i in range(1, 7):
    for j in range(4):
        temp.append(i)
df["run"] = temp
# Create a list for types of runs (ordered) and results (Nonetypes)
temp = []
nonelist = []
for i in range(6):
    temp.append("dry")
    temp.append("isopropyl")
    temp.append("acetone")
    temp.append("ethanol")
    for i in range(4):
        nonelist.append(None)
# Randomize order of types of runs
# Add randomized order and nonelist to dataframe
df["type"] = random.sample(temp, 24)
df["time"] = nonelist
# Second confirmation
print("A new, empty dataframe has been generated. Continuing will overwrite any file called `data.csv` in the data directory.")
ack2 = input("To continue, type `data.csv` to confirm the write/overwrite operation.\n>>> ")
if ack2 != 'data.csv':
    raise Exception("No changes made. Exiting now.")
# Write out the data to a data.csv file
else:
    try:
        df.to_csv("./data/data.csv")
        print(f'Data preview: {str(df.to_csv)[:50]}')
        print("Data file write successful.")
    except Exception as e:
        raise Exception(e)
# regen.py
# E. Croffoot-Suede, S. Kim
# Popsicle Fire
# Regenerate empty data file

import random
import pandas as pd

print("This script will erase the existing data file and regenerate a new data file in ../data To preserve the old data file, you should rename it to something other than `data.csv`.")
ack1 = input("Do you wish to continue? (y/N)\n>>> ").lower()
if ack1 != 'y':
    raise Exception("No changes made. Exiting now.")
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
df = pd.DataFrame()
temp = []
for i in range(1, 7):
    for j in range(4):
        temp.append(i)
df["run"] = temp
#df["run"] = random.sample(temp, 24)
#df["run"] = random.sample(list(range(1,25)), 24)
temp = []
nonelist = []
for i in range(6):
    temp.append("dry")
    temp.append("isopropyl")
    temp.append("acetone")
    temp.append("ethanol")
    for i in range(4):
        nonelist.append(None)
df["type"] = random.sample(temp, 24)
df["time"] = nonelist
print("A new, empty dataframe has been generated. Continuing will overwrite any file called `data.csv` in the data directory.")
ack2 = input("To continue, type `data.csv` to confirm the write/overwrite operation.\n>>> ")
if ack2 != 'data.csv':
    raise Exception("No changes made. Exiting now.")
else:
    try:
        df.to_csv("./data/data.csv")
        print(f'Data preview: {str(df.to_csv)[:50]}')
        print("Data file write successful.")
    except Exception as e:
        raise Exception(e)
# Data

## Get the data

Use `data_filled.csv` in R by using the line:

```R
fire <- read.csv(url("https://raw.githubusercontent.com/kim3-sudo/popsiclefire/main/data/data_filled.csv"))
```

## Columns

| **Column** | **Description**                                                                                  |
|------------|--------------------------------------------------------------------------------------------------|
| `run`      | The block ID                                                                                     |
| `type`     | The type of accelerant from `c('isopropyl', 'acetone', 'ethanol', 'dry)`                         |
| `distance` | Distance from the unburnt end of the stick to the furthest burn mark on the stick in millimeters |

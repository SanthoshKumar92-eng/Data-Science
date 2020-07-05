# LOAD DATA AND PACKAGE ----
install.packages("dplyr")
library(dplyr)
data(mtcars)
mtcars

# DPLYR "VERBS": select, filter, arrange, mutate, summarise, group_by
## SELECT ----
select(mtcars, mpg)
select(mtcars, mpg, disp, gear)
select(mtcars, 1:7)

## FILTER ----
filter(mtcars, wt > 3.5)
filter(mtcars, wt > 3.5, carb == 4)

## ARRANGE ----
arrange(mtcars, gear)
arrange(mtcars, -gear)
arrange(mtcars, -gear, -carb, wt)

## MUTATE ----
mutate(mtcars, wt_cyl = wt / cyl)
mutate(mtcars, wt_cyl = wt / cyl, inverse_wt_cyl = 1 / (wt / cyl))
mtcars # new columns are not saved to the new dataset

## SUMMARISE ----
summarise(mtcars, min_hp = min(hp), avg_hp = mean(hp), max_hp = max(hp),
          med_hp = median(hp), IQR_hp = IQR(hp))
summary(mtcars) # why not use summary()?

## GROUP_BY ----
grouped <- group_by(mtcars, gear)
summarise(grouped, min_hp = min(hp), avg_hp = mean(hp), max_hp = max(hp),
          med_hp = median(hp), IQR_hp = IQR(hp))

grouped2 <- group_by(mtcars, gear, cyl)
summarise(grouped2, min_hp = min(hp), avg_hp = mean(hp), max_hp = max(hp),
          med_hp = median(hp), IQR_hp = IQR(hp))

## THE PIPE OPERATOR %>% ----
mtcars %>% group_by(gear) %>% summarise(median_wt = median(wt))

subsetCars <- mtcars %>%
  select(2:11) %>%
  filter(wt >= 2)
subsetCars

arrangedCars <- subsetCars %>%
  group_by(gear, cyl) %>%
  mutate(wt_cyl = wt / cyl) %>%
  arrange(wt_cyl) 
arrangedCars

arrangedCars %>%
  summarise(sd(wt_cyl))

# LOTS MORE TO DO BUT THESE ARE THE MAIN VERBS

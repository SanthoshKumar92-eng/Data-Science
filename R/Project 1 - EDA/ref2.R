
3 Exploratory Data Analysis
3.1 Browsing the Dataset
library(DT)

datatable(data = cereals_data, 
          rownames = FALSE, 
          filter = "top",
          options = list(autoWidth = TRUE))
Show  entriesSearch:
  Name	Manufacturer	Type	Calories	Protein	Fat	Sodium	Fibre	Carbohydrates	Sugar	Potassium	Vitamins	Shelf	Weight	Cups	Rating	Manufacturer_Name
All
All
All
100% Bran	N	Cold	70	4	1	130	10	5	6	280	25	3	1	0.33	68.402973	Nabisco
100% Natural Bran	Q	Cold	120	3	5	15	2	8	8	135	0	3	1	1	33.983679	Quaker Oats
All-Bran	K	Cold	70	4	1	260	9	7	5	320	25	3	1	0.33	59.425505	Kellogs
All-Bran with Extra Fiber	K	Cold	50	4	0	140	14	8	0	330	25	3	1	0.5	93.704912	Kellogs
Almond Delight	R	Cold	110	2	2	200	1	14	8		25	3	1	0.75	34.384843	Ralston Purina
Apple Cinnamon Cheerios	G	Cold	110	2	2	180	1.5	10.5	10	70	25	1	1	0.75	29.509541	General Mills
Apple Jacks	K	Cold	110	2	0	125	1	11	14	30	25	2	1	1	33.174094	Kellogs
Basic 4	G	Cold	130	3	2	210	2	18	8	100	25	3	1.33	0.75	37.038562	General Mills
Bran Chex	R	Cold	90	2	1	200	4	15	6	125	25	1	1	0.67	49.120253	Ralston Purina
Bran Flakes	P	Cold	90	3	0	210	5	13	5	190	25	3	1	0.67	53.313813	Post
Showing 1 to 10 of 77 entries
Previous12345.8Next
3.2 Manufacturers
library(tidyverse)

Manufacturers_Total <- cereals_data %>% 
  select(Manufacturer_Name, Type) %>% 
  group_by(Manufacturer_Name, Type) %>% 
  summarise(Total = n()) %>% 
  spread(key = Type, value = Total) %>%
  replace_na(replace = list(Manufacturer_Name = 0, Cold = 0, Hot = 0)) %>% 
  mutate(Total = Cold + Hot) %>% 
  arrange(desc(Total))
Manufacturers_Total
## # A tibble: 7 x 4
## # Groups:   Manufacturer_Name [7]
##   Manufacturer_Name            Cold   Hot Total
##   <chr>                       <dbl> <dbl> <dbl>
## 1 Kellogs                     23.0   0    23.0 
## 2 General Mills               22.0   0    22.0 
## 3 Post                         9.00  0     9.00
## 4 Quaker Oats                  7.00  1.00  8.00
## 5 Ralston Purina               8.00  0     8.00
## 6 Nabisco                      5.00  1.00  6.00
## 7 American Home Food Products  0     1.00  1.00
ggplot(cereals_data, aes(x = factor(Manufacturer_Name, levels = rev(Manufacturers_Total$Manufacturer_Name)), fill = Type)) +
  geom_bar() +
  coord_flip(expand = FALSE) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  scale_x_discrete(name = "Manufacturer") +
  scale_y_continuous(name = "Count", minor_breaks = NULL) + 
  theme_minimal() +
  labs(title = "Number of Products by Manufacturer")


3.3 Nutritionals
3.3.1 Portion Sizes
cereals_data %>% 
  ggplot(aes(x = Weight, fill = Manufacturer_Name)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Weight (in ounces)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 70)) +
  labs(fill = "Manufacturer", title = "Distribution of Weight per Serving", subtitle = "Manufacturers use different weights for servings") +
  theme_minimal()


cereals_data %>% 
  ggplot(aes(x = Weight*28.3495, fill = Manufacturer_Name)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Weight (g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 70)) +
  labs(fill = "Manufacturer", title = "Distribution of Weight per Serving", subtitle = "Manufacturers use different weights for servings") +
  theme_minimal()


cereals_data %>% 
  ggplot(aes(x = Cups, fill = Manufacturer_Name)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Number of cups in one serving", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 35)) +
  labs(fill = "Manufacturer", title = "Distribution of Number of Cups per Serving", subtitle = "Different products have different cup sizes") +
  theme_minimal()



glimpse(cereals_data)

summary(cereals_data)
 
## 
3.3.3 Scatterplot Matrix
# Scatter Plot Matrix

# install.packages("GGally")
library(GGally)

# Create function to add regression line to scatter plot matrix
sm_regression <- function(data, mapping, ...){
  p <- ggplot(data = data, mapping = mapping) + 
    geom_point(alpha = 0.4) + 
    geom_smooth(method=lm, fill="grey10", color="grey10", ...)
  p
}

cereals_data %>% 
  select(Manufacturer_Name, Calories_100g, Protein, Fat, Sodium, Fibre, Carbohydrates, Sugar, Potassium, Shelf, Rating) %>% 
  ggpairs(columns = 2:11, lower = list(continuous = sm_regression)) +
  theme_bw()


3.3.4 Correlation Matrix
cereals_data %>% 
  select(Calories = Calories_100g, Protein, Fat, Sodium, Fibre, Carbs = Carbohydrates, Sugar, Potassium, Shelf, Rating) %>% 
  ggcorr(palette = "RdBu", label = TRUE, label_round =  2)

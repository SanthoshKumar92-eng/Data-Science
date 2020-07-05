#### Distribution of Calorie Content


cereals_data %>% 
  ggplot(aes(x = Manufacturer_Name, y = Calories_100g_calculated, fill = Manufacturer_Name)) +
  geom_boxplot(show.legend = FALSE) +
  stat_summary(fun.y = mean, geom = "point", pch = 1, show.legend = FALSE) + # Add average to the boxplot
  scale_y_continuous(name = "Calories (g per 100g)", minor_breaks = NULL) +
  scale_fill_brewer(palette = "Set1") +
  coord_flip() + 
  theme_minimal() +
  labs(x = "Manufacturer") +
  ggtitle(label = "Distribution of Calorie Content by Manufacturer")

```


```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Calories_100g_calculated)) +
  geom_density(fill = "grey", alpha = 0.8, adjust = 3, linetype = 0) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Calories (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Proportion", expand = c(0,0)) +
  labs(fill = "Manufacturer", title = "Distribution of Calories in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Calories_100g_calculated, fill = Manufacturer_Name)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Calories (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 10), breaks = seq(0, 10, 2)) +
  labs(fill = "Manufacturer", title = "Distribution of Calories in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Calories_100g_calculated, fill = Type)) +
  geom_histogram() +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  scale_x_continuous(name = "Calories (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 10), breaks = seq(0, 10, 2)) +
  labs(fill = "Manufacturer", title = "Distribution of Calories in Breakfast Cereals") +
  theme_minimal()

```

### Fat

#### Summary of Fat Content

```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  select(Name, Manufacturer_Name, Type, Fat, Fat_oz, Fat_100g) %>% 
  datatable(rownames = NULL, filter = "top", colnames = c("Product", "Manufacturer", "Type", "Fat (g per serving)", "Fat (g per ounce)", "Fat (g per 100g)"))

```

```{r warning=FALSE, message=FALSE}
# Summary Table of Fat per 100g
cereals_data %>% 
  select(Manufacturer_Name, Fat_100g, Type) %>% 
  group_by(Manufacturer_Name) %>% 
  summarise(Average = round(mean(Fat_100g, na.rm = TRUE), 1),
            Median = round(median(Fat_100g, na.rm = TRUE), 1),
            Lowest = min(Fat_100g, na.rm = TRUE),
            Highest = max(Fat_100g, na.rm = TRUE),
            Count = n())
```

#### Distribution of Fat Content

```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Manufacturer_Name, y = Fat_100g, fill = Manufacturer_Name)) +
  geom_boxplot(show.legend = FALSE) +
  stat_summary(fun.y = mean, geom = "point", pch = 1, show.legend = FALSE) + # Add average to the boxplot
  scale_y_continuous(name = "Fat (g per 100g)", minor_breaks = NULL) +
  scale_fill_brewer(palette = "Set1") +
  coord_flip() + 
  theme_minimal() +
  labs(x = "Manufacturer") +
  ggtitle(label = "Distribution of Fat Content by Manufacturer")

```


```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Fat_100g)) +
  geom_density(fill = "grey", alpha = 0.8, linetype = 0) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Fat (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Proportion", expand = c(0,0)) +
  labs(fill = "Manufacturer", title = "Distribution of Fat in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Fat_100g, fill = Manufacturer_Name)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Fat (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Manufacturer", title = "Distribution of Fat in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Fat_100g, fill = Type)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  scale_x_continuous(name = "Fat (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Type", title = "Distribution of Fat in Breakfast Cereals") +
  theme_minimal()

```


### Protein

#### Summary of Protein Content

```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  select(Name, Manufacturer_Name, Type, Protein, Protein_oz, Protein_100g) %>% 
  datatable(rownames = NULL, filter = "top", colnames = c("Product", "Manufacturer", "Type", "Protein (g per serving)", "Protein (g per ounce)", "Protein (g per 100g)"))

```

```{r warning=FALSE, message=FALSE}
# Summary Table of Protein per 100g
cereals_data %>% 
  select(Manufacturer_Name, Protein_100g, Type) %>% 
  group_by(Manufacturer_Name) %>% 
  summarise(Average = round(mean(Protein_100g, na.rm = TRUE), 1),
            Median = round(median(Protein_100g, na.rm = TRUE), 1),
            Lowest = min(Protein_100g, na.rm = TRUE),
            Highest = max(Protein_100g, na.rm = TRUE),
            Count = n())
```

#### Distribution of Protein Content


```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Manufacturer_Name, y = Protein_100g, fill = Manufacturer_Name)) +
  geom_boxplot(show.legend = FALSE) +
  stat_summary(fun.y = mean, geom = "point", pch = 1, show.legend = FALSE) + # Add average to the boxplot
  scale_y_continuous(name = "Protein (g per 100g)", minor_breaks = NULL) +
  scale_fill_brewer(palette = "Set1") +
  coord_flip() + 
  theme_minimal() +
  labs(x = "Manufacturer") +
  ggtitle(label = "Distribution of Protein Content by Manufacturer")

```


```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Protein_100g)) +
  geom_density(fill = "grey", alpha = 0.8, linetype = 0) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Protein (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Proportion", expand = c(0,0)) +
  labs(fill = "Manufacturer", title = "Distribution of Protein in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Protein_100g, fill = Manufacturer_Name)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Protein (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Manufacturer", title = "Distribution of Protein in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Protein_100g, fill = Type)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  scale_x_continuous(name = "Protein (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Type", title = "Distribution of Protein in Breakfast Cereals") +
  theme_minimal()

```



### Carbohydrates

#### Summary of Carbohydrates Content

```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  select(Name, Manufacturer_Name, Type, Carbohydrates, Carbohydrates_oz, Carbohydrates_100g) %>% 
  datatable(rownames = NULL, filter = "top", colnames = c("Product", "Manufacturer", "Type", "Carbohydrates (g per serving)", "Carbohydrates (g per ounce)", "Carbohydrates (g per 100g)"))

```

```{r warning=FALSE, message=FALSE}
# Summary Table of Carbohydrates per 100g
cereals_data %>% 
  select(Manufacturer_Name, Carbohydrates_100g, Type) %>% 
  group_by(Manufacturer_Name) %>% 
  summarise(Average = round(mean(Carbohydrates_100g, na.rm = TRUE), 1),
            Median = round(median(Carbohydrates_100g, na.rm = TRUE), 1),
            Lowest = min(Carbohydrates_100g, na.rm = TRUE),
            Highest = max(Carbohydrates_100g, na.rm = TRUE),
            Count = n())
```

#### Distribution of Carbohydrates Content


```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Manufacturer_Name, y = Carbohydrates_100g, fill = Manufacturer_Name)) +
  geom_boxplot(show.legend = FALSE) +
  stat_summary(fun.y = mean, geom = "point", pch = 1, show.legend = FALSE) + # Add average to the boxplot
  scale_y_continuous(name = "Carbohydrates (g per 100g)", minor_breaks = NULL) +
  scale_fill_brewer(palette = "Set1") +
  coord_flip() + 
  theme_minimal() +
  labs(x = "Manufacturer") +
  ggtitle(label = "Distribution of Carbohydrates Content by Manufacturer")

```


```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Carbohydrates_100g)) +
  geom_density(fill = "grey", alpha = 0.8, linetype = 0) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Carbohydrates (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Proportion", expand = c(0,0)) +
  labs(fill = "Manufacturer", title = "Distribution of Carbohydrates in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Carbohydrates_100g, fill = Manufacturer_Name)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Carbohydrates (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Manufacturer", title = "Distribution of Carbohydrates in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Carbohydrates_100g, fill = Type)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  scale_x_continuous(name = "Carbohydrates (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Type", title = "Distribution of Carbohydrates in Breakfast Cereals") +
  theme_minimal()

```

### Sugar

#### Summary of Sugar Content

```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  select(Name, Manufacturer_Name, Type, Sugar, Sugar_oz, Sugar_100g) %>% 
  datatable(rownames = NULL, filter = "top", colnames = c("Product", "Manufacturer", "Type", "Sugar (g per serving)", "Sugar (g per ounce)", "Sugar (g per 100g)"))

```

```{r warning=FALSE, message=FALSE}
# Summary Table of Sugar per 100g
cereals_data %>% 
  select(Manufacturer_Name, Sugar_100g, Type) %>% 
  group_by(Manufacturer_Name) %>% 
  summarise(Average = round(mean(Sugar_100g, na.rm = TRUE), 1),
            Median = round(median(Sugar_100g, na.rm = TRUE), 1),
            Lowest = min(Sugar_100g, na.rm = TRUE),
            Highest = max(Sugar_100g, na.rm = TRUE),
            Count = n())
```

#### Distribution of Sugar Content


```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Manufacturer_Name, y = Sugar_100g, fill = Manufacturer_Name)) +
  geom_boxplot(show.legend = FALSE) +
  stat_summary(fun.y = mean, geom = "point", pch = 1, show.legend = FALSE) + # Add average to the boxplot
  scale_y_continuous(name = "Sugar (g per 100g)", minor_breaks = NULL) +
  scale_fill_brewer(palette = "Set1") +
  coord_flip() + 
  theme_minimal() +
  labs(x = "Manufacturer") +
  ggtitle(label = "Distribution of Sugar Content by Manufacturer")

```


```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Sugar_100g)) +
  geom_density(fill = "grey", alpha = 0.8, linetype = 0) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Sugar (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Proportion", expand = c(0,0)) +
  labs(fill = "Manufacturer", title = "Distribution of Sugar in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Sugar_100g, fill = Manufacturer_Name)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Sugar (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Manufacturer", title = "Distribution of Sugar in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Sugar_100g, fill = Type)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  scale_x_continuous(name = "Sugar (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Type", title = "Distribution of Sugar in Breakfast Cereals") +
  theme_minimal()

```

### Fibre

#### Summary of Fibre Content

```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  select(Name, Manufacturer_Name, Type, Fibre, Fibre_oz, Fibre_100g) %>% 
  datatable(rownames = NULL, filter = "top", colnames = c("Product", "Manufacturer", "Type", "Fibre (g per serving)", "Fibre (g per ounce)", "Fibre (g per 100g)"))

```

```{r warning=FALSE, message=FALSE}
# Summary Table of Fibre per 100g
cereals_data %>% 
  select(Manufacturer_Name, Fibre_100g, Type) %>% 
  group_by(Manufacturer_Name) %>% 
  summarise(Average = round(mean(Fibre_100g, na.rm = TRUE), 1),
            Median = round(median(Fibre_100g, na.rm = TRUE), 1),
            Lowest = min(Fibre_100g, na.rm = TRUE),
            Highest = max(Fibre_100g, na.rm = TRUE),
            Count = n())
```

#### Distribution of Fibre Content

```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Manufacturer_Name, y = Fibre_100g, fill = Manufacturer_Name)) +
  geom_boxplot(show.legend = FALSE) +
  stat_summary(fun.y = mean, geom = "point", pch = 1, show.legend = FALSE) + # Add average to the boxplot
  scale_y_continuous(name = "Fibre (g per 100g)", minor_breaks = NULL) +
  scale_fill_brewer(palette = "Set1") +
  coord_flip() + 
  theme_minimal() +
  labs(x = "Manufacturer") +
  ggtitle(label = "Distribution of Fibre Content by Manufacturer")

```


```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Fibre_100g)) +
  geom_density(fill = "grey", alpha = 0.8, linetype = 0) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Fibre (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Proportion", expand = c(0,0)) +
  labs(fill = "Manufacturer", title = "Distribution of Fibre in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Fibre_100g, fill = Manufacturer_Name)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Fibre (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Manufacturer", title = "Distribution of Fibre in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Fibre_100g, fill = Type)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  scale_x_continuous(name = "Fibre (g per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Type", title = "Distribution of Fibre in Breakfast Cereals") +
  theme_minimal()

```


### Sodium

#### Summary of Sodium Content

```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  select(Name, Manufacturer_Name, Type, Sodium, Sodium_oz, Sodium_100g) %>% 
  datatable(rownames = NULL, filter = "top", colnames = c("Product", "Manufacturer", "Type", "Sodium (mg per serving)", "Sodium (mg per ounce)", "Sodium (mg per 100g)"))

```

```{r warning=FALSE, message=FALSE}
# Summary Table of Sodium per 100g
cereals_data %>% 
  select(Manufacturer_Name, Sodium_100g, Type) %>% 
  group_by(Manufacturer_Name) %>% 
  summarise(Average = round(mean(Sodium_100g, na.rm = TRUE), 1),
            Median = round(median(Sodium_100g, na.rm = TRUE), 1),
            Lowest = min(Sodium_100g, na.rm = TRUE),
            Highest = max(Sodium_100g, na.rm = TRUE),
            Count = n())
```

#### Distribution of Sodium Content

```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Manufacturer_Name, y = Sodium_100g, fill = Manufacturer_Name)) +
  geom_boxplot(show.legend = FALSE) +
  stat_summary(fun.y = mean, geom = "point", pch = 1, show.legend = FALSE) + # Add average to the boxplot
  scale_y_continuous(name = "Sodium (mg per 100g)", minor_breaks = NULL) +
  scale_fill_brewer(palette = "Set1") +
  coord_flip() + 
  theme_minimal() +
  labs(x = "Manufacturer") +
  ggtitle(label = "Distribution of Sodium Content by Manufacturer")

```


```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Sodium_100g)) +
  geom_density(fill = "grey", alpha = 0.8, linetype = 0) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Sodium (mg per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Proportion", expand = c(0,0)) +
  labs(fill = "Manufacturer", title = "Distribution of Sodium in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Sodium_100g, fill = Manufacturer_Name)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Sodium (mg per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Manufacturer", title = "Distribution of Sodium in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Sodium_100g, fill = Type)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  scale_x_continuous(name = "Sodium (mg per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Type", title = "Distribution of Sodium in Breakfast Cereals") +
  theme_minimal()

```

### Potassium

#### Summary of Potassium Content

```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  select(Name, Manufacturer_Name, Type, Potassium, Potassium_oz, Potassium_100g) %>% 
  datatable(rownames = NULL, filter = "top", colnames = c("Product", "Manufacturer", "Type", "Potassium (mg per serving)", "Potassium (mg per ounce)", "Potassium (mg per 100g)"))

```

```{r warning=FALSE, message=FALSE}
# Summary Table of Potassium per 100g
cereals_data %>% 
  select(Manufacturer_Name, Potassium_100g, Type) %>% 
  group_by(Manufacturer_Name) %>% 
  summarise(Average = round(mean(Potassium_100g, na.rm = TRUE), 1),
            Median = round(median(Potassium_100g, na.rm = TRUE), 1),
            Lowest = min(Potassium_100g, na.rm = TRUE),
            Highest = max(Potassium_100g, na.rm = TRUE),
            Count = n())
```

#### Distribution of Potassium Content


```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Manufacturer_Name, y = Potassium_100g, fill = Manufacturer_Name)) +
  geom_boxplot(show.legend = FALSE) +
  stat_summary(fun.y = mean, geom = "point", pch = 1, show.legend = FALSE) + # Add average to the boxplot
  scale_y_continuous(name = "Potassium (mg per 100g)", minor_breaks = NULL) +
  scale_fill_brewer(palette = "Set1") +
  coord_flip() + 
  theme_minimal() +
  labs(x = "Manufacturer") +
  ggtitle(label = "Distribution of Potassium Content by Manufacturer")

```


```{r warning=FALSE, message=FALSE}
cereals_data %>% 
  ggplot(aes(x = Potassium_100g)) +
  geom_density(fill = "grey", alpha = 0.8, linetype = 0) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Potassium (mg per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Proportion", expand = c(0,0)) +
  labs(fill = "Manufacturer", title = "Distribution of Potassium in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Potassium_100g, fill = Manufacturer_Name)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = "Potassium (mg per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Manufacturer", title = "Distribution of Potassium in Breakfast Cereals") +
  theme_minimal()

cereals_data %>% 
  ggplot(aes(x = Potassium_100g, fill = Type)) +
  geom_histogram(alpha = 0.8, bins = 8) +
  scale_fill_brewer(palette = "Set1", direction = -1) +
  scale_x_continuous(name = "Potassium (mg per 100g)", expand = c(0,0)) +
  scale_y_continuous(name = "Count", expand = c(0,0), limits = c(0, 40), breaks = seq(0, 40, 10)) +
  labs(fill = "Type", title = "Distribution of Potassium in Breakfast Cereals") +
  theme_minimal()

```
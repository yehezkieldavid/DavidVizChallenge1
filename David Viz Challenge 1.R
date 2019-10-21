library(tidyverse)
library(stringr)
library(ggplot2)
library(tidyr)
library(htmlwidgets)
library(gridExtra)


# Reading the datas -------------------------------------------------------
gdp_per_cap_renewables = read.csv("gdp_per_cap_renewables.csv", stringsAsFactors = F)
diff_gdp_value = read.csv("GDP_value_diff per year_1990 to 2015.csv", stringsAsFactors =F)
energy_use = read.csv("energy_use_per_country.csv", stringsAsFactors =F)
df_3_wide = read.csv("df_3_wide.csv", stringsAsFactors = F)


# Cleaning the Datas ------------------------------------------------------
df_1 = full_join(gdp_per_cap_renewables,diff_gdp_value, by = "Countries")
join_percent = full_join(gdp_per_cap_renewables,perc_gdp_2015, by = "Countries")
df_2 = full_join(df_1, energy_use, by="Countries")
df_2 = na.omit(df_2)
df_3_long = gather(data = df_3_wide, key = "PPP_per_cap", value = "renewables_percent", 2:11)
df_3_long$PPP_per_cap = str_remove_all(df_3_long$PPP_per_cap,"^X")


# GG Plot -----------------------------------------------------------------
graph_2 = ggplot(data = df_3_long) + 
  geom_tile(aes(x=(PPP_per_cap), y=(log_diff_gdp), fill = (renewables_percent), width = 1), colour = "grey88") +
  scale_fill_gradient(low = "lightcoral", high = "green4") +
  theme_grey(base_size = 12) +
  labs(title = "'Goldilocks' Zone of Renewables",
       x = "2015 PPP per capita (US$ constant 2011)",
       y = "Average of PPP growth from 1990 - 2015 (log10 function)")

grid.arrange(graph_2,nrow=1)





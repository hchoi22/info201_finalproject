library(stringr)
library(tidyverse)


df_merged <- read.csv("df_merged.csv")
teachers_df <- read.csv("pupils_fte_teachers_2001_2019.csv") 
iq_df <- read.csv("data.csv")


state_names <- unique(df_merged$state)

viz1 <- ggplot(df_merged, aes(x = growthSince2010, y = averageIQ)) + 
  geom_point() + 
  geom_smooth(method = lm, se = F) +
  theme_bw(base_size = 10) + 
  labs(title = "Growth Rate Since 2010 Vs Average IQ", 
       x = "Growth Rate Since 2010", y = "Average IQ ")
viz1

teachers_df %>%
  group_by(year) %>%
  summarize(n_teachers = sum(fte_teachers)) %>% 
  arrange((n_teachers))


teachers_top5_num_df <- teachers_df %>% 
  filter(year == 2009 | year == 2010 | year == 2008 |
           year == 2019 | year == 2018)

year_num <- unique(teachers_df$year)

location_state <- unique(teachers_df$coast)


viz2 <- ggplot(teachers_top5_num_df, aes(x = pupils, y = pupil_per_fte_teacher)) + 
  geom_point() +
  facet_wrap(~ year) +
  theme_bw(base_size = 8) + 
  labs(title = "Relationship Between the Number of Highschool Students & 
       The Number of Higschool Students Per One Teacher", 
       x = "Number of Highschool Students", 
       y = "Ratio between Number of Students and the Number of Teachers")


viz3 <- ggplot(data = df_merged, aes(x = IQ_status, y = per_change_students)) + 
  geom_boxplot(fill = "lightblue") +
  theme_bw(base_size = 12) + 
  labs(title = "The Distribution of Percent Change by IQ Status of the State",
       x = "IQ Status", y = "Percent Change")
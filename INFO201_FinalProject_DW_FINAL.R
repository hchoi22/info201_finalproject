library(tidyverse)
library(dplyr)
library(stringr)

teachers <- read.csv("pupils_fte_teachers_2001_2019.csv", header = T) 

IQ <- read.csv("data.csv", header = T)


# creating a new categorical variable by state's location to the data frame of teachers 
regions <- list(
  west = c("CA", "OR", "WA", "NV", "ID", "UT", "AZ", "MT", "AK", "HI"),
  central = c("WY", "CO", "NM", "ND", "SD", "NE", "KS", "OK", "TX", "MN", 
              "IA", "MO", "AR", "LA", "WI", "IL", "MS"),
  east = c("MI", "IN", "KY", "TN", "AL", "OH", "GA", "FL", "SC", "NC", 
           "VA", "WV", "DE", "MD", "NJ", "PA", "NY", "CT", "RI", "MA", 
           "VT", "NH", "ME","DC")
)

teachers$coast <- NA 

for (region in names(regions)) {
  teachers$coast[teachers$state %in% regions[[region]]] <- region
}

location_state <- unique(teachers$coast)

write.csv(teachers, "pupils_fte_teachers_2001_2019.csv", row.names=FALSE)


# Merged Code 
teachers_2019 <-teachers %>% 
  filter(year == 2019)

state_name <- str_trim(str_extract(IQ$state,"[^,]*$"))

state_code <- state.abb[match(state_name, state.name)]

IQ$state_code <- state_code

df <- merge(IQ, teachers_2019, by.x = "state_code", by.y = "state", all.x = TRUE)


# adding one categorical variable relating to IQ whether the state's average IQ is located 
# at high (upper 25%), mid (middle 25%) or low(lower 25%)

summary(df$averageIQ)

df$IQ_status[df$averageIQ < 98.3] <- "low"
df$IQ_status[df$averageIQ >= 98.3 & df$averageIQ < 101.1] <- "mid"
df$IQ_status[df$averageIQ >= 101.1] <- "high"


# adding continuous numerical variables
## the percent change of the number of highschool students from the previous year(2018)

teachers_2018 <- teachers %>% 
  filter(year == 2018)

teachers_2018_2019 <- left_join(teachers_2018, teachers_2019, by = "state")

teachers_2018_2019$per_change_students <- round((teachers_2018_2019$pupils.y - teachers_2018_2019$pupils.x)*100/teachers_2018_2019$pupils.x,4)

per_change_students <- teachers_2018_2019 %>% 
  select(state, per_change_students)

df <- merge(df, per_change_students, by.x = "state_code", by.y = "state", all.x = TRUE) 

# two summarization data frame 
## 1) shows the order of IQ groups with the highest mean of high school student population change 

mean_student_pop_change_IQ <- df %>% 
  group_by(IQ_status) %>% 
  summarize(mean_stu_pop_change = mean(per_change_students)) %>% 
  arrange(desc(mean_stu_pop_change))

mean_student_pop_change_IQ

## 2) shows the order of states with the highest population growth rate since 2010

state_pop_change <- df %>% 
  group_by(state) %>% 
  summarize(growthSince2010) %>% 
  arrange(desc(growthSince2010))
state_pop_change

## Exporting the File 
write.csv(df, "df_merged.csv", row.names=FALSE)


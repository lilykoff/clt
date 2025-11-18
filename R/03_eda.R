library(tidyverse)
library(skimr)

# might need to recode some stuff later but ok for now 
nh_2021 = read_rds(here::here("data", "processed", "nhanes_2021_combined.rds"))
nh_2001 = read_rds(here::here("data", "processed", "nhanes_2001_combined.rds"))
nh_comb = read_rds(here::here("data", "processed", "nhanes_all.rds")) %>% 
  mutate(age_cat = cut(age_in_years_at_screening,
         breaks = c(0, 17, 29, 39, 49, 59, 69, Inf),
         include.lowest = TRUE))

nh_comb %>% 
  ggplot(aes(x = age_cat, y = protein_gm, color = data_release_cycle)) + 
  geom_boxplot() + 
  facet_wrap(.~gender, nrow = 2) +
  scale_y_continuous(limits=c(0, 200))
nh_comb %>% 
  ggplot(aes(x = protein_gm, fill = data_release_cycle)) + 
  geom_density() + 
  facet_wrap(.~gender)



nh_2021 %>% glimpse()
summary(nh_2021$dietary_recall_status)

skimr::skim(nh_2021)

summary(nh_2021$protein_gm)
nh_2021 %>% 
  ggplot(aes(x = protein_gm)) +
  geom_histogram(binwidth = 10, color = "black") +
  labs(title = "Distribution of Protein Intake (grams)",
       x = "Protein Intake (grams)",
       y = "Count") +
  scale_x_continuous(breaks=seq(0,400,20))

nh_2021 %>% 
  ggplot(aes(x = protein_gm, color = gender, fill = gender)) +
  geom_histogram(binwidth = 10, color = "black") +
  labs(title = "Distribution of Protein Intake (grams)",
       x = "Protein Intake (grams)",
       y = "Count") +
  scale_x_continuous(breaks=seq(0,400,20))

nh_2021 %>% 
  ggplot(aes(x = protein_gm, color = gender, fill = gender)) +
  geom_density(alpha = 0.5)
  labs(title = "Distribution of Protein Intake (grams)",
       x = "Protein Intake (grams)",
       y = "Count") +
  scale_x_continuous(breaks=seq(0,400,20))
  
cor(nh_2021$protein_gm, nh_2021$protein_gm_day2, use = "complete", method = "spearman")
cor(nh_2021$protein_gm, nh_2021$protein_gm_day2, use = "complete", method = "pearson")



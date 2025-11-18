library(tidyverse)

# ---- 2021 data ---- # 
diet_day1 = read_rds(here::here("data", "processed", "dietary_2021_day1.rds"))
diet_day2 = read_rds(here::here("data", "processed", "dietary_2021_day2.rds"))
demo = read_rds(here::here("data", "processed", "demo_2021.rds"))

# join 
colnames(diet_day1)
colnames(diet_day2)

       
diet_day1_small =
  diet_day1 %>% 
  select(respondent_sequence_number,
         contains("sample_weight"),
         dietary_recall_status,
         number_of_days_of_intake,
         intake_day_of_the_week,
         on_special_diet,
         contains("diet"),
         number_of_foods_beverages_reported,
         energy_kcal,
         protein_gm,
         carbohydrate_gm,
         total_sugars_gm,
         total_fat_gm,
         total_saturated_fatty_acids_gm,
         total_monounsaturated_fatty_acids_gm,
         total_polyunsaturated_fatty_acids_gm,
         cholesterol_mg,
         caffeine_mg,
         compare_food_consumed_yesterday_to_usual) 

diet_day2_small = 
  diet_day2 %>% 
  select(respondent_sequence_number,
         dietary_recall_status,
         intake_day_of_the_week,
         compare_food_consumed_yesterday_to_usual,
         number_of_foods_beverages_reported,
         energy_kcal,
         protein_gm,
         carbohydrate_gm,
         total_sugars_gm,
         total_fat_gm,
         total_saturated_fatty_acids_gm,
         total_monounsaturated_fatty_acids_gm,
         total_polyunsaturated_fatty_acids_gm,
         cholesterol_mg,
         caffeine_mg) %>% 
  rename_with(.cols = -respondent_sequence_number, .fn = ~ paste0(.x, "_day2"))


demo_small = 
  demo %>% 
  select(respondent_sequence_number,
         data_release_cycle,
         gender,
         age_in_years_at_screening,
         race_hispanic_origin,
         race_hispanic_origin_w_nh_asian,
         education_level_adults_20,
         ratio_of_family_income_to_poverty,
         full_sample_2_year_interview_weight,
         starts_with("masked"))

joined = 
  demo_small %>% 
  left_join(diet_day1_small, by = "respondent_sequence_number") %>% 
  left_join(diet_day2_small, by = "respondent_sequence_number")

write_rds(joined, here::here("data", "processed", "nhanes_2021_combined.rds"))


# ---- 2001 data ---- #   
diet = read_rds(here::here("data", "processed", "dietary_2001.rds"))
demo = read_rds(here::here("data", "processed", "demo_2001.rds"))

# join 
colnames(diet)


diet_small =
  diet %>% 
  select(respondent_sequence_number,
         contains("sample_weight"),
         dietary_recall_status,
         intake_day_of_the_week,
         number_of_foods,
         energy_kcal,
         protein_gm,
         carbohydrate_gm,
         total_sugars_gm,
         total_fat_gm,
         total_saturated_fatty_acids_gm,
         total_monounsaturated_fatty_acids_gm,
         total_polyunsaturated_fatty_acids_gm,
         cholesterol_mg,
         compare_food_consumed_yesterday_to_usual) 



demo_small = 
  demo %>% 
  select(respondent_sequence_number,
         data_release_number,
         gender,
         age_at_screening_adjudicated_recode,
         race_ethnicity_recode,
         education_level_adults_20,
         # ratio_of_family_income_to_poverty,
         full_sample_2_year_interview_weight,
         starts_with("masked"))

joined = 
  demo_small %>% 
  left_join(diet_small, by = "respondent_sequence_number") 

write_rds(joined, here::here("data", "processed", "nhanes_2001_combined.rds"))

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
         dietary_fiber_gm,
         caffeine_mg,
         compare_food_consumed_yesterday_to_usual) %>% 
  rename_with(.cols = c(dietary_recall_status,
                        intake_day_of_the_week,
                        compare_food_consumed_yesterday_to_usual,
                        number_of_foods_beverages_reported,
                        energy_kcal,
                        protein_gm,
                        carbohydrate_gm,
                        total_sugars_gm,
                        dietary_fiber_gm,
                        total_fat_gm,
                        total_saturated_fatty_acids_gm,
                        total_monounsaturated_fatty_acids_gm,
                        total_polyunsaturated_fatty_acids_gm,
                        cholesterol_mg,
                        caffeine_mg), .fn = ~ paste0(.x, "_day1"))


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
         dietary_fiber_gm,
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

# do a bit more processing 
joined %>% colnames

joined_small = 
  joined %>% 
  select(respondent_sequence_number,
         data_release_cycle,
         gender,
         age_in_years_at_screening,
         race_hispanic_origin,
         education_level_adults_20,
         full_sample_2_year_interview_weight,
         masked_variance_pseudo_stratum,
         masked_variance_pseudo_psu,
         dietary_recall_status_day1,
         dietary_recall_status_day2,
         contains("energy"),
         contains("carbohydrate_gm"),
         contains("protein_gm"),
         contains("total_fat"),
         contains("dietary_fiber"),
         contains("number"),
         contains("compare"),
         contains("intake"),
         contains("cholesterol"),
         contains("caffeine"))

joined_small = 
  joined_small %>% 
  mutate(across(c(energy_kcal_day1, carbohydrate_gm_day1, protein_gm_day1, 
                  total_fat_gm_day1, dietary_fiber_gm_day1, cholesterol_mg_day1, caffeine_mg_day1), 
                ~if_else(dietary_recall_status_day1 == "Reliable and met the minimum criteria", 
                         .x, NA_real_)),
         across(c(energy_kcal_day2, carbohydrate_gm_day2, protein_gm_day2,
                  total_fat_gm_day2, dietary_fiber_gm_day2, cholesterol_mg_day2, caffeine_mg_day2), 
                ~if_else(dietary_recall_status_day2 == "Reliable and met the minimum criteria", 
                         .x, NA_real_))) %>% 
  rowwise() %>% 
  mutate(energy_kcal = mean(c(energy_kcal_day1, energy_kcal_day2), na.rm = TRUE),
         carbohydrate_gm = mean(c(carbohydrate_gm_day1, carbohydrate_gm_day2), na.rm = TRUE),
         protein_gm = mean(c(protein_gm_day1, protein_gm_day2), na.rm = TRUE),
         dietary_fiber_gm = mean(c(dietary_fiber_gm_day1, dietary_fiber_gm_day2), na.rm = TRUE),
         total_fat_gm = mean(c(total_fat_gm_day1, total_fat_gm_day2), na.rm = TRUE),
         cholesterol_mg = mean(c(cholesterol_mg_day1, cholesterol_mg_day2), na.rm = TRUE),
         caffeine_mg = mean(c(caffeine_mg_day1, caffeine_mg_day2, na.rm = TRUE))) %>% 
  ungroup() 
         
write_rds(joined_small, here::here("data", "processed", "nhanes_2021_combined_small.rds"))

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
         dietary_fiber_gm,
         caffeine_mg,
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

joined_small = 
  joined %>% 
  select(respondent_sequence_number,
         data_release_cycle = data_release_number,
         gender,
         age_in_years_at_screening = age_at_screening_adjudicated_recode,
         race_hispanic_origin = race_ethnicity_recode,
         education_level_adults_20,
         full_sample_2_year_interview_weight,
         masked_variance_pseudo_stratum,
         masked_variance_pseudo_psu,
         dietary_recall_status,
         contains("energy"),
         contains("carbohydrate_gm"),
         contains("protein_gm"),
         contains("total_fat"),
         contains("dietary_fiber"),
         contains("number"),
         contains("compare"),
         contains("intake"),
         contains("cholesterol"),
         contains("caffeine"))


joined_small = 
  joined_small %>% 
  mutate(across(c(energy_kcal, carbohydrate_gm, protein_gm, 
                  total_fat_gm, dietary_fiber_gm, cholesterol_mg, caffeine_mg), 
                ~if_else(dietary_recall_status == "Reliable and met the minimum criteria", 
                         .x, NA_real_)))

write_rds(joined_small, here::here("data", "processed", "nhanes_2001_combined_small.rds"))


# --- combine both waves ----- # 

nh_2021 = read_rds(here::here("data", "processed", "nhanes_2021_combined_small.rds"))
nh_2001 = read_rds(here::here("data", "processed", "nhanes_2001_combined_small.rds"))

colnames(nh_2001) %in% colnames(nh_2021)

combined = bind_rows(nh_2001, nh_2021)

write_rds(combined, here::here("data", "processed", "nhanes_all.rds"))

library(tidyverse)
library(haven)
library(nhanesA)

if (!dir.exists(here::here("data", "processed"))) dir.create(here::here("data", "processed"))

# --- dietary data ---- # 
# 2021 
nh_diet21 = read_xpt(here::here("data/raw/nhanes_2021_dietary1.xpt"))
nh_diet21_2 = read_xpt(here::here("data/raw/nhanes_2021_dietary2.xpt"))

nh_trans = nhanesTranslate(nh_table = "DR1TOT_L", data = nh_diet21)

lab_df = sjlabelled::label_to_colnames(nh_trans) %>% 
  janitor::clean_names()

write_rds(lab_df, here::here("data", "processed", "dietary_2021_day1.rds"))

nh_trans = nhanesTranslate(nh_table = "DR2TOT_L", data = nh_diet21_2)

lab_df = sjlabelled::label_to_colnames(nh_trans) %>% 
  janitor::clean_names()

write_rds(lab_df, here::here("data", "processed", "dietary_2021_day2.rds"))

# 2001 
nh_diet2001 = read_xpt(here::here("data/raw/nhanes_2001_dietary.xpt"))
nh_trans = nhanesTranslate(nh_table = "DRXTOT_B", data = nh_diet2001)

lab_df = sjlabelled::label_to_colnames(nh_trans) %>% 
  janitor::clean_names()

write_rds(lab_df, here::here("data", "processed", "dietary_2001.rds"))


# ---- demo data ----- # 
# 2021 
demo_21 = read_xpt(here::here("data/raw/nhanes_2021_demo.xpt"))
demo_trans = nhanesTranslate(nh_table = "DEMO_L", data = demo_21)
lab_df = sjlabelled::label_to_colnames(demo_trans) %>% 
  janitor::clean_names()

write_rds(lab_df, here::here("data", "processed", "demo_2021.rds"))

# 2001 
demo_2001 = read_xpt(here::here("data/raw/nhanes_2001_demo.xpt"))

demo_trans = nhanesTranslate(nh_table = "DEMO_B", data = demo_2001)

lab_df = sjlabelled::label_to_colnames(demo_trans) %>% 
  janitor::clean_names()

write_rds(lab_df, here::here("data", "processed", "demo_2001.rds"))

bmx_2001 = read_xpt(here::here("data/raw/nhanes_2001_bmx.xpt"))
bmx_trans = nhanesTranslate(nh_table = "BMX_B", data = bmx_2001)

lab_df = sjlabelled::label_to_colnames(bmx_trans) %>% 
  janitor::clean_names()

write_rds(lab_df, here::here("data", "processed", "bmx_2001.rds"))


bmx_2021 = read_xpt(here::here("data/raw/nhanes_2021_bmx.xpt"))
bmx_trans = nhanesTranslate(nh_table = "BMX_L", data = bmx_2021)

lab_df = sjlabelled::label_to_colnames(bmx_trans) %>% 
  janitor::clean_names()

write_rds(lab_df, here::here("data", "processed", "bmx_2021.rds"))

bpx_2021 = read_xpt(here::here("data/raw/nhanes_2021_bpx.xpt"))
bpx_trans = nhanesTranslate(nh_table = "BPXO_L", data = bpx_2021)

lab_df = sjlabelled::label_to_colnames(bpx_trans) %>% 
  janitor::clean_names()

write_rds(lab_df, here::here("data", "processed", "bpx_2021.rds"))

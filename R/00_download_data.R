library(tidyverse)

if(!dir.exists(here::here("data", "raw"))) {
  dir.create(here::here("data", "raw"), recursive = TRUE)
}

nh_url1 = "https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2021/DataFiles/DR1TOT_L.xpt"
nh_url2 = "https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2021/DataFiles/DR2TOT_L.xpt"
nh_url3 = "https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2001/DataFiles/DRXTOT_B.xpt"
curl::curl_download(nh_url1, destfile = here::here("data/raw/nhanes_2021_dietary1.xpt"))
curl::curl_download(nh_url2, destfile = here::here("data/raw/nhanes_2021_dietary2.xpt"))
curl::curl_download(nh_url3, destfile = here::here("data/raw/nhanes_2001_dietary.xpt"))

demo_1 = "https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2021/DataFiles/DEMO_L.xpt"
curl::curl_download(demo_1, destfile = here::here("data/raw/nhanes_2021_demo.xpt"))

demo_1 = "https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2021/DataFiles/DEMO_L.xpt"
curl::curl_download(demo_1, destfile = here::here("data/raw/nhanes_2021_demo.xpt"))

demo_2 = "https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2001/DataFiles/DEMO_B.xpt"
curl::curl_download(demo_2, destfile = here::here("data/raw/nhanes_2001_demo.xpt"))


##### old 

nh_diet17 = read_xpt(here::here("data/raw/nhanes_2017_dietary.xpt"))

nh_trans = nhanesTranslate(nh_table = "DR1TOT_J", data = nh_diet17)

lab_df = sjlabelled::label_to_colnames(nh_trans) %>% 
  janitor::clean_names()
# https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2021/DataFiles/DR1TOT_L.xpt
# https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2021/DataFiles/DEMO_L.xpt
# want to join in demog 
# https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2015/DataFiles/DR1TOT_I.xpt
# https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2015/DataFiles/DR2TOT_I.xpt

# old! https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2001/DataFiles/DRXTOT_B.xpt

# https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2015/DataFiles/DEMO_I.xpt
# ----- old ---- # 
# nh_url = "https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2017/DataFiles/DEMO_J.xpt"
# curl::curl_download(nh_url, destfile = here::here("data/raw/nhanes_2017_demo.xpt"))
# nh_data = read_xpt(here::here("data/raw/nhanes_2017_demo.xpt"))
# 
# nh_data %>% 
#   as_tibble() %>% 
#   head()



# nh_trans = nhanesTranslate(nh_table = "DEMO_J", data = nh_data)
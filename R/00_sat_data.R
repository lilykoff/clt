library(tidyverse)


url = "https://www.kaggle.com/api/v1/datasets/download/theriley106/rsat-flair-dataset"
curl::curl_download(url, destfile = here::here("data/raw/sat_score_data.zip"), mode = "wb")
unzip(here::here("data/raw/sat_score_data.zip"), exdir = here::here("data/raw/sat_score_data"))

# how to readin data/raw/sat_score_data/SAT_SCORE_INDIVIDUAL_ESTIMATES.json

data_list = jsonlite::read_json(here::here("data/raw/sat_score_data/SAT_SCORE_INDIVIDUAL_ESTIMATES.json"))
sat_vec_long = map(.x = data_list,
               .f = function(x){
                 t = as_tibble(x)
                 rep(t$Score, t$Students)
               })

sat_vec = unlist(sat_vec_long)

write_rds(sat_vec, here::here("data", "processed", "sat_2017.rds"))
# https://www.kaggle.com/datasets/theriley106/rsat-flair-dataset

url = "https://www.kaggle.com/api/v1/datasets/download/billbasener/sat-score-data-by-state"
curl::curl_download(url, destfile = here::here("data/raw/sat_states.zip"), mode = "wb")
unzip(here::here("data/raw/sat_states.zip"), exdir = here::here("data/raw/sat_states"))
file.remove(here::here("data/raw/sat_states.zip"))
sat_score = read_csv(here::here("data/raw/sat_states/Guber1999data.csv"))
write_rds(sat_score, here::here("data", "processed", "sat_states_1999.rds"))

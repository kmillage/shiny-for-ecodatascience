### ----------------------------------------------
### ----------------------------------------------
### This script loads and wrangles data
### ----------------------------------------------
### ----------------------------------------------

### ----------------------------------
### App data -------------------------
### ----------------------------------

fao_dat <- read_csv("./data/fao_2020_capture_production_isscaap_groups_tidy.csv") %>%
  mutate(country = countrycode(iso3, "iso3c", "country.name")) %>%
  dplyr::filter(!is.na(country)) %>%
  dplyr::filter(variable == "capture_production") %>%
  group_by(iso3, year) %>%
  mutate(total = sum(value, na.rm = T)) %>%
  ungroup() %>%
  mutate(prop_annual_total = value/total)

all_countries <- fao_dat %>%
  distinct(iso3, country) %>%
  arrange(country)

country_choices <- all_countries$iso3
names(country_choices) <- all_countries$country



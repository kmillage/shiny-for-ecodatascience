### ----------------------------------------------
### ----------------------------------------------
### This script loads and wrangles data
### ----------------------------------------------
### ----------------------------------------------

### ----------------------------------
### App data -------------------------
### ----------------------------------

# 1) Load list of WTO Member states and their dependencies with chosen display names
country_lookup <- read_csv("./data/country_dependencies.csv") %>%
  mutate(display_name = case_when(!is.na(WTO_name) ~ WTO_name,
                                  iso3 == "ANT" ~ "Netherlands Antilles",
                                  iso3 == "ASC" ~ "Ascension Island", 
                                  iso3 == "CPT" ~ "Clipperton Island",
                                  iso3 == "TAA" ~ "Tristan da Cunha",
                                  TRUE ~ countrycode(iso3, "iso3c", "country.name"))) %>%
  arrange(display_name, sovereign_iso3) 

# Need to add an entry for the "EU" as an aggregate 
eu_entry <- tibble(iso3 = "EU", sovereign_iso3 = "EU", WTO_name = "European Union", WTO_status = "Member", is_EU = T, is_overseas_territory = F, is_permanently_inhabited = T, development_status = "Developed", is_WTO = T, display_name = "European Union")

country_lookup <- country_lookup %>%
  bind_rows(eu_entry)

# EU states
eu_countries <- country_lookup$iso3[country_lookup$is_EU]
names(eu_countries) <- country_lookup$display_name[country_lookup$iso3 %in% eu_countries]

# 2) World map ---
world <- read_sf("./data/ne_50m_admin_SubsidyExplorer", layer = "land_50m")

eu_shp <- world %>%
  dplyr::filter(admin_iso3 %in% eu_countries) %>%
  mutate(sov_iso3 = "EU", 
         admin_iso3 = "EU") %>%
  group_by(sov_iso3, admin_iso3) %>%
  summarize(area_km = sum(area_km)) %>%
  ungroup()

world_eu <- world %>%
  dplyr::filter(!(admin_iso3 %in% eu_countries)) %>%
  rbind(eu_shp)

# Identify small countries for which we are going to add little dots on the map for easier viewing
world_small_countries <- world  %>%
  dplyr::filter(area_km < 300) %>%
  mutate(center = st_centroid(geometry))

# 3) Subsidy estimates - This data comes from Sumaila et al. (2019).
subsidy_dat <- read_csv("./data/sumaila_et_al_2019_subsidies_tidy.csv") %>%
  arrange(iso3) %>%
  left_join(country_lookup %>% dplyr::select(iso3, display_name), by = "iso3")

subsidy_classification_sumaila <- subsidy_dat %>%
  distinct(category, category_name, type, type_name) %>%
  arrange(type)

subsidy_types_sorted_sumaila <- subsidy_classification_sumaila$type
names(subsidy_types_sorted_sumaila) <- subsidy_classification_sumaila$type_name
  
  
  



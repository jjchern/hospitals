

# Add state-year level hospital beds per 1,000 Population -----------------

library(dplyr, warn.conflicts = FALSE)
readr::read_csv("data-raw/hospital_beds.csv", skip = 4, na = "N/A") %>%
        tidyr::gather(var, value, -Location) %>%
        tidyr::separate(var, c("varname", "year"), sep = ",") %>%
        mutate(value = round(value, 1),
               varname = tolower(varname)) %>%
        tidyr::spread(varname, value) %>%
        rename(state = Location) -> beds_state

# devtools::install.github("jjchern/fips")
fips::fips %>%
        right_join(beds_state, by = "state") -> beds_state
devtools::use_data(beds_state)

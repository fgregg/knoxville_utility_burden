library(tidyverse)
library(tidycensus)
library(srvyr)

get_knoxville_pums <- function(survey) {
    vars = c(
        "ELEFP", "ELEP", "HINCP", "GASFP", "GASP",
        "WATFP", "WATP", "TEN", "RELSHIPP", "RACBLK")
    knoxville_pums <- tidycensus::get_pums(
        variables = vars,
        state = 'TN',
        puma = c('01603'),
        survey = survey,
        year = 2019,
        recode = TRUE,
        rep_weights = "housing"
    )

    knoxville_pums <- knoxville_pums %>%
        filter(SPORDER == 1 & RELSHIPP_label == 'Reference person')

    knoxville_pums <- tidycensus::to_survey(knoxville_pums,
                                            type='housing')

    knoxville_pums <- knoxville_pums %>%
        mutate(
            HINCP = ifelse(HINCP == -60000, NA, HINCP),
            ST = as.factor(ST),
            ELEFP = as.factor(ELEFP),
            GASFP = as.factor(GASFP),
            TEN = as.factor(TEN),
            WATFP = as.factor(WATFP),
            RELSHIPP = as.factor(RELSHIPP),
            RACBLK = as.factor(RACBLK),
            black = RACBLK_label == 'Yes')

    knoxville_pums <- knoxville_pums %>%
        mutate(
            tenure = case_when(TEN_label == 'Owned with mortgage or loan (include home equity loans)' ~ 'Owner Occupied',
                               TEN_label == 'Owned free and clear' ~ 'Owner Occupied',
                               TEN_label == 'Rented' ~ 'Renter Occupied',
                               TEN_label == 'Occupied without payment of rent' ~ 'Renter Occupied'))

    # what should we do about home heating oil people?
    knoxville_pums <- knoxville_pums %>% 
        mutate(
            kub_energy = (case_when(GASFP_label == 'Valid monthly gas cost in GASP' ~ GASP,
                                    GASFP_label == 'No charge or gas not used' ~ 0,
                                    GASFP_label == 'Included in electricity payment' ~ 0,
                                    TRUE ~ NA_real_) * 12 +
                          case_when(ELEFP_label == 'Valid monthly electricity cost in ELEP' ~ ELEP,
                                    ELEFP_label == 'No charge or electricity not used' ~ 0,
                                    TRUE ~ NA_real_) * 12),
            kub_water = case_when(WATFP_label == 'Valid annual water cost in WATP' ~ WATP,
                                  WATFP_label == 'No charge' ~ 0,
                                  TRUE ~ NA_real_),
            kub_utilities = kub_energy + kub_water,
            kub_burden = kub_utilities / HINCP)

    return(knoxville_pums)
}

knoxville_pums <- get_knoxville_pums('acs1')

knoxville_pums_filtered <- knoxville_pums %>% 
    filter(kub_burden >=0 & kub_burden <=1)
    
knoxville_pums_filtered %>% 
    srvyr::survey_count(RACBLK_label, kub_burden > 0.1) %>%
    pivot_wider(
        RACBLK_label,
        names_from="kub_burden > 0.1", 
        values_from=n)

tenure <- knoxville_pums_filtered %>%
    srvyr::survey_count(
        RACBLK_label,
        tenure,
        kub_burden > 0.1)

tenure %>% 
    filter(tenure == 'Owner Occupied') %>%
    pivot_wider(
        RACBLK_label,
        names_from="kub_burden > 0.1",
        values_from=n)

tenure %>% 
    filter(tenure == 'Renter Occupied') %>%
    pivot_wider(
        RACBLK_label,
        names_from="kub_burden > 0.1",
        values_from=n)

model <- survey::svyglm(
    I(kub_burden > 0.1) ~ black * tenure, 
    design=knoxville_pums_filtered)


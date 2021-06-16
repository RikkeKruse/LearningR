# Exercise 9.9

nhanes_small %>%
    select(tot_chol, bp_sys_ave, poverty)

nhanes_small %>%
    rename(diabetes_diagnosis_age = diabetes_age)

nhanes_small

#vælg kolonner som indeholder bmi eller "age" på en eller anden måde
nhanes_small %>%
    select(bmi, contains("age"))

nhanes_small %>%
    select(phys_active_days, phys_active) %>%
    rename(days_phys_active = phys_active_days)

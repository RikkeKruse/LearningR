#Load up the packages
source(here::here("R/package-loading.R"))

#Briefly glimpse content of dataset
glimpse(NHANES)

# Select one column by its name
select(NHANES, Age)

#Select more columns
select(NHANES, Age, Weight, BMI)

#Exclude a column
select(NHANES, -HeadCirc)

# All columns starting with "BP"
select(NHANES, starts_with("BP"))


# Select all columns ending with "Day"
select(NHANES, ends_with("Day"))

# Select all columns containing "Age"
select(NHANES, contains("Age"))

?select_helpers

# Save the selected colums as a new data frame
nhanes_small <- select(NHANES, Age, Gender, Height, Weight, BMI, Diabetes, DiabetesAge, PhysActiveDays, PhysActive, TotChol, BPSysAve, BPDiaAve, SmokeNow, Poverty)

#View the new data frame
nhanes_small

## Renaming
# Rename all columns to snake case (small letters)
nhanes_small <- rename_with(nhanes_small, snakecase::to_snake_case)

nhanes_small


# Renaming specific column (new name = old name)
rename(nhanes_small, sex = gender)


nhanes_small

#Gem navneændringen gender -> sex
nhanes_small <- rename(nhanes_small, sex = gender)

nhanes_small


#9.8 - pipe operator
## The pipe operator

# Without the pipe operator
colnames(nhanes_small)

# With pipe operator (ctrl-shift-M)
nhanes_small %>% colnames()

# Using the pipe line operator with more functions
nhanes_small %>%
    select(phys_active) %>%
    rename(physically_active = phys_active)












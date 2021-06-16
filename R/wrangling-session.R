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

## Filtering

# Filter for all females

nhanes_small %>%
    filter(sex == "female")

nhanes_small %>%
    filter(sex != "female")


# Which parcipants have a BMI equal to 25
nhanes_small %>%
    filter(bmi == 25)

# Participants with bmi greater than or equal to 25
nhanes_small %>%
    filter(bmi >= 25)

# Filter for two or more variables
# BMI greater than 25 and the sex is female

nhanes_small %>%
    filter(bmi > 25 & sex == "female")


# bmi greater than 25 or the sex is female

nhanes_small %>%
    filter(bmi > 25 | sex == "female")

## Arrange the data - sorting
# Arrange by age in ascending order
nhanes_small %>%
    arrange(age)

# Arrange by sex in ascending order
nhanes_small %>%
    arrange(sex)

# Arrange by age in descending order
nhanes_small %>%
    arrange(desc(age))

nhanes_small %>%
    arrange(desc(bmi))

#Arrange by more than one variable - arrange by sex and then by age in ascending order

nhanes_small %>%
    arrange(sex, age)


# arrange sex ascending and age descending
nhanes_small %>%
    arrange(sex, desc(age))

## Transform or add columns

# Height column should be transformed for being in cm to m
nhanes_small %>%
    mutate(height = height / 100)

# Add a new column with logged height values
nhanes_small %>%
    mutate(logged_height = log(height))

nhanes_small %>%
    mutate(height = height / 100, logged_height = log(height))

# Add a new column "highly active days" - yes if greater than 5, no if not
nhanes_small %>%
    mutate(highly_active = if_else(phys_active_days >= 5, "Yes", "No"))

# Update the existing data frame with all the new stuff that we did
nhanes_update <- nhanes_small %>%
    mutate(height = height / 100, logged_height = log(height), highly_active = if_else(phys_active_days >= 5, "Yes", "No"))

#check
head(nhanes_update)

str(nhanes_update)


## Summary statistics by group
#find max bmi in dataset
nhanes_small %>%
    summarise(max_bmi = max(bmi))

#the above command gave us nA because the value is not available for all participants. to get the max number do this
nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE))

#find out how many missing values NAs) are there
nhanes_small %>%
    summarise(sum_na = sum(is.na(bmi)))

# Calculating 2 summary statistics
nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm =TRUE), min_bmi = min(bmi, na.rm =TRUE))



## calculating summary statistics by group

nhanes_small %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE), mean_bmi = mean(bmi, na.rm = TRUE))

nhanes_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE), mean_bmi = mean(bmi, na.rm = TRUE)) %>%
    ungroup()

# ALtid ungroup datasæt så det kan brues igen


#Saving datasets as files

# Saving data as an .rda file in the data folder
usethis::use_data(nhanes_small, overwrite = TRUE)

nhanes_small
















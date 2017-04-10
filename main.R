source("get_data_sets.R")
source("read_data.R")
source("clean_data.R")

## Ensure have raw data
get_data_sets()

## Read in
aid_stations <- read_aid_stations()
finals_2015 <- read_finals("2015")
splits_2015 <- read_splits("2015")
finals_2016 <- read_finals("2016")
splits_2016 <- read_splits("2016")

## Clean up
aid_stations <- clean_aid(aid_stations)

splits_2015 <- clean_splits(aid_stations, splits_2015, "2015")

splits_2016 <- clean_splits(aid_stations, splits_2016, "2016")
splits_2016 <- splits_2016[!is.na(splits_2016$Bib),]

colnames(finals_2015)[6] <- "Finish"
colnames(finals_2016)[6] <- "Finish"

results_2015 <- merge(splits_2015, finals_2015[c(2,6)])
results_2015$Finish <- str_sub(results_2015$Finish, 1, 5)

results_2016 <- merge(splits_2016, finals_2016[c(2,6)])
results_2016$Finish <- str_sub(results_2016$Finish, 1, 5)


## Convert
# splits_2015[4:22] <- sapply(splits_2015[4:22], apply_conversion)
## number of out of band values, i.e. by 12hrs (24 vs 12)



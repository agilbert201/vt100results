source("GetDataSets.R")
source("ReadData.R")
source("CleanData.R")

## Ensure have raw data
GetDataSets()

## Read in
aid_stations <- ReadAidStations()
finals_2015 <- ReadFinals("2015")
splits_2015 <- ReadSplits("2015")
finals_2016 <- ReadFinals("2016")
splits_2016 <- ReadSplits("2016")

## Clean up
aid_stations <- CleanAid(aid_stations)
splits_2015 <- CleanSplits(aid_stations, splits_2015, "2015")

splits_2016 <- CleanSplits(aid_stations, splits_2016, "2016")
splits_2016 <- splits_2016[splits_2016$Bib != "00:00",]
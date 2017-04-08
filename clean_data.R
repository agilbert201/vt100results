#
# Support functions to clean up dataframes
#
library(stringr)

clean_aid <- function(aid_dt) {
    aid_dt[11,]$Name <- 'Camp 10 Bear Out'
    aid_dt[17,]$Name <- 'Camp 10 Bear In'
    aid_dt[26,]$Name <- 'Finish'
    aid_dt$Mileage <- as.numeric(aid_dt$Mileage)
    aid_dt$Next <- as.numeric(aid_dt$Next)
    aid_dt$Name <- factor(aid_dt$Name, levels = aid_dt$Name)    
    aid_dt
}

clean_splits <- function(aid_dt, dt, year) {
    if (year == "2015")
        dt <- dt[3:322,]
    else
        dt <- dt[,c(2,1,3:22)]
    aid_names <- as.character(aid_dt$Name[str_detect(aid_dt$Type, "A")])
    c_names <- c("First Name", "Last Name", "Bib", aid_names)
    colnames(dt) <- c_names[1:22]
    #dt[,4:22][dt[,4:22] == ""] <- NA
    dt$Bib <- as.integer(dt$Bib)
    dt
}


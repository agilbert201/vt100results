#
# Support functions to clean up dataframes
#
library(stringr)

CleanAid <- function(aid_dt) {
    aid_dt[11,]$Name <- 'Camp 10 Bear Out'
    aid_dt[17,]$Name <- 'Camp 10 Bear In'
    aid_dt[26,]$Name <- 'Finish'
    aid_dt
}

CleanSplits <- function(aid_dt, dt, year) {
    if (year == "2015")
        dt <- dt[3:322,]
    else
        dt <- dt[,c(2,1,3:22)]
    aid_names <- aid_dt$Name[str_detect(aid_dt$Type, "A")]
    c_names <- c("First Name", "Last Name", "Bib", aid_names)
    colnames(dt) <- c_names[1:22]
    #dt[,4:22][dt[,4:22] == ""] <- NA
    dt
}


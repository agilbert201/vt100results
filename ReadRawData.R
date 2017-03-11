##
## Read in raw data sets
##
library(htmltab)
library(XML)

ReadSplits <- function(year) {
    fn <- paste(year, "_splits.html", sep="")
    fp <- file.path("data", fn)
    htmltab(doc = fp,
            which = "//h3[contains(text(), 'Splits')]/following-sibling::table")
    
    #splits_2015_raw <- htmltab(doc = fp, 
    #                           which = "//h3[text() = '100 Mile Splits']/following-sibling::table")
    
    #fp <- file.path("data", "2016_splits.html")
    #splits_2016_raw <- htmltab(doc = fp, 
    #                           which = "//h3[text() = '100M Splits']/following-sibling::table")
}

ReadFinals <- function(year) {
    fn <- paste(year, "_final.html", sep="")
    fp <- file.path("data", fn)
    raw_html <- htmlParse(fp)
    ns <- getNodeSet(raw_html, "//pre")
    xmlText <- xmlValue(ns[[1]])
    #stringr::str_split(xmlText, "\n")
    #lines <- as.list(strsplit(xmlText, "\n")[[1]])
    unlist(strsplit(xmlText, "\n"))
}

ReadAidStations <- function() {
    aidfp <- file.path("data", "aid_stations.html")
    readHTMLTable(aidfp, skip.rows = c(1:3, 30:40), stringsAsFactors = FALSE, which = 1)
}

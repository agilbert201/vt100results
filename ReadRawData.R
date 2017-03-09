##
## Read in raw data sets
##
fp <- file.path("data", "2015_splits.html")
splits_2015_raw <- htmltab(doc = fp, which = "//h3[text() = '100 Mile Splits']/following-sibling::table")

fp <- file.path("data", "2016_splits.html")
splits_2016_raw <- htmltab(doc = fp, which = "//h3[text() = '100M Splits']/following-sibling::table")

ReadFinalResults <- function(year) {
    fp <- file.path("data", "2015_final.html")
    raw_html <- htmlParse(fp)
    ns <- getNodeSet(raw_html, "//pre")
    xmlText <- xmlValue(ns[[1]])
    #stringr::str_split(xmlText, "\n")
    #lines <- as.list(strsplit(xmlText, "\n")[[1]])
    unlist(strsplit(xmlText, "\n"))
}

final_2015 <- ReadFinalResults()
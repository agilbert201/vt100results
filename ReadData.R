##
## Support functions to read/process raw data sets
##
library(stringr)
library(readr)
library(XML)

ReadAidStations <- function() {
    aidfp <- file.path("data", "aid_stations.html")
    aid_t <- readHTMLTable(aidfp, skip.rows = c(1:3, 30:40), stringsAsFactors = FALSE, which = 1)
    aid_t <- aid_t[3:8]
    colnames(aid_t) <- c("Name", "Mileage", "Next", "Open", "Close", "Type")
    aid_t
}

ReadFinals <- function(year) {
    ## Pull <pre> out of each final, do some cleanup and load to table
    fn <- paste(year, "_final.html", sep="")
    fp <- file.path("data", fn)
    raw_html <- htmlParse(fp)
    ns <- getNodeSet(raw_html, "//pre")
    xmlText <- xmlValue(ns[[1]])
    # do some cleaning
    xmlText <- str_replace_all(xmlText, "\r", "")
    # should really be \uFFDD but by now it's this gibberish
    xmlText <- str_replace_all(xmlText, "Ã¯Â¿Â½", "_")
    xmlText <- str_replace(xmlText, "[\\*]{3}", "")
    
    # garbage lines in the pre section
    skip_rows <- 9
    
    # read into a table
    col_spec <- fwf_empty(xmlText, skip = skip_rows, 
                          col_names = c("Place", "Bib", "Name", "Age", "Class", "Time"))
    # for now treat last col as char as time will overrun past 23:59
    read_fwf(xmlText, col_positions = col_spec, skip = skip_rows, col_types = "iicccc")
}

ReadSplits <- function(year) {
    # for 2015 it's '100 Mile Splits', for 2016 '100M Splits'
    fn <- paste(year, "_splits.html", sep="")
    fp <- file.path("data", fn)
    doc <- htmlParse(fp, encoding = "UTF-8")
    xp <- "//h3[contains(text(), 'Splits')]/following-sibling::table"
    table_node <- getNodeSet(doc, xp)
    readHTMLTable(table_node[[1]], stringsAsFactors = FALSE)
}

##
## Support functions to read/process raw data sets
##
library(stringr)
library(readr)
library(htmltab)
library(XML)

ReadSplits <- function(year) {
    # for 2015 it's '100 Mile Splits', for 2016 '100M Splits'
    fn <- paste(year, "_splits.html", sep="")
    fp <- file.path("data", fn)
    htmltab(doc = fp,
            which = "//h3[contains(text(), 'Splits')]/following-sibling::table")
}

ReadFinals <- function(year) {
    ## Pull <pre> out of each final, do some cleanup and parse
    fn <- paste(year, "_final.html", sep="")
    fp <- file.path("data", fn)
    #output_fn <- paste(year, "_final.txt", sep="")
    #output_fp <- file.path("data", output_fn)
    raw_html <- htmlParse(fp)
    ns <- getNodeSet(raw_html, "//pre")
    xmlText <- xmlValue(ns[[1]])
    # do some cleaning
    xmlText <- str_replace_all(xmlText, "\r", "")
    xmlText <- str_replace_all(xmlText, "Ã¯Â¿Â½", "_")
    
    #skip_rows <- if (year == "2015") 8 else 9
    skip_rows <- 9
    
    # read into a table
    col_spec <- fwf_empty(xmlText, skip = skip_rows, 
                          col_names = c("Place", "Bib", "Name", "Age", "Class", "Time"))
    # for now treat last col as char as time will overrun past 23:59
    read_fwf(xmlText, col_positions = col_spec, skip = skip_rows, col_types = "iicccc")
    
    #lines <- str_split(xmlText, "\n")
    #lines <- unlist(lines)
    #lines <- str_replace_all(lines, "\r", "")
    
    # this is a hack to get rid of 'replacement characters'
    # should really be \uFFDD but by now it's this gibberish
    #lines <- str_replace_all(lines, "Ã¯Â¿Â½", "_")
}

ReadAidStations <- function() {
    aidfp <- file.path("data", "aid_stations.html")
    readHTMLTable(aidfp, skip.rows = c(1:3, 30:40), stringsAsFactors = FALSE, which = 1)
}

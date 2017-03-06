##
## Support function to retrieve data sets
##

dataset.2016_final_url <- "http://www.coolrunning.com/results/16/vt/Jul17_VT100E_set4.shtml"
dataset.2016_final <- file.path("data", "2016_final.html")
dataset.2016_splits_url <- "http://www.coolrunning.com/results/16/vt/Jul17_VT100E_set6.shtml"
dataset.2016_splits <- file.path("data", "2016_splits.html")

GetDataSets <- function() {
    ## Verifiy data dir exists and data files are present.
    
    if (!file.exists("data")) {
        dir.create("data")
    }
    if (!file.exists(dataset.2016_final)) {
        download.file(dataset.2016_final_url, dataset.2016_final, method = "curl")
    }
    if (!file.exists(dataset.2016_splits)) {
        download.file(dataset.2016_splits_url, dataset.2016_splits, method = "curl")
    }
}

##
## Support function to retrieve data sets
##
datasets <- list(c("2015_final.html",
                   "http://www.coolrunning.com/results/15/vt/Jul19_VT100E_set1.shtml"),
                 c("2015_splits.html",
                   "http://www.coolrunning.com/results/15/vt/Jul19_VT100E_set2.shtml"),
                 c("2016_final.html", 
                   "http://www.coolrunning.com/results/16/vt/Jul17_VT100E_set4.shtml"),
                 c("2016_splits.html",
                   "http://www.coolrunning.com/results/16/vt/Jul17_VT100E_set6.shtml"))

aid <- "https://docs.google.com/spreadsheets/d/19UDxQuK5WummNLvVgodsoPnSNRaVh2vBWr-f6lCYkDw/pubhtml"

GetDataSets <- function() {
    ## Verifiy data dir exists and data files are present.
    
    # core results (splits and finals)
    if (!file.exists("data")) {
        dir.create("data")
    }
    for (ds in datasets) {
        fp <- file.path("data", ds[1])
        if (!file.exists(fp)) {
            download.file(ds[2], fp, method = "curl")
        }
    }
    # aid station list
    fp <- file.path("data", "aid_stations.html")
    if (!file.exists(fp)) {
        download.file(aid, fp, method = "curl")
    }
}



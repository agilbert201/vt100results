library(stringr)
library(lubridate)

#
# Given string rep in hh:mm form, i.e. 2:00 or 14:23 convert to duration
convert_to_duration <- function(dur) {
    if (str_length(dur) < 1) {
        return(NA)
    }
    parts <- unlist(str_split(dur, ":"))
    if (length(parts) < 2) {
        return(NA)
    }
    hrs <- as.integer(parts[1])
    mins <- as.integer(parts[2])
    secs <- hrs * 60 * 60 + mins * 60
}
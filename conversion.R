library(stringr)

# Iterate over cells in each row and given "time of day" rep in hh:mm form convert to 
# duration in minutes. Note starts with dataframe and does for loops as needs prev context
# and is processing across the row. I have no idea how to do this in "col/vector" way...

# DONT USE? Do it by columns with adjustments for out of band vals
time_of_day_to_duration <- function(df) {
    for(r in c(1:nrow(df))) {
        base_hour <- 4 # 4:00 am start
        noon_cross <- 8 * 60
        midnight_cross <- 20*60
        hour_adj <- 0 # 12 if dur > 8*60, 24 for dur > 20*60
        for(c in c(4:22)) {
            t <- df[r,c]
            parts <- unlist(str_split(t, ":"))
            if (length(parts) < 2) {
                df[r,c] <- NA
                next
            }
            hr <- as.integer(parts[1])
            if (hour_adj == 0 && hr < 4) {
                hour_adj <- 12
                hr = hr + hour_adj
            }
            # DANG - doesn't work
            min <- as.integer(parts[2])
            dur <- (hr - base_hour) * 60 + min
            if (dur > midnight_cross && hour_adj == 12) { hour_adj <- 24 }
            df[r,c] <- dur
        }
    }
    df
}

#
# for 2016 splits, convert "time" to total elapsed time in minutes (duration)
#
convert_time_to_duration <- function(time) {
    as_dur <- convert_to_duration(time)
    if (!is.na(as_dur)) {
        as_dur <- as_dur - 240 # 4am baseline
        if (as_dur < 0) { as_dur <- NA}
    }
    as_dur
}

# Given string rep in hh:mm form, i.e. 2:00 or 14:23 convert to duration in minutes
convert_to_duration <- function(dur) {
    if (str_length(dur) < 1) {
        return(NA)
    }
    parts <- unlist(str_split(dur, ":"))
    if (length(parts) < 2) {
        return(NA)
    }
    hrs <- as.integer(parts[1])
    mins <- as.integer(parts[2]) + hrs * 60
}

apply_conversion <- function(col) {
    sapply(col, convert_to_duration, USE.NAMES = FALSE)
}
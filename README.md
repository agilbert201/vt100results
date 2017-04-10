
TODO

Fix time col in finals table, clean finals

2015 splits, clean up out of band (12 hour) values
2016 splits, change time of day to duration and convert

if next col goes down, na it
if next col goes up by more than 1200 subtract 1200

setMethod("show", "Duration", function(object) print("foo"))
setMethod("show", "Duration", function(object) print(object@.Data))

asMins <- object@.Data %/% 60
hours <- asMins %/% 60
mins <- asMins %% 60


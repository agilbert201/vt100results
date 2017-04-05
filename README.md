
TODO

Fix time col in finals table, clean finals

Convert to numeric 2015 splits, clean up out of band (12 hour) values

setMethod("show", "Duration", function(object) print("foo"))
setMethod("show", "Duration", function(object) print(object@.Data))

asMins <- object@.Data %/% 60
hours <- asMins %/% 60
mins <- asMins %% 60
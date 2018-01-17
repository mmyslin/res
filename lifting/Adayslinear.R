rm(list=ls())

# Set up data

library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con1 <- dbConnect(drv, host="markdbinstance.cyld5xllawz7.us-west-2.rds.amazonaws.com", 
                  port="5432",
                  dbname="markdb", 
                  user="mmyslin", 
                  password="hbdata8899")

#buildMotionOutcome = dbGetQuery(con1, paste(scan(file="/Users/markmyslin/Google Drive/Skunkworks/MTDmodelGranular/SQLQueries/dismiss_motion_opinion.sql", what="char", sep="\n"), collapse=" "))

mark_lift_a = dbGetQuery(con1, "select * from lift_a")
mark_lift_a$date = as.Date(mark_lift_a$date, format="%T %F")

mark_lift_a = mark_lift_a[order(mark_lift_a$date),]
andersen_lift_a = dbGetQuery(con1, "select * from lift_a_andersen")
andersen_lift_a$date = as.Date(andersen_lift_a$date, format="%F")

head(mark_lift_a)


plot(mark_lift_a$date, mark_lift_a$flat_bench, bg="tomato", pch = 24, col=NA,
     type="n", xlim=c(mark_lift_a$date[1], max(mark_lift_a$date)))

flat = data.frame(x = c(head(mark_lift_a$date, 1), mark_lift_a$date, tail(mark_lift_a$date,1)), y = c(0, mark_lift_a$flat_bench, 0))
polygon(x = flat$x, y =flat$y , col=adjustcolor("red",alpha.f=0.55), border=NA)

decline = data.frame(x=c(mark_lift_a$date[156], mark_lift_a$date[156:length(mark_lift_a$decline_bench)], tail(mark_lift_a$date,1)), y =  c(0, mark_lift_a$decline_bench[156:length(mark_lift_a$decline_bench)], 0))
polygon(x = decline$x, y = decline$y, col=adjustcolor("orangered",alpha.f=0.5), border=NA)




which(is.na(mark_lift_a$decline_bench))
mark_lift_a[320,]

is.na(mark_lift_a$decline_bench)

points(mark_lift_a$date, mark_lift_a$decline_bench, bg="magenta", pch=25, col=NA)

offset = head(andersen_lift_a$date, 1) -head(mark_lift_a$date, 1)

points(andersen_lift_a$date-offset, andersen_lift_a$flat_bench, bg="tomato4", pch=24, col=NA)
points(andersen_lift_a$date-offset, andersen_lift_a$decline_bench, bg="darkmagenta", col=NA, pch=25)
points(head(mark_lift_a$date, 1),100)

as.numeric(head(mark_lift_a$date, 2))

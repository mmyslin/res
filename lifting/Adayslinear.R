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
mark_lift_a$date = as.Date(mark_lift_a$string_date, format="%T %F")


andersen_lift_a = dbGetQuery(con1, "select * from lift_a_andersen")
andersen_lift_a$date = as.Date(andersen_lift_a$string_date, format="%F")

head(mark_lift_a)


plot(mark_lift_a$date, mark_lift_a$flat_bench, bg="tomato", pch = 24, col=NA)
points(mark_lift_a$date, mark_lift_a$decline_bench, bg="magenta", pch=25, col=NA)

offset = head(andersen_lift_a$date, 1) -head(mark_lift_a$date, 1)

points(andersen_lift_a$date-offset, andersen_lift_a$flat_bench, bg="tomato4", pch=24, col=NA)
points(andersen_lift_a$date-offset, andersen_lift_a$decline_bench, bg="darkmagenta", col=NA, pch=25)
points(head(mark_lift_a$date, 1),100)

as.numeric(head(mark_lift_a$date, 2))

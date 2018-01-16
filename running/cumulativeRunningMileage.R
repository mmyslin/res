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

mark_run = dbGetQuery(con1, "select * from run")
mark_run$date = as.Date(mark_run$date, format="%F %T")
mark_run = mark_run[order(mark_run$date),]
tail(mark_run)

cr2017 = mark_run[mark_run$date < as.Date("2018-01-01") & mark_run$date > as.Date("2016-12-31"), ]
crtotal17 = vector()
for(i in 1:length(cr2017$trip_miles)){
  crtotal17[i] = sum(cr2017$trip_miles[1:i])
}

datemax = cr2017$date[15]
milemax = 125
plot(cr2017$date, crtotal17, ylim=c(0,milemax), xlim=c(cr2017$date[1], datemax), type="b")
grid(nx=datemax - cr2017$date[1]+1, ny=milemax/5)
text(datemax-1, 0, datemax)
as.numeric(cr2017$date[1])

cr2018 = mark_run[mark_run$date < as.Date("2019-01-01") & mark_run$date > as.Date("2017-12-31"), ]
crtotal18 = vector()
for(i in 1:length(cr2018$trip_miles)){
  crtotal18[i] = sum(cr2018$trip_miles[1:i])
}
points(cr2018$date-365, crtotal18, col="green", type="b")
abline(v=Sys.Date()-365.5, col="gray")
crtotal18

#----DM----
library(nycflights13)
library(tidyverse)
nycflights13::flights
?flights
dfl <- flights
str(dfl)
#----filter----

#Find all flights that
head(dfl)
names(dfl)
#Had an arrival delay of two or more hours
filter(dfl,arr_delay>2)
#Flew to Houston (IAH or HOU)
filter(dfl,dest=='IAH'|dest=='HOU')
filter(dfl,dest%in%c('IAH','HOU'))
#Were operated by United, American, or Delta
filter(dfl,carrier=='UA'|carrier=='AA'|carrier=='DL')
filter(dfl,carrier%in%c('UA','AA','DL'))
#Departed in summer (July, August, and September)
filter(dfl,month==7|month==8|month==9)
filter(dfl,month%in%c(7,8,9))
#Arrived more than two hours late, but didn't leave late
filter(dfl,arr_delay>120 & dep_delay<=0)
#Were delayed by at least an hour, but made up over 30 minutes in flight

#Departed between midnight and 6am (inclusive)





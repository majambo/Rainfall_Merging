library(reshape2)
library(reshape)
library(tidyverse)
library(forcats)
library(EcotoneFinder)

################################################################################################################
#Prepare dekadal station rainfall data
################################################################################################################
rain<-read.csv("superceded/Master Station_Dekads_June2020.csv")
rain<-rain[,c(2:4,6:42)]

r<-reshape2::melt(rain, id = c("STATION.ID", "LAT", "LONG", "YEAR"))

################################################################################################################
#Add dekadal and month column
################################################################################################################
r1<-r %>%
  mutate(
    dekade=fct_collapse(
      .f=variable,
      "1" = c("X01.Jan","X01.Feb","X01.Mar","X01.Apr","X01.May","X01.Jun","X01.Jul","X01.Aug","X01.Sep","X01.Oct","X01.Nov","X01.Dec"),
      "2" = c("X02.Jan","X02.Feb","X02.Mar","X02.Apr","X02.May","X02.Jun","X02.Jul","X02.Aug","X02.Sep","X02.Oct","X02.Nov","X02.Dec"),
      "3" = c("X03.Jan","X03.Feb","X03.Mar","X03.Apr","X03.May","X03.Jun","X03.Jul","X03.Aug","X03.Sep","X03.Oct","X03.Nov","X03.Dec")
    )
  )

r2 <- r1 %>%
  mutate(
    month=fct_collapse(
      .f=variable,
      "1" = c( "X01.Jan","X02.Jan","X03.Jan"),
      "2" = c( "X01.Feb","X02.Feb","X03.Feb"),
      "3" = c( "X01.Mar","X02.Mar","X03.Mar"),
      "4" = c( "X01.Apr","X02.Apr","X03.Apr"),
      "5" = c( "X01.May","X02.May","X03.May"),
      "6" = c( "X01.Jun","X02.Jun","X03.Jun"),
      "7" = c( "X01.Jul","X02.Jul","X03.Jul"),
      "8" = c( "X01.Aug","X02.Aug","X03.Aug"),
      "9" = c( "X01.Sep","X02.Sep","X03.Sep"),
      "10" = c( "X01.Oct","X02.Oct","X03.Oct"),
      "11" = c( "X01.Nov","X02.Nov","X03.Nov"),
      "12" = c( "X01.Dec","X02.Dec","X03.Dec")
    )
  )   

##r <- melt.bwb2[,c(2:5,7:9)]
##r2 <- arrange.vars(r, c("STATION.ID"=1,"LONG"=2,"LAT"=3,"Month"=5,"dekade"=6))

################################################################################################################
#Rename and rearrange columns
################################################################################################################
r3 <- r2 %>% 
  rename(stationID=STATION.ID,
         Longitude=LONG,
         Latitude=LAT, 
         Year=YEAR,
         Dekad=dekade, 
         Rainfall=value,
         Month=month)

r3 <- arrange.vars(r3, c("stationID"=1,"Longitude"=2,"Latitude"=3,"Month"=5,"Dekad"=6))
r4<-r3[,c(1:6,8)]
r4[is.na(r4)] <- -9999

write.csv(r4,"Master_Station_Dekads_June2021.csv")

################################################################################################################

#Prepare monthly station rainfall data
m<-read.csv("BWB_MonRainfall_QC.csv")
m<-m[,c(1,3:17)]
m1<-reshape2::melt(m, id = c("Station_ID", "Longitude", "Latitude", "Year"))

m2 <- m1 %>% 
  rename(Month=variable,
         Rainfall=value)

m3 <- m2 %>%
  mutate(
    month=fct_collapse(
      .f=Month,
      "1" = c( "Jan"),
      "2" = c( "Feb"),
      "3" = c( "Mar"),
      "4" = c( "Apr"),
      "5" = c( "May"),
      "6" = c( "Jun"),
      "7" = c( "Jul"),
      "8" = c( "Aug"),
      "9" = c( "Sep"),
      "10" = c( "Oct"),
      "11" = c( "Nov"),
      "12" = c( "Dec")
    )
  )   

write.csv(m3,"Master_Station_months_June2021.csv")

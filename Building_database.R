library(reshape2)
install.packages("reshape")
library(reshape)
install.packages("tidyverse")


#dekadal
rain<-read.csv("Master Station_Dekads_June2020.csv")
rain<-rain[,c(1:5,7:8)]

melt.bwb<-reshape2::melt(rain, id = c("STATION.NAME","STATION.ID", "LAT", "LONG", "YEAR"))

install.packages("tidyverse")
library(tidyverse)
install.packages("forcats")
library(forcats)
install.packages("EcotoneFinder")
library(EcotoneFinder)

melt.bwb1<-melt.bwb %>%
  mutate(
    dekade=fct_collapse(
      .f=variable,
      "1" = c("X01.Jan","X01.Feb","X01.Mar","X01.Apr","X01.May","X01.Jun","X01.Jul","X01.Aug","X01.Sep","X01.Oct","X01.Nov","X01.Dec"),
      "2" = c("X02.Jan","X02.Feb","X02.Mar","X02.Apr","X02.May","X02.Jun","X02.Jul","X02.Aug","X02.Sep","X02.Oct","X02.Nov","X02.Dec"),
      "3" = c("X03.Jan","X03.Feb","X03.Mar","X03.Apr","X03.May","X03.Jun","X03.Jul","X03.Aug","X03.Sep","X03.Oct","X03.Nov","X03.Dec")
    )
  )

r <- melt.bwb2[,c(2:5,7:9)]
r2 <- arrange.vars(r, c("STATION.ID"=1,"LONG"=2,"LAT"=3,"Month"=5,"dekade"=6))

r3 <- r2 %>% 
  rename(stationID=STATION.ID,
         Longitude=LONG,
         Latitude=LAT, 
         Year=YEAR,
         Dekade=dekade, 
         Rainfall=value)

write.csv(r3,"Master Station_Dekads_June2021.csv")

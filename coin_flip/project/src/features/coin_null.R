library(data.table)
setwd("C:/Users/Shashank/Desktop/Personal Data/Penn State/Classes/Semester 8/Stat 380/coin_flip-project2/coin_flip")
null_m<-fread("./project/volume/data/processed/null.csv")

null_m$result = 0.5

fwrite(null_m,file = "project/volume/data/processed/null.csv")
#set working directory
setwd("C:/Users/ajays/Desktop/Springboard/Ex_2")

#load packages
library(dplyr)
library(stringr)
library(tidyr)

#Read and load the csv file as a local data frame table
temp <- read.csv("titanic_original.csv", sep = ",", header = TRUE)
data <- tbl_df(temp)
rm(temp)

#Replace missing values with S in emabrked column
data$embarked[data$embarked == ""] <- c("S")

#Replace missing values in age column with mean
data$age[data$age == ""] <- c("NA")
data$age[which(is.na(data$age))] <- mean(as.numeric(data$age), na.rm = TRUE)

#Replace missing boat values with NA
data$boat[data$boat == ""] <- c("NA")

#assign binary for cabin numbers
data <- mutate(data, has_cabin_number = NA)
data$has_cabin_number[which(is.na(data$cabin))] <- 0
data$has_cabin_number[which(!is.na(data$cabin))] <- 1

#write cleaned CSV file
write.csv(data, file = "titanic_clean.csv")

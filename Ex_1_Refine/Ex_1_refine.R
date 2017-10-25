#Load Packages
library(dplyr)
library(tidyr)

#Set working directory
setwd ("C:/Users/ajays/Desktop/Springboard")

#Read and load the csv file as a local data frame table
temp <- read.csv("refine_original.csv", sep = ",", header = TRUE)
dtbl <- tbl_df(temp)
rm(temp)

#Clean company names
dtbl$company <-gsub("\\w+ps$", "philips", dtbl$company, ignore.case = TRUE)
dtbl$company <-gsub("^ak\\s*\\w+", "akzo", dtbl$company, ignore.case = TRUE)
dtbl$company <-gsub("^van\\s\\w+", "van houten", dtbl$company, ignore.case = TRUE)
dtbl$company <-gsub("^un\\w+", "unilever", dtbl$company, ignore.case = TRUE)

colnames(dtbl)[2] <- c("ProductID")  #rename product number column

#Split product code and number
dtbl <- separate(dtbl, ProductID, c("product_code",'product_number'), sep = "-")

#concatenate address
dtbl <- unite(dtbl,full_address,address,city,country, sep = ",")

#Assign product categories
dtbl <- mutate(dtbl, product_category = NA)  #initialize product category column
dtbl$product_category[dtbl$product_code == "p"] <- c("Smartphone")
dtbl$product_category[dtbl$product_code == "x"] <- c("Laptop")
dtbl$product_category[dtbl$product_code == "v"] <- c("TV")
dtbl$product_category[dtbl$product_code == "q"] <- c("Tablet)

#Create binary columns
dtbl <- dtbl %>%
  mutate(company_philips = if_else(company=="philips", 1, 0)) %>%
  mutate(company_akzo = if_else(company=="akzo", 1, 0)) %>%
  mutate(company_van_houten = if_else(company=="van houten", 1, 0)) %>%
  mutate(company_unilever = if_else(company=="unilever", 1, 0)) %>%
  mutate(product_smartphone = if_else(product_code=="p", 1, 0)) %>%
  mutate(product_tv = if_else(product_code=="v", 1, 0)) %>%
  mutate(product_laptop = if_else(product_code=="x", 1, 0)) %>%
  mutate(product_tablet = if_else(product_code=="q", 1, 0))

#Write cleaned file
write.csv(dtbl, file = "refine_clean.csv")

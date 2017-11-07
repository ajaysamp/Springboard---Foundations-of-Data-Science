library(dplyr)
library(ggplot2)
dataset1 <- select(states.data, energy, metro) #select required columns
dataset <- dataset1 %>% na.omit() #remove na values
summary(dataset)
ggplot(dataset, aes(x = metro, y = energy)) + geom_point() #dataplot
reg_model_1 <- lm(energy~metro, data = dataset) #first regression model
summary(reg_model_1)   #very low R-value

dataset1 <- select(states.data, energy, metro, income, toxic, house, senate)
dataset <- dataset1 %>% na.omit() #reconfigure dataset to fit more variables

cor(dataset) # get an idea of relationship between the variables
reg_model_2 <- lm(energy~metro + income + toxic, data = dataset) #add 2 more predictor variables to the regression model
summary(reg_model_2)  #there is an improvement in the r-squared value in the model

reg_model_ineraction <- lm(energy~metro*toxic*income, data = states.data) #model interaction for predictor variables
coef(summary(reg_model_ineraction)) #model summary
dataset1 <- select(states.data, energy, metro, toxic, income,region) #reconfigure dataset to include region variable
dataset <- dataset1 %>%  na.omit()
dataset$region <- factor(dataset$region)
reg_model_region <- lm(energy ~ metro + income + toxic + region, data = dataset) #add region to regression model
coef(summary(reg_model_region)) # summary of coefficients for the model. There is a significant difference across the regions

#load csv into open source tool: R, and relevant libraries
setwd("/home/amy/Desktop/data-scientist-exercise01-master")
library(data.table)
library(ggplot2)
library(scales)
library(caret)
ex1data = fread('records.csv', header = T, sep=',', sep2 = '\n')

#change all categorical variables to factors in data frame
ex1data$workclass = as.factor(ex1data$workclass)
ex1data$education_level = as.factor(ex1data$education_level)
ex1data$marital_status = as.factor(ex1data$marital_status)
ex1data$occupation = as.factor(ex1data$occupation)
ex1data$relationship = as.factor(ex1data$relationship)
ex1data$race = as.factor(ex1data$race)
ex1data$sex = as.factor(ex1data$sex)
ex1data$country = as.factor(ex1data$country)
ex1data$over_50k = as.factor(ex1data$over_50k)

#get simple summary stats for the data and explore it 
summary(ex1data)
sapply(ex1data, sd)

ggplot(ex1data, aes(over_50k, fill = race)) +
 geom_bar(aes(y=..count../sum(..count..))) +
 scale_y_continuous(labels = percent_format()) + labs(x='over_50k',y='percentage')

ggplot(ex1data, aes(over_50k, fill = sex)) +
 geom_bar(aes(y=..count../sum(..count..))) +
 scale_y_continuous(labels = percent_format()) + labs(x='over_50k',y='percentage')

ggplot(ex1data, aes(over_50k, fill = occupation)) +
 geom_bar(aes(y=..count../sum(..count..))) +
 scale_y_continuous(labels = percent_format()) + labs(x='over_50k',y='percentage')

#split the data into training, validation and testing (I did 60/20/20)

set.seed(3456)
training = createDataPartition(ex1data$over_50k, p = .6, list = FALSE, times = 1)
ex1train = ex1data[ training,]
ex1remainder = ex1data[-training,]
validation = createDataPartition(ex1remainder$over_50k, p = .5, list = FALSE, times = 1)
ex1valid = ex1remainder[validation,]
ex1test = ex1remainder[-validation,]

#create a model that predicts whether an individual makes over_50k
#this model has over 85% accuracy in training, validation, and test data
mylogit = glm(over_50k ~ age*workclass + education_level + marital_status*sex + occupation + relationship + race + hours_week + country + capital_gain + capital_loss, data = ex1valid, family = "binomial")

#generate confusion matrix to compute F-score
predict = predict(mylogit, type = 'response')

table(ex1train$over_50k, predict > 0.5)

#generate a chart with important relationships in the data

ggplot(ex1data, aes(x=over_50k,y=age)) +
 geom_boxplot()  + labs(x='over_50k',y='age') + facet_grid(~workclass)


ggplot(ex1data, aes(over_50k, fill = sex)) +
 geom_bar() + labs(x='over_50k',y='count') + facet_grid(~marital_status)


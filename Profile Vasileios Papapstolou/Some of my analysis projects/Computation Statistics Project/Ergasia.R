# Importing Libraries, some are unnecesary
library(readxl)
library(ggplot2)
library(GGally)
library("summarytools")
library(tidyverse)
library(psych)
library(skimr)
library(ggstatsplot)
library(broom)
library(jmv)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(AICcmodavg)
library(DescTools)
library(tree)

# Reading Data, EXCEL is much clearer
dataset <- read.csv("Cell_Phones_values.csv", sep=";", stringsAsFactors=TRUE)
dataset <- read_excel("Cell_Phones_values.xlsx")

dataset_labels <- read_excel("Cell_Phones_labels.xlsx")
attach(dataset)



# Generic overview of a data set, skim shows a lot of usefull stuff
view(dataset)
summary(dataset)
describe(dataset)
skim(dataset)

# Check columns data types
str(dataset)
dataset[,35] <- as.numeric(dataset[,35])

#Take cols
keeps <- c('psraid', 'usr_r', 'sex', 'age', 'mar', 'educ', 'empl', 'inc', 'mobileprice')
main_df <- dataset[c('psraid', 'usr_r', 'sex', 'age', 'mar', 'educ', 'empl', 'inc', 'mobileprice')]
main_df <- main_df[complete.cases(main_df), ]

#Numeric values to Factor
hist(usr_r)
#names <- c(2, 5:8)
#main_df[,names] <- lapply(main_df[,names] , factor)
attach(main_df)
str(main_df)
summary(main_df)

# Some useful plots
hist(age)
hist(as.numeric(usr_r))
hist(mobileprice)

# Boxplots
boxplot(mobileprice~age)
boxplot(mobileprice~educ)
boxplot(mobileprice~sex)
boxplot(mobileprice~mar)
boxplot(mobileprice~mar)
boxplot(mobileprice~empl)
boxplot(mobileprice~inc)


# barplot between with 2 variables in x axis. Couldnt find something meaningful
barplot(tapply(mobileprice,list(sex, educ), mean), beside = T, col=c(2,7))

describe(main_df)

#QQLINE
qqnorm(mobileprice, main="Normal Q-Q Plot for size")
qqline(mobileprice)

qqnorm(age, main="Normal Q-Q Plot for size")
qqline(age)
qqline(log(age))

#Some insights
tapply(mobileprice, sex, mean)
tapply(mobileprice, educ, mean)
tapply(mobileprice, inc, mean)
tapply(mobileprice, empl, mean)
tapply(mobileprice, mar, mean)

#Negative relationship. 
plot(tapply(mobileprice, age, mean), xlab = "age", ylab = "mean mobile price")

# Positive relationship
plot(tapply(mobileprice, educ, mean), xlab = "educ", ylab = "mean mobile price")

plot(tapply(mobileprice, empl, mean), xlab = "empl", ylab = "mean mobile price")

plot(tapply(mobileprice, inc, mean), xlab = "inc", ylab = "mean mobile price")


# Bootstrap for mobile prices
mobprice <- numeric(10000)
for (i in 1:10000) {
  mobprice[i] <- mean(sample(mobileprice,length(mobileprice),replace=T))}
hist(mobprice)
quantile(mobprice,c(0.025,0.975))
abline(v=quantile(mobprice, 0.025),col="red")
abline(v=quantile(mobprice,0.975),col="purple")

#Diasthma empistosynhs
#2.5%    97.5% 
#201.7794 205.9955 

#Correlation between mobileprice and main_df cols. Spearman method cause both values are numeric. 
#Negative relationship
cor(main_df,method="spearman")
cor.test(mobileprice, age, method = "spearman")

#Kendal cause we have ordinal x-value
cor.test(mobileprice, inc, method = "kendal")
cor.test(mobileprice, usr_r, method = "kendal")
cor.test(mobileprice, as.numeric(sex), method = "kendal")
cor.test(mobileprice, educ, method = "kendal")
cor.test(mobileprice, empl, method = "kendal")



# Standart Plots for target Variables
table(sex)
barplot(table(sex))
plot(mobileprice,sex)
boxplot(mobileprice~sex,horizontal=TRUE)

# Detailed ôéscatter plot
corrMatrix(main_df, vars(sex, mobileprice),
           ci = T,
           plots = T,
           plotDens = T)

ggstatsplot::ggscatterstats(dataset,
                            x = mobileprice,
                            y = sex)

# Run correlation
cor.test(mobileprice,as.numeric(sex),alternative = "two.sided",method="kendall")

# Run ANOVA
one.way <- aov(mobileprice~sex, data = main_df)
summary(one.way)

one.way <- aov(mobileprice~usr_r, data = main_df)
summary(one.way)

one.way <- aov(mobileprice~educ, data = main_df)
summary(one.way)

one.way <- aov(mobileprice~inc, data = main_df)
summary(one.way)

one.way <- aov(mobileprice~empl, data = main_df)
summary(one.way)

one.way <- aov(mobileprice~mar, data = main_df)
summary(one.way)

one.way <- aov(mobileprice~age, data = main_df)
summary(one.way)


# Alternative run ANOVA
model <-aov(mobileprice~sex * age * inc * mar * usr_r)
summary(model)
summary.lm(model)# Oi sysxetiseis metaksy twn aneksarthtw metablhtwn fainetai na einai useless

model2 <-aov(mobileprice~sex + age + inc + mar + usr_r)
summary(model2)
summary.lm(model2)
#Married useless

model3 <-aov(mobileprice~age + inc + usr_r)
summary(model3)
summary.lm(model3)



# Post Hoc Test
PostHocTest(aov(mobileprice~factor(sex)), method="hsd")
PostHocTest(aov(mobileprice~factor(educ)),method="hsd")
PostHocTest(aov(mobileprice~factor(inc)),method="hsd")
#Se ola ta parapanw h monh sysxetish pou brethike anamesa sta epipeda htan sto income. 
#Dokimazoume alla tests

#Very important tree model 
#Xwris to psraid (id) giati to vazei kai auto sto dendro enw den dhlwnei kati
model<-tree(mobileprice~.,data=main_df[,2:8])  
plot(model)
text(model)

# Used to combine unnecessary data, if any from ANOVA

# Fit into poisson/linear and possibly others to find the best match, if any
model<-glm(as.numeric(sex)~mobileprice, quasipoisson)
model<-lm(as.numeric(sex)~mobileprice)
summary(model)


model<-glm(mobileprice~educ, quasipoisson)
summary(model)

model<-glm(mobileprice~inc)
summary(model)

model<-glm(mobileprice~mar)
summary(model)

model<-glm(mobileprice~educ)
summary(model)

model<-glm(mobileprice~sex)
summary(model)


        
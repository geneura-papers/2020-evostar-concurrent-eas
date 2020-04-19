library(ggplot2)
library(ggthemes)
library(rstatix)
library(tidyverse)

data <- read.csv("lo-ppsn-dis-l60-p1024.csv")
data$Threads <- as.factor(data$Threads)
data$Evaluation.rate <- data$Evaluations/data$Time
data$Type <- as.factor(data$Type)
data.t <- as_tibble(data)
summaries <- data %>% group_by(Type,Threads) %>% summarise(medianE=median(Evaluations,na.rm=TRUE),medianT=median(Time,na.rm=TRUE),medianR=median(Evaluation.rate,na.rm=TRUE))
ggplot(data,aes(x=Threads,y=Evaluations,color=Type))+geom_tufteboxplot()+theme_tufte()
ggplot(data,aes(x=Threads,y=Time,color=Type))+geom_tufteboxplot()+theme_tufte()+scale_y_log10()
ggplot(data,aes(x=Threads,y=Evaluation.rate,color=Type))+geom_tufteboxplot()+theme_tufte()

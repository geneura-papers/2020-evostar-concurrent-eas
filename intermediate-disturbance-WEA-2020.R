## ----gens, cache=FALSE,echo=FALSE,message=FALSE,warning=FALSE-----------------
library(ggplot2)
library(ggthemes)
library(rstatix)
library(tidyverse)

data.raw <- read.csv("code/leading-ones-ppsn.csv")
data <- data.raw[data.raw$Type == "gen32-costart-i2" | data.raw$Type == "gen64-costart-i2" | data.raw$Type == "nodis",]
data$Threads <- as.factor(data$Threads)
data$Evaluation.rate <- data$Evaluations/data$Time
data$Type <- as.factor(data$Type)
ggplot(data,aes(x=Threads,y=Evaluations,color=Type))+geom_boxplot()+scale_y_log10() +geom_tufteboxplot()+theme_tufte()
ggsave("wea-evaluations-threads.png",width=8,height=6)

## ----dis, cache=FALSE,echo=FALSE,message=FALSE,warning=FALSE------------------
data <- data.raw[data.raw$Type == "dis" | data.raw$Type == "dis-v2" | data.raw$Type == "nodis",]
data$Threads <- as.factor(data$Threads)
data$Evaluation.rate <- data$Evaluations/data$Time
data$Type <- as.factor(data$Type)
ggplot(data,aes(x=Threads,y=Evaluations,color=Type))+geom_boxplot()+scale_y_log10() +theme_tufte()
ggsave("evosoft-evaluations-threads-2.png",width=8,height=6)

## ----vpvg, cache=FALSE,echo=FALSE,message=FALSE,warning=FALSE-----------------
data <- data.raw[data.raw$Type == "vp" | data.raw$Type == "vg" | data.raw$Type == "nodis",]
data$Threads <- as.factor(data$Threads)
data$Evaluation.rate <- data$Evaluations/data$Time
data$Type <- as.factor(data$Type)
ggplot(data,aes(x=Threads,y=Evaluations,color=Type))+geom_boxplot()+scale_y_log10() +theme_tufte()
ggsave("evosoft-evaluations-threads-3.png",width=8,height=6)


## ----vpvgt, cache=FALSE,echo=FALSE,message=FALSE,warning=FALSE----------------
ggplot(data,aes(x=Threads,y=Time,color=Type))+geom_boxplot()+scale_y_log10() +theme_tufte()
ggsave("evosoft-evaluations-threads-4.png",width=8,height=6)


## ----vpvge, cache=FALSE,echo=FALSE,message=FALSE,warning=FALSE----------------
ggplot(data,aes(x=Threads,y=Evaluation.rate,color=Type))+geom_boxplot()+scale_y_log10() +theme_tufte()
ggsave("evosoft-evaluations-threads-5.png",width=8,height=6)


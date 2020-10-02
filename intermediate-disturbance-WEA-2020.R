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
ggplot(data,aes(x=Threads,y=Evaluations,color=Type))+geom_boxplot()+scale_y_log10() #+geom_tufteboxplot()+theme_tufte()


## ----dis, cache=FALSE,echo=FALSE,message=FALSE,warning=FALSE------------------
data <- data.raw[data.raw$Type == "dis" | data.raw$Type == "dis-v2" | data.raw$Type == "nodis",]
data$Threads <- as.factor(data$Threads)
data$Evaluation.rate <- data$Evaluations/data$Time
data$Type <- as.factor(data$Type)
ggplot(data,aes(x=Threads,y=Evaluations,color=Type))+geom_boxplot()+scale_y_log10() #+geom_tufteboxplot()+theme_tufte()


## ----vpvg, cache=FALSE,echo=FALSE,message=FALSE,warning=FALSE-----------------
data <- data.raw[data.raw$Type == "vp" | data.raw$Type == "vg" | data.raw$Type == "nodis",]
data$Threads <- as.factor(data$Threads)
data$Evaluation.rate <- data$Evaluations/data$Time
data$Type <- as.factor(data$Type)
ggplot(data,aes(x=Threads,y=Evaluations,color=Type))+geom_boxplot()+scale_y_log10() #+geom_tufteboxplot()+theme_tufte()


## ----vpvgt, cache=FALSE,echo=FALSE,message=FALSE,warning=FALSE----------------
ggplot(data,aes(x=Threads,y=Time,color=Type))+geom_boxplot()+scale_y_log10() #+geom_tufteboxplot()+theme_tufte()


## ----vpvge, cache=FALSE,echo=FALSE,message=FALSE,warning=FALSE----------------
ggplot(data,aes(x=Threads,y=Evaluation.rate,color=Type))+geom_boxplot()+scale_y_log10() #+geom_tufteboxplot()+theme_tufte()


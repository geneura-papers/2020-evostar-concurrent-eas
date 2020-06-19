## ----setup, cache=FALSE,echo=FALSE--------------------------------------------
suppressPackageStartupMessages({
    library(ggplot2)
    library(ggthemes)
})


## ----laptop, cache=FALSE,echo=FALSE-------------------------------------------
data <- read.csv("code/lo-evosoft-results.csv")
data$Population <- as.factor(data$Population)
data$Threads <- as.factor(data$Threads)
data$Evaluation.rate <- data$Evaluations/data$Time
ggplot(data,aes(x=Threads,y=Evaluations,color=Population))+geom_tufteboxplot()+theme_tufte()


## ----laptop2, cache=FALSE,echo=FALSE------------------------------------------
ggplot(data,aes(x=Threads,y=Time,color=Population))+geom_tufteboxplot()+theme_tufte()+scale_y_log10()


## ----laptop3, cache=FALSE,echo=FALSE------------------------------------------
ggplot(data,aes(x=Threads,y=Evaluation.rate,color=Population))+geom_tufteboxplot()+theme_tufte()


## ----laptop4, cache=FALSE,echo=FALSE------------------------------------------
data <- read.csv("code/lo-evosoft-results-l60.csv")
data$Threads <- as.factor(data$Threads)
data$Evaluation.rate <- data$Evaluations/data$Time
ggplot(data,aes(x=Threads,y=Evaluations))+geom_tufteboxplot()+theme_tufte()


## ----laptop5, cache=FALSE,echo=FALSE------------------------------------------
ggplot(data,aes(x=Threads,y=Time))+geom_tufteboxplot()+theme_tufte()+scale_y_log10()


## ----laptop6, cache=FALSE,echo=FALSE------------------------------------------
ggplot(data,aes(x=Threads,y=Evaluation.rate))+geom_tufteboxplot()+theme_tufte()


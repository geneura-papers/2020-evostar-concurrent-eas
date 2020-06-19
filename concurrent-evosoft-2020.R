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
ggplot(data,aes(x=Threads,y=Evaluations,color=Population))+geom_tufteboxplot()+theme_tufte()+theme(axis.text=element_text(size=20), axis.title=element_text(size=24,face="bold"))
ggsave("evosoft-evaluations-threads.png",width=8,height=6)

## ----laptop2, cache=FALSE,echo=FALSE------------------------------------------
ggplot(data,aes(x=Threads,y=Time,color=Population))+geom_tufteboxplot()+theme_tufte()+scale_y_log10()+theme(axis.text=element_text(size=20), axis.title=element_text(size=24,face="bold"))
ggsave("evosoft-time-threads.png",width=8,height=6)


## ----laptop3, cache=FALSE,echo=FALSE------------------------------------------
ggplot(data,aes(x=Threads,y=Evaluation.rate,color=Population))+geom_tufteboxplot()+theme_tufte()+theme(axis.text=element_text(size=20), axis.title=element_text(size=24,face="bold"))
ggsave("evosoft-rate-threads.png",width=8,height=6)

## ----laptop4, cache=FALSE,echo=FALSE------------------------------------------
data <- read.csv("code/lo-evosoft-results-l60.csv")
data$Threads <- as.factor(data$Threads)
data$Evaluation.rate <- data$Evaluations/data$Time
ggplot(data,aes(x=Threads,y=Evaluations))+geom_tufteboxplot()+theme_tufte()+theme(axis.text=element_text(size=20), axis.title=element_text(size=24,face="bold"))
ggsave("evosoft-evaluations-threads-lo60.png",width=8,height=6)

## ----laptop5, cache=FALSE,echo=FALSE------------------------------------------
ggplot(data,aes(x=Threads,y=Time))+geom_tufteboxplot()+theme_tufte()+scale_y_log10()+theme(axis.text=element_text(size=20), axis.title=element_text(size=24,face="bold"))
ggsave("evosoft-time-threads-lo60.png",width=8,height=6)

## ----laptop6, cache=FALSE,echo=FALSE------------------------------------------
ggplot(data,aes(x=Threads,y=Evaluation.rate))+geom_tufteboxplot()+theme_tufte()+theme(axis.text=element_text(size=20), axis.title=element_text(size=24,face="bold"))
ggsave("evosoft-rate-threads-lo60.png",width=8,height=6)


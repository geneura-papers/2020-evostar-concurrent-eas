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
data$type.threads <- paste0(data$Type,data$Threads)
wilcox.test( data[data$type.threads=="vg8",]$Time, data[data$type.threads=="vp8",]$Time)
wilcox.df.e <- data.frame()
wilcox.df.t <- data.frame()

for (threads in c(2,4,6,8,10)) {
  this.w.e <- wilcox.test(data[data$type.threads==paste0("vg",threads),]$Evaluations, data[data$type.threads==paste0("vp",threads),]$Evaluations)
  wilcox.df.e <- rbind(wilcox.df.e,
                       data.frame(threads=threads,
                                  wilcoxon=this.w.e$p.value,
                                  significant= (this.w.e$p.value < 0.05)))
  this.w.t <- wilcox.test(data[data$type.threads==paste0("vg",threads),]$Time, data[data$type.threads==paste0("vp",threads),]$Time)
  wilcox.df.t <- rbind(wilcox.df.t,
                       data.frame(threads=threads,
                                  wilcoxon=this.w.t$p.value,
                                  significant= (this.w.t$p.value < 0.05)))
}

wilcox.df.n.e <- data.frame()
wilcox.df.n.t <- data.frame()

for (threads in c(2,4,6,8)) {
  this.w.e <- wilcox.test(data[data$type.threads==paste0("nodis",threads),]$Evaluations, data[data$type.threads==paste0("vp",threads),]$Evaluations)
  wilcox.df.n.e <- rbind(wilcox.df.n.e,
                       data.frame(threads=threads,
                                  wilcoxon=this.w.e$p.value,
                                  significant= (this.w.e$p.value < 0.05)))
  this.w.t <- wilcox.test(data[data$type.threads==paste0("nodis",threads),]$Time, data[data$type.threads==paste0("vp",threads),]$Time)
  wilcox.df.n.t <- rbind(wilcox.df.n.t,
                       data.frame(threads=threads,
                                  wilcoxon=this.w.t$p.value,
                                  significant= (this.w.t$p.value < 0.05)))
}

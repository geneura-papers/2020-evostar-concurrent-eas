library(ggplot2)
library(ggthemes)

data <- read.csv("lo-ppsn-dis-l60-p1024.csv")
data$Threads <- as.factor(data$Threads)
data$Evaluation.rate <- data$Evaluations/data$Time
ggplot(data,aes(x=Threads,y=Evaluations,color=Type))+geom_tufteboxplot()+theme_tufte()
ggplot(data,aes(x=Threads,y=Time,color=Type))+geom_tufteboxplot()+theme_tufte()+scale_y_log10()
ggplot(data,aes(x=Threads,y=Evaluation.rate,color=Type))+geom_tufteboxplot()+theme_tufte()

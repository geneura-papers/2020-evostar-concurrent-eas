library(ggplot2)
library(ggthemes)

data <- read.csv("lo-evosoft-results-l60.csv")
data$Population <- as.factor(data$Population)
data$Threads <- as.factor(data$Threads)
data$Evaluation.rate <- data$Evaluations/data$Time
ggplot(data,aes(x=Threads,y=Evaluations,color=Population))+geom_tufteboxplot()+theme_tufte()
ggplot(data,aes(x=Threads,y=Time,color=Population))+geom_tufteboxplot()+theme_tufte()+scale_y_log10()
ggplot(data,aes(x=Threads,y=Evaluation.rate,color=Population))+geom_tufteboxplot()+theme_tufte()

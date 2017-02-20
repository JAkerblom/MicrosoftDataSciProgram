setwd("MicrosoftDataSciProgram/DataSci Essentials (DAT203.1x)/ModExam scripts/")
dat <- read.csv("DataSciEssentials Final Exam - 506153734175476c4f62416c57734963.faa6ba63383c4086ba587abf26b85814.v1-default-1643 - Results dataset.csv", header = TRUE, stringsAsFactors = FALSE)

head(dat)
str(dat)

summary(dat)
sd(dat$ArrDelay)

#install.packages('gridExtra')
plotstats <- function(df, col, bins = 30){
  require('ggplot2')
  require('gridExtra')
  datl = as.factor('') ## Not sure what this does
  
  ## Compute bin width
  bin.width = (max(df[, col]) - min(df[, col]))/ bins
  
  ## Plot a histogram
  p1 = ggplot(df, aes_string(col)) +
    geom_histogram(binwidth = bin.width)
  
  ## A simple boxplot
  p2 = ggplot(df, aes_string(datl, col)) +
    geom_boxplot() + coord_flip() + ylab('')
  
  ## Now stack the plots
  grid.arrange(p2, p1, nrow = 2)
}

plotstats(dat, 'ArrDelay')

auto.hist <- function(x) {
  #library(ggplot2)
  #library(gridExtra)
  require('ggplot2')
  require('gridExtra')
  
  rg = range(dat[,x])
  bw = (rg[2] - rg[1])/30
  
  title <- paste("Histogram of", x, "conditioned on")
  
  ggplot(dat, aes_string(x)) +
    geom_histogram(aes(y = ..count..), binwidth = bw) +
    facet_grid(. ~ ArrDel15) +
    ggtitle(title)
}

cols <- c("DepDelay",
          "CRSArrTime",
          "CRSDepTime",
          "DayofMonth",
          "DayOfWeek",
          "Month")

lapply(cols, auto.hist)

vis.conditional.scatter <- function(x){
  require(ggplot2)
  ## convert character columns to factors for plotting
  #auto.price[, "outlier"] <- as.factor(auto.price[, "outlier"])    
  #auto.price[, "fuel.type"] <- as.factor(auto.price[, "fuel.type"])    
  
  title = paste('Plot of', x, 'vs. ArrDel15') # character string title
  ggplot(dat, aes_string(x, 'ArrDel15')) +
    geom_point(aes(color = ArrDel15, 
                   #shape = fuel.type, 
                   alpha = 0.5, size = 4)) +
    ggtitle(title)
}

lapply(cols, vis.conditional.scatter)  # plot the results

vis.conditional.scatter3 <- function(x){
  require(ggplot2)
  ## convert character columns to factors for plotting
  dat[, "ArrDel15"] <- as.factor(dat[, "ArrDel15"])    
  #auto.price[, "fuel.type"] <- as.factor(auto.price[, "fuel.type"])    
  for(col in cols) {
    title = paste('Plot of', x, 'vs. ', col) # character string title
    #print(title)
    ggplot(dat, aes_string(x, col)) +
      geom_point(aes(color = ArrDel15, 
                     #shape = fuel.type, 
                     alpha = 0.5, size = 4)) +
      ggtitle(title)
  }
}

lapply(cols, vis.conditional.scatter3)

vis.conditional.scatter4 <- function(x, y){
  require(ggplot2)
  ## convert character columns to factors for plotting
  dat[, "ArrDel15"] <- as.factor(dat[, "ArrDel15"])    
  #auto.price[, "fuel.type"] <- as.factor(auto.price[, "fuel.type"])    
  
  title = paste('Plot of', x, 'vs. ', y) # character string title
  #print(title)
  ggplot(dat, aes_string(x, y)) +
    geom_point(aes(color = ArrDel15, 
                   #shape = fuel.type, 
                   alpha = 0.5, size = 4)) +
    ggtitle(title)
}

vis.conditional.scatter4("ArrDelay", "Month")
vis.conditional.scatter4("DepDelay", "ArrDelay")
vis.conditional.scatter4("ArrDelay", "DayOfMonth")
vis.conditional.scatter4("ArrDelay", "CRSDepTime")
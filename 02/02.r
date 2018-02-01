#axa171831                      #HW2
#Advanced business Analytics Using R
####################################

# Mandatory line
# setwd("c:/data/BUAN6357/HW_2"); source("prep.txt", echo=T)

# Clearing the workspace
rm(list=ls(all=TRUE))

# Installing libraries
library(reshape); library(tidyverse); library(broom); library(data.table)

# Set seed to 1 for replication
set.seed(1)

# Parameters
# number of replications
n  <- 5000
# probability a segment works correctly
p  <- 0.9

# t1 will generate a series of numbers from 0-9 and
# then repeat the series 5,000 times. For a total of
# 50,000 values
t1 <- (rep(0:9, n))

# Correct patterns
t2 <- c(1,1,1,0,1,1,1,
        0,0,1,0,0,1,0,
        1,0,1,1,1,0,1,
        1,0,1,1,0,1,1,
        0,1,1,1,0,1,0,
        1,1,0,1,0,1,1,
        0,1,0,1,1,1,1,
        1,0,1,0,0,1,0,
        1,1,1,1,1,1,1,
        1,1,1,1,0,1,0)

t3 <- rep(t2, n)
t4 <- rbinom(length(t3), 1, 1-p)

# flip the bits [ t4 == 1 designates failure event ]
t5 <- ifelse(t4 == 1, 1-t3, t3)

# reshape
t5      <- matrix(t5, 10*n, 7, byrow=T)
dim(t1) <- c(length(t1), 1)
t6      <- cbind(t1, t5)
rawData      <- as.data.frame(t6)

colnames(rawData) <- c("digit", "s1", "s2", "s3", "s4", "s5", "s6", "s7")

# Extracting the first 250 samples of each digit
(raw250 <- rawData[1:2500,])

countData		<-	rawData	%>% group_by(digit,s1,s2,s3,s4,s5,s6,s7) %>% do(count(.)) %>% as.data.frame(.)
colnames(countData) <- c("digit", "s1", "s2", "s3", "s4", "s5", "s6", "s7","freq")
countData

# Remove temporary stuff
rm(t1,t2,t3,t4,t5,t6)

# Mandatory line
#source("validate.txt", echo=T)

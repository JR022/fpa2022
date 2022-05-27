#Remember to set the working directory!

#The used data is 'adjusted close'; column 6.  Each contains 251 values.
data_frame <- data.frame("AAPL"=read.csv("AAPL.csv")[6], "GOOGL"=read.csv("GOOGL.csv")[6], "INTC"=read.csv("INTC.csv")[6], "MSFT"=read.csv("MSFT.csv")[6], "NVDA"=read.csv("NVDA.csv")[6])
colnames(data_frame) = c('AAPL','GOOGL','INTC','MSFT','NVDA')

#Share price plots
plot(1:251,data_frame[1:251,1],type='l',xlab='Day',ylab='Price ($)',main='Share price of AAPL from\n April 2018 to April 2019')
plot(1:251,data_frame[1:251,2],type='l',xlab='Day',ylab='Price ($)',main='Share price of GOOGL from\n April 2018 to April 2019')
plot(1:251,data_frame[1:251,3],type='l',xlab='Day',ylab='Price ($)',main='Share price of INTC from\n April 2018 to April 2019')
plot(1:251,data_frame[1:251,4],type='l',xlab='Day',ylab='Price ($)',main='Share price of MSFT from\n April 2018 to April 2019')
plot(1:251,data_frame[1:251,5],type='l',xlab='Day',ylab='Price ($)',main='Share price of NVDA from\n April 2018 to April 2019')

#NASDAQ index plot
index_data <- read.csv("^IXIC.csv")
plot(1:251,index_data[1:251,6],type='l',xlab='Day',ylab='Price ($)',main='Price of NASDAQ composite index\n from April 2018 to April 2019')

#Future data
data_frame2 <- data.frame("AAPL"=read.csv("AAPL-future.csv")[6], "GOOGL"=read.csv("GOOGL-future.csv")[6], "INTC"=read.csv("INTC-future.csv")[6], "MSFT"=read.csv("MSFT-future.csv")[6], "NVDA"=read.csv("NVDA-future.csv")[6])
colnames(data_frame2) = c('AAPL','GOOGL','INTC','MSFT','NVDA')

#Future share price plots
par(mar=c(5,5,4,1)) #Margins of plot.
plot(1:149,data_frame2[1:149,1],type='l',xlab='Day',ylab='Price ($)',main='Share price of AAPL from\n May 2019 to December 2019',cex.lab=2,cex.main=2)
plot(1:149,data_frame2[1:149,2],type='l',xlab='Day',ylab='Price ($)',main='Share price of GOOGL from\n May 2019 to December 2019',cex.lab=2,cex.main=2)
plot(1:149,data_frame2[1:149,3],type='l',xlab='Day',ylab='Price ($)',main='Share price of INTC from\n May 2019 to December 2019',cex.lab=2,cex.main=2)
plot(1:149,data_frame2[1:149,4],type='l',xlab='Day',ylab='Price ($)',main='Share price of MSFT from\n May 2019 to December 2019',cex.lab=2,cex.main=2)
plot(1:149,data_frame2[1:149,5],type='l',xlab='Day',ylab='Price ($)',main='Share price of NVDA from\n May 2019 to December 2019',cex.lab=2,cex.main=2)

#Future NASDAQ index plot
future_index_data <- read.csv("^IXIC-future.csv")
plot(1:149,future_index_data[1:149,6],type='l',xlab='Day',ylab='Price ($)',main='Price of NASDAQ composite index\n from May 2019 to December 2019',cex.lab=2,cex.main=2)

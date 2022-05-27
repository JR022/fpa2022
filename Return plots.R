#Remember to set the working directory!

#The used data is 'adjusted close'; column 6.  Each contains 251 values.
data_frame <- data.frame("AAPL"=read.csv("AAPL.csv")[6], "GOOGL"=read.csv("GOOGL.csv")[6], "INTC"=read.csv("INTC.csv")[6], "MSFT"=read.csv("MSFT.csv")[6], "NVDA"=read.csv("NVDA.csv")[6])
colnames(data_frame) = c('AAPL','GOOGL','INTC','MSFT','NVDA')

#Daily returns.  returns[k] is the change from day k to k+1.
returns <- array(dim=c(250,5))
for (i in 1:5) {
  for (j in 2:251) {
    returns[j-1,i] <- (data_frame[j,i]-data_frame[j-1,i])/data_frame[j-1,i]
  }
}
colnames(returns) = c('AAPL','GOOGL','INTC','MSFT','NVDA')

par(mar=c(5,5,4,1)) #Margins of plot.
plot(1:250,returns[1:250,1],type='l',xlab='Day',ylab='Proportional price change',main='Daily returns for AAPL from\n April 2018 to April 2019',cex.lab=2,cex.main=2)
plot(1:250,returns[1:250,2],type='l',xlab='Day',ylab='Proportional price change',main='Daily returns for GOOGL from\n April 2018 to April 2019',cex.lab=2,cex.main=2)
plot(1:250,returns[1:250,3],type='l',xlab='Day',ylab='Proportional price change',main='Daily returns for INTC from\n April 2018 to April 2019',cex.lab=2,cex.main=2)
plot(1:250,returns[1:250,4],type='l',xlab='Day',ylab='Proportional price change',main='Daily returns for MSFT from\n April 2018 to April 2019',cex.lab=2,cex.main=2)
plot(1:250,returns[1:250,5],type='l',xlab='Day',ylab='Proportional price change',main='Daily returns for NVDA from\n April 2018 to April 2019',cex.lab=2,cex.main=2)

#NASDAQ index plot
index_prices <- read.csv("^IXIC.csv")[6]

index_returns <- rep(0,250);
for (day in 2:251) {
  index_returns[day-1] <- (index_prices[day,1]-index_prices[day-1,1])/index_prices[day-1,1];
}

par(mar=c(5,5,4,1)) #Margins of plot.
plot(1:250,index_returns[1:250],type='l',xlab='Day',ylab='Proportional price change',main='Daily returns for NASDAQ from\n April 2018 to April 2019',cex.lab=2,cex.main=2)


#Future data
data_frame2 <- data.frame("AAPL"=read.csv("AAPL-future.csv")[6], "GOOGL"=read.csv("GOOGL-future.csv")[6], "INTC"=read.csv("INTC-future.csv")[6], "MSFT"=read.csv("MSFT-future.csv")[6], "NVDA"=read.csv("NVDA-future.csv")[6])
colnames(data_frame2) = c('AAPL','GOOGL','INTC','MSFT','NVDA')

#Future returns.  future_returns[k] is the change from day k to k+1.
future_returns <- array(dim=c(148,5))
for (i in 1:5) {
  for (j in 2:149) {
    future_returns[j-1,i] <- (data_frame2[j,i]-data_frame2[j-1,i])/data_frame2[j-1,i]
  }
}
colnames(future_returns) = c('AAPL','GOOGL','INTC','MSFT','NVDA')

par(mar=c(5,5,4,1)) #Margins of plot.
plot(1:148,future_returns[1:148,1],type='l',xlab='Day',ylab='Proportional price change',main='Daily returns for AAPL from\n May 2019 to December 2019',cex.lab=2,cex.main=2)
plot(1:148,future_returns[1:148,2],type='l',xlab='Day',ylab='Proportional price change',main='Daily returns for GOOGL from\n May 2019 to December 2019',cex.lab=2,cex.main=2)
plot(1:148,future_returns[1:148,3],type='l',xlab='Day',ylab='Proportional price change',main='Daily returns for INTC from\n May 2019 to December 2019',cex.lab=2,cex.main=2)
plot(1:148,future_returns[1:148,4],type='l',xlab='Day',ylab='Proportional price change',main='Daily returns for MSFT from\n May 2019 to December 2019',cex.lab=2,cex.main=2)
plot(1:148,future_returns[1:148,5],type='l',xlab='Day',ylab='Proportional price change',main='Daily returns for NVDA from\n May 2019 to December 2019',cex.lab=2,cex.main=2)

#Future index data
future_index_prices <- read.csv("^IXIC-future.csv")[6]

future_index_returns <- rep(0,148);
for (day in 2:149) {
  future_index_returns[day-1] <- (future_index_prices[day,1]-future_index_prices[day-1,1])/future_index_prices[day-1,1];
}
par(mar=c(5,5,4,1)) #Margins of plot.
plot(1:148,future_index_returns[1:148],type='l',xlab='Day',ylab='Proportional price change',main='Daily returns for NASDAQ from\n May 2019 to December 2019',cex.lab=2,cex.main=2)


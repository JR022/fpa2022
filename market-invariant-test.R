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

#Histograms of the two halves
hist(returns[1:125,1],breaks=10,xlim=c(-0.1,0.1),xlab='Linear return',ylab='Frequency',main='Histogram of daily linear returns for\n AAPL from April 2018 to October 2018')
hist(returns[126:250,1],breaks=20,xlim=c(-0.1,0.1),xlab='Linear return',ylab='Frequency',main='Histogram of daily linear returns for\n AAPL October 2018 to April 2019')

hist(returns[1:125,2],breaks=10,xlim=c(-0.1,0.1),xlab='Linear return',ylab='Frequency',main='Histogram of daily linear returns for\n GOOGL from April 2018 to October 2018')
hist(returns[126:250,2],breaks=10,xlim=c(-0.1,0.1),xlab='Linear return',ylab='Frequency',main='Histogram of daily linear returns for\n GOOGL October 2018 to April 2019')

hist(returns[1:125,3],breaks=10,xlim=c(-0.1,0.1),xlab='Linear return',ylab='Frequency',main='Histogram of daily linear returns for\n INTC from April 2018 to October 2018')
hist(returns[126:250,3],breaks=10,xlim=c(-0.1,0.1),xlab='Linear return',ylab='Frequency',main='Histogram of daily linear returns for\n INTC October 2018 to April 2019')

hist(returns[1:125,4],breaks=5,xlim=c(-0.1,0.1),xlab='Linear return',ylab='Frequency',main='Histogram of daily linear returns for\n MSFT from April 2018 to October 2018')
hist(returns[126:250,4],breaks=10,xlim=c(-0.1,0.1),xlab='Linear return',ylab='Frequency',main='Histogram of daily linear returns for\n MSFT October 2018 to April 2019')

hist(returns[1:125,5],breaks=10,xlim=c(-0.1,0.1),xlab='Linear return',ylab='Frequency',main='Histogram of daily linear returns for\n NVDA from April 2018 to October 2018')
hist(returns[126:250,5],breaks=15,xlim=c(-0.3,0.2),xlab='Linear return',ylab='Frequency',main='Histogram of daily linear returns for\n NVDA October 2018 to April 2019')

#Scatter plots of lagged returns
shift <- 2 #The value of \hat{\tau} used when plotting x_t versus x_{t-\hat{\tau}}
plot(returns[(shift+1):250,1],returns[1:(250-shift)],main="Scatter plot of daily linear returns against\n lagged returns for AAPL",xlab='x_t',ylab=paste0('x_(t-',shift,')'))
plot(returns[(shift+1):250,2],returns[1:(250-shift)],main="Scatter plot of daily linear returns against\n lagged returns for GOOGL",xlab='x_t',ylab=paste0('x_(t-',shift,')'))
plot(returns[(shift+1):250,3],returns[1:(250-shift)],main="Scatter plot of daily linear returns against\n lagged returns for INTC",xlab='x_t',ylab=paste0('x_(t-',shift,')'))
plot(returns[(shift+1):250,4],returns[1:(250-shift)],main="Scatter plot of daily linear returns against\n lagged returns for MSFT",xlab='x_t',ylab=paste0('x_(t-',shift,')'))
plot(returns[(shift+1):250,5],returns[1:(250-shift)],main="Scatter plot of daily linear returns against\n lagged returns for NVDA",xlab='x_t',ylab=paste0('x_(t-',shift,')'))

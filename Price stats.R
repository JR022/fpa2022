#Remember to set the working directory!

#The used data is 'adjusted close'; column 6.  Each contains 251 values.
data_frame <- data.frame("AAPL"=read.csv("AAPL.csv")[6], "GOOGL"=read.csv("GOOGL.csv")[6], "INTC"=read.csv("INTC.csv")[6], "MSFT"=read.csv("MSFT.csv")[6], "NVDA"=read.csv("NVDA.csv")[6])
colnames(data_frame) = c('AAPL','GOOGL','INTC','MSFT','NVDA')

#Sample means and variances
means <- array(dim=5)
variances <- array(dim=5)
for (i in 1:5) {
  means[i] <- sum(data_frame[1:251,i]/251)
  variances[i] <- var(data_frame[1:251,i])
}
st_devs <- sqrt(variances)

#Find returns
returns <- array(dim=c(250,5))
for (i in 1:5) {
  for (j in 2:251) {
    returns[j-1,i] <- (data_frame[j,i]-data_frame[j-1,i])/data_frame[j-1,i]
  }
}
return_means <- numeric(5);
for (i in 1:5) {
  return_means[i] = sum(returns[1:250,i])/250;
}
cov <- cov(returns);
#This is the variance-covariance matrix (for returns).  The variance of asset i is cov[i,i]

#Sample standard deviations
return_st_devs <- array(dim=5)
for (i in 1:5) {
  return_st_devs[i] <- sqrt(cov[i,i])
}

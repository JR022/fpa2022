#PLOT 1 - Desktop OS data, source https://gs.statcounter.com/
#Import data.
raw_data <- read.csv("desktop-os_combined-ww-monthly-200901-202202.csv") #Each column is 158 values long.
#Configure the plot window.
plot.new()
plot.window(xlim=c(1,158),ylim=c(0,100),xaxs="i", yaxs="i")
par(rep(0,4))
#Add axes.
xlabels = t(raw_data[1])
axis(1, 1:158, xlabels, las=2)
axis(2, seq(0,100,10),seq(0,100,10), las=1)
#Add data lines.
colours = c('blue','purple','red','orange','black','green')
for (i in 1:4) {
  lines(1:158,t(raw_data[i+1]), col=colours[i])
}
lines(1:158,t(raw_data[7]),col=colours[5])
lines(1:158,t(raw_data[8]+raw_data[9]),col=colours[6]) #Plot 'other'
#Legend
legend(x=10,y=80, legend=c("Windows","macOS","Linux","Unknown","ChromeOS","Other"), col=colours, lty=c(1,1),xpd=TRUE,inset=c(-0.15,0))
title(main="Desktop OS share",ylab="Percentage")
mtext("Date", at=-10,line=-22)
box(col='black')
#c("Windows","macOS","Linux","Unknown","iOS","ChromeOS","Android","Other")
#c('blue','purple','red','orange','gray','green','cyan','black')

#PLOT 2 - Mobile OS data, source https://gs.statcounter.com/
#Import data.
raw_data2 <- read.csv("mobile-os_combined-ww-monthly-200901-202202.csv") #Each column is 158 values long.
#Configure the plot window.
plot.new()
plot.window(xlim=c(1,158),ylim=c(0,100),xaxs="i", yaxs="i")
par(rep(0,4))
#Add axes.
xlabels = t(raw_data2[1])
axis(1, 1:158, xlabels, las=2)
axis(2, seq(0,100,10),seq(0,100,10), las=1)
#Add data lines.
colours = c('blue','purple','orange','black','cyan','red','gray')
for (i in c(1,2)) {
  lines(1:158,t(raw_data2[i+1]), col=colours[i])
}
for (i in c(4,5,6,7)) {
  lines(1:158,t(raw_data2[i+1]), col=colours[i-1])
}
other = rep(0,158)
for (j in c(9:22)) {
  other = other + t(raw_data2[j])
}
lines(1:158,other,col=colours[7]) #Plot 'other'
#Legend
legend(x=10,y=100, legend=c("Android","iOS","SymbianOS",'Unknown','BlackberryOS', 'Samsung',"Other"), col=colours, lty=c(1,1),xpd=TRUE)
title(main="Mobile OS share",ylab="Percentage")
mtext("Date", at=-10,line=-22)
box(col='black')

#PLOT 3 - Search engine data, source https://gs.statcounter.com/
#Import data.
raw_data3 <- read.csv("search_engine-ww-monthly-200901-202202.csv") #Each column is 158 values long.
#Configure the plot window.
plot.new()
plot.window(xlim=c(1,158),ylim=c(0,100),xaxs="i", yaxs="i")
par(rep(0,4))
#Add axes.
xlabels = t(raw_data2[1])
axis(1, 1:158, xlabels, las=2)
axis(2, seq(0,100,10),seq(0,100,10), las=1)
#Add data lines.
colours = c('blue','green','red','black')
for (i in c(1,2,3)) {
  lines(1:158,t(raw_data3[i+1]), col=colours[i])
}
other = rep(0,158)
for (j in c(4:27)) {
  other = other + t(raw_data3[j])
}
lines(1:158,other,col=colours[4]) #Plot 'other'
#Legend
legend(x=10,y=80, legend=c("Google","Bing","Yahoo","Other"), col=colours, lty=c(1,1),xpd=TRUE)
title(main="Search engine share",ylab="Percentage")
mtext("Date", at=-10,line=-22)
box(col='black')
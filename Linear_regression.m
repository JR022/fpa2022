%Import data and collect into a matrix.  Date is not extracted immediately;
%adjusted close is column 5.
AAPL = importdata("AAPL.csv");
aapl = AAPL.data(:,5);
GOOGL = importdata("GOOGL.csv");
googl = GOOGL.data(:,5);
INTC = importdata("INTC.csv");
intc = INTC.data(:,5);
MSFT = importdata("MSFT.csv");
msft = MSFT.data(:,5);
NVDA = importdata("NVDA.csv");
nvda = NVDA.data(:,5);

prices = [aapl,googl,intc,msft,nvda];

%Linear returns.  Fixed number of 251 data points, so 250 linear returns.
linR = zeros(250,5);
for day = 1:250
    for asset = 1:5
        linR(day,asset) = (prices(day+1,asset)-prices(day,asset))/prices(day,asset);
    end
end

means = mean(linR); %Vector of mean returns.
covariance = cov(linR); %Covariance matrix.
%sigma_{ij}^2 is cov(i,j); sigma_i^2 is cov(i,i).

%Market index data.
NASDAQ = importdata("^IXIC.csv");
nasdaq = NASDAQ.data(:,5);

%Market linear returns.
market_linR = zeros(250,1);
for day = 1:250
    market_linR(day) = (nasdaq(day+1)-nasdaq(day))/nasdaq(day);
end
market_var = var(market_linR);
market_mean = mean(market_linR);

%Calculate estimates for alpha_i and beta_i using the market index.
beta = zeros(5,1); alpha = zeros(5,1);
for asset = 1:5 %Asset
    numerator = 0; denominator = 0;
    for day = 1:250
        numerator = numerator + (linR(day,asset)-means(asset))*(market_linR(day)-market_mean);
        denominator = denominator + (market_linR(day)-market_mean)^2;
    end
    beta(asset) = numerator/denominator;
    alpha(asset) = means(asset)-beta(asset)*market_mean;
end

for i = 1:5
    fprintf("Regression line %d has alpha_i=%.10f and beta_i=%.10f\n",i,alpha(i),beta(i))
end

close all
%Scatter plots of (r_m,r_i) with regression line.
xrange = min(market_linR):0.0001:max(market_linR);
%AAPL
close all
plot(market_linR,linR(1:250,1),'.');
hold on;
plot(xrange,alpha(1)+xrange.*beta(1),'-r');
title(["Scatter plot of daily returns for AAPL and \^IXIC","during the year April 2018 to April 2019"])
xlabel("Change in price of \^IXIC")
ylabel("Change in price of AAPL")
%GOOGL
close all
plot(market_linR,linR(1:250,2),'.');
hold on;
plot(xrange,alpha(2)+xrange.*beta(2),'-r');
title(["Scatter plot of daily returns for GOOGL and \^IXIC","during the year April 2018 to April 2019"])
xlabel("Change in price of \^IXIC")
ylabel("Change in price of GOOGL")
%INTC
close all
plot(market_linR,linR(1:250,3),'.');
hold on;
plot(xrange,alpha(3)+xrange.*beta(3),'-r');
title(["Scatter plot of daily returns for INTC and \^IXIC","during the year April 2018 to April 2019"])
xlabel("Change in price of \^IXIC")
ylabel("Change in price of INTC")
%MSFT
close all
plot(market_linR,linR(1:250,4),'.');
hold on;
plot(xrange,alpha(4)+xrange.*beta(4),'-r');
title(["Scatter plot of daily returns for MSFT and \^IXIC","during the year April 2018 to April 2019"])
xlabel("Change in price of \^IXIC")
ylabel("Change in price of MSFT")
%NVDA
close all
plot(market_linR,linR(1:250,5),'.');
hold on;
plot(xrange,alpha(5)+xrange.*beta(5),'-r');
title(["Scatter plot of daily returns for NVDA and \^IXIC","during the year April 2018 to April 2019"])
xlabel("Change in price of \^IXIC")
ylabel("Change in price of NVDA")

%Configuration for best pdf output.
current_figure = gcf;
set(current_figure,'PaperPositionMode','auto');         
set(current_figure,'PaperOrientation','landscape');
set(current_figure,'Position',[50 50 1200 800]);
set(gca,'FontSize',20)
%print(gcf, '-dpdf', 'INTC-regression.pdf') %Remember to change asset code in filename!

%Data finder
low = 1;
for i=1:250
    if (linR(i,1) < linR(low,1))
        low = i;
    end
end
disp(low)

for i=1:250
   if (linR(i,5) < -0.138)
      disp(i) 
   end
end

%Calculation of statistics after outliers have been removed.  Set to 0 to keep the
%number of values the same.
clean_linR = linR;
%AAPL - remove linR 151 and 191.
clean_linR(151,1) = 0; clean_linR(191,1) = 0;
%INTC - remove linR 82 and 206.
clean_linR(82,3) = 0; clean_linR(206,3) = 0;
%NVDA - remove linR 161 and 207.
clean_linR(161,5) = 0; clean_linR(207,5) = 0;

clean_means = mean(clean_linR);
clean_covariance = cov(clean_linR);
%Output for LaTeX entry.
fprintf("%.10f&%.10f&%.10f&%.10f&%.10f \n", clean_means(1), clean_means(2), clean_means(3), clean_means(4), clean_means(5))

for i=1:5
   fprintf("&%.10f&%.10f&%.10f&%.10f&%.10f\\\\ \n", clean_covariance(1,i), clean_covariance(2,i), clean_covariance(3,i), clean_covariance(4,i), clean_covariance(5,i))
end


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

%Linear returns.  Fixed number of 251 data points, so 250 linear prices.
linR = zeros(250,5);
for day = 1:250
    for asset = 1:5
        linR(day,asset) = (prices(day+1,asset)-prices(day,asset))/prices(day,asset);
    end
end

%Remove outliers identified by linear regression.  To maintain the
%dimensions, set discarded prices to 0.
clean_linR = linR;
%AAPL - remove linR 151 and 191.
clean_linR(151,1) = 0; clean_linR(191,1) = 0;
%INTC - remove linR 82 and 206.
clean_linR(82,3) = 0; clean_linR(206,3) = 0;
%NVDA - remove linR 161 and 207.
clean_linR(161,5) = 0; clean_linR(207,5) = 0;

logR = exp(clean_linR)-1; %Transform to log-returns.
means = mean(logR);
logR_cov = cov(logR);

%Project to horizon of 1 year = 365 days by square root rule (division by 1
%is skipped).
projected_means = 365*means;
projected_cov = 365*logR_cov;

%Generate multivariate normal values to simulate the horizon price
%distribution.
norm_values = mvnrnd(projected_means,projected_cov,1e6);

%Find the investment horizon price distribution from the values.
final_prices = prices(end,:);
market_values = ones(1e6,1)*final_prices.*exp(norm_values);

%Find means and covariance matrix of the prices at the investment horizon.
horizon_means = mean(market_values);
horizon_cov = cov(market_values);

%Find linR means and covariance matrix at invesment horizon.
linR_mean = horizon_means./final_prices-1;
linR_cov = diag(1./final_prices)*horizon_cov*diag(1./final_prices);

%Efficient frontier
A = [linR_mean;ones(1,5)] * inv(linR_cov) * [linR_mean',ones(5,1)]; %Information matrix.

muRange = -0.02:1e-3:0.8;
sigma2Range = (1/det(A))*(A(1,1)-2*A(1,2)*muRange+A(2,2)*muRange.^2); %Equation (20); the denominator is det(A).

plot(sqrt(sigma2Range),muRange,'k'); %Efficient frontier plot.
title(["Efficient frontier plot"])
xlabel("\sigma")
ylabel("\mu")
current_figure = gcf;
set(current_figure,'PaperPositionMode','auto');         
set(current_figure,'PaperOrientation','landscape');
set(current_figure,'Position',[50 50 1200 800]);
set(gca,'FontSize',20)
%Save
print(gcf, '-dpdf', 'Efficient_frontier.pdf')

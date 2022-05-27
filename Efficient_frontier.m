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

%Linear prices.  Fixed number of 251 data points, so 250 linear returns.
linR = zeros(250,5);
for day = 1:250
    for asset = 1:5
        linR(day,asset) = (prices(day+1,asset)-prices(day,asset))/prices(day,asset);
    end
end

means = mean(linR); %Vector of mean returns.
covariance = cov(linR); %Covariance matrix.
%sigma_{ij}^2 is cov(i,j); sigma_i^2 is cov(i,i).

%Remove outliers identified by linear regression.  To maintain the
%dimensions, set discarded returns to 0.
clean_linR = linR;
%AAPL - remove linR 151 and 191.
clean_linR(151,1) = 0; clean_linR(191,1) = 0;
%INTC - remove linR 82 and 206.
clean_linR(82,3) = 0; clean_linR(206,3) = 0;
%NVDA - remove linR 161 and 207.
clean_linR(161,5) = 0; clean_linR(207,5) = 0;
%Calculation of statistics after outliers have been removed.
clean_means = mean(clean_linR);
clean_covariance = cov(clean_linR);

%Efficient frontier
A = [clean_means;ones(1,5)] * inv(clean_covariance) * [clean_means',ones(5,1)]; %Information matrix.
%LaTeX format.
for i=1:2
   fprintf("%.4f&%.4f\\\\ \n", A(1,i), A(2,i))
end
muRange = -0.02:1e-7:0.02;
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
%print(gcf, '-dpdf', 'Efficient_frontier.pdf')

V_inverse = inv(clean_covariance);
%LaTeX format.
for i=1:5
   fprintf("%.4f&%.4f&%.4f&%.4f&%.4f\\\\ \n", V_inverse(1,i), V_inverse(2,i), V_inverse(3,i), V_inverse(4,i), V_inverse(5,i))
end

%Minimum variance portfolio found with (21).
mu_MVP = A(1,2)/A(2,2); vpa(A(1,2)/A(2,2));
var_MVP = 1/A(2,2); vpa(1/A(2,2));
weights_MVP = V_inverse*ones(5,1)/A(2,2); vpa(V_inverse*ones(5,1)/A(2,2));

%Maximum return-risk portfolio found with Lemma 3.5.
mu_MRR = A(1,1)/A(1,2);
var_MRR = A(1,1)/A(1,2)^2;
weights_MRR = V_inverse*clean_means'/A(1,2);


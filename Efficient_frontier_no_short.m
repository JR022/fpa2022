clear all; close all;
AAPL = importdata("AAPL.csv"); 
aapl = AAPL.data(:,5);
GOOGL = importdata("GOOGL.csv");
googl = GOOGL.data(:,5);
INTC = importdata('INTC.csv');
intc = INTC.data(:,5);
MSFT = importdata("MSFT.csv"); 
msft = MSFT.data(:,5);
NVDA = importdata("NVDA.csv"); 
nvda = NVDA.data(:,5);

n = 5;

prices = [aapl,googl,intc,msft,nvda];

linR = zeros(length(aapl)-1,n);
for i = 1:length(aapl)-1
for j = 1:n
linR(i,j) = (prices(i+1,j)-prices(i,j))./prices(i,j);
end
end

%Remove outliers identified by linear regression.  Set to 0 to keep the
%number of values the same.
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

muR = mean(clean_linR); % Vector of expected returns for each asset after outliers have been removed.
covR = cov(clean_linR); % Covariance matrix, for risk and correlation for each asset after outliers have been removed.

hold on;
%Wide range to see where the hyperpola 'behaves'.
options = optimset('Algorithm','active-set');
clear sigmaPi;
mubar = 0.0008:1e-5:0.0014; %Test range
for k = 1:length(mubar)
Aeq = [muR; ones(n,1)'];% Ensures Aeq = Beq
Beq = [mubar(k); 1];% See above and constraints (15) and (16) in notes
wl = zeros(n,1);
w0 = zeros(n,1);
[w,fval,exitflag] = fmincon(@(w) w'*covR*w,w0,[],[],Aeq,Beq,wl,[],[],options);
sigmaPi(k) = sqrt(w'*covR*w);
end
plot(sigmaPi,mubar,'Color',[0.8,0.2,0.5]);
%From this, the plot is eratic below mu=0.00093 and above mu=0.00129
options = optimset('Algorithm','active-set');
clear sigmaPi;
mubar = 0.00093:1e-5:0.00129; %Well-behaved range
for k = 1:length(mubar)
Aeq = [muR; ones(n,1)'];% Ensures Aeq = Beq
Beq = [mubar(k); 1];% See above and constraints (15) and (16) in notes
wl = zeros(n,1);
w0 = zeros(n,1);
[w,fval,exitflag] = fmincon(@(w) w'*covR*w,w0,[],[],Aeq,Beq,wl,[],[],options);
sigmaPi(k) = sqrt(w'*covR*w);
end
plot(sigmaPi,mubar,'Color',[1.0,0.1,0.1]);

%Efficient frontier with short selling
hold on;
A = [clean_means;ones(1,5)] * inv(clean_covariance) * [clean_means',ones(5,1)]; %Information matrix.
%LaTeX format.
for i=1:2
   fprintf("%.4f&%.4f\\\\ \n", A(1,i), A(2,i))
end
muRange = -0.02:1e-7:0.02;
sigma2Range = (1/det(A))*(A(1,1)-2*A(1,2)*muRange+A(2,2)*muRange.^2); %Equation (20); the denominator is det(A).
plot(sqrt(sigma2Range),muRange,'k'); %Efficient frontier plot.
legend("Without short selling","With short selling")
title(["Comparison of efficient frontier","with and without short selling"])
xlabel("\sigma")
ylabel("\mu")
current_figure = gcf;
set(current_figure,'PaperPositionMode','auto');         
set(current_figure,'PaperOrientation','landscape');
set(current_figure,'Position',[50 50 1200 800]);
set(gca,'FontSize',20)

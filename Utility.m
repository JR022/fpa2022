%Use Efficient_frontier.m to calculate the required variables first.
close all
muRange = -0.02:1e-7:0.02;
sigma2Range = (1/det(A))*(A(1,1)-2*A(1,2)*muRange+A(2,2)*muRange.^2); %Equation (20); the denominator is det(A).
plot(sqrt(sigma2Range),muRange,'k'); %Efficient frontier plot.
title(["Efficient frontier and utility function u_2 plot"])
xlabel("\sigma")
ylabel("\mu")
current_figure = gcf;
set(current_figure,'PaperPositionMode','auto');         
set(current_figure,'PaperOrientation','landscape');
set(current_figure,'Position',[50 50 1200 800]);
set(gca,'FontSize',20)

%Plot of u_1.  Different plot range to avoid re-scaling the plot.
hold on;
sigmaRange = 0:1e-7:0.2;
plot(sigmaRange, 0.0019926 + sigmaRange.^2,'r');
%Save
%print(gcf, '-dpdf', 'Efficient_frontier-with_utility1.pdf')
%Plot of u_2.
hold on;
sigmaRange = 0:1e-7:0.1;
plot(sigmaRange, 6.93655*sigmaRange.^2,'r');
%Save
%print(gcf, '-dpdf', 'Efficient_frontier-with_utility2.pdf')

%Optimal u_1=0.0019926.
%Point of intersection sigma=0.0345767,mu=0.00318815.
%The weights can be recovered using (17).
weights_u1 = inv(clean_covariance)*[clean_means',ones(5,1)]*inv(A)*[0.00318815;1];

%Optimal u_2=6.93656.
%The intersection point is sigma=0.0145547, mu=0.0014694.
weights_u2 = inv(clean_covariance)*[clean_means',ones(5,1)]*inv(A)*[0.0014694;1];
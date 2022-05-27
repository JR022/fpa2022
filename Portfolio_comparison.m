%Import data and collect into a matrix.  Date is not extracted immediately;
%adjusted close is column 5.
future_AAPL = importdata("AAPL-future.csv");
future_aapl = future_AAPL.data(:,5);
future_GOOGL = importdata("GOOGL-future.csv");
future_googl = future_GOOGL.data(:,5);
future_INTC = importdata("INTC-future.csv");
future_intc = future_INTC.data(:,5);
future_MSFT = importdata("MSFT-future.csv");
future_msft = future_MSFT.data(:,5);
future_NVDA = importdata("NVDA-future.csv");
future_nvda = future_NVDA.data(:,5);

future_prices = [future_aapl,future_googl,future_intc,future_msft,future_nvda];

%Future linear returns over consecutive periods of 10 days.  The data contains 149
%points so the last 9 days have to be ignored.
future_linR = zeros(13,5);
for day = 1:13
    for asset = 1:5
        future_linR(day,asset) = (future_prices(10*(day+1),asset)-future_prices(10*day,asset))/future_prices(10*day,asset);
    end
end

%Plots of the returns for each asset
plot(1:13,future_linR(1:13,1),'-b')
title(["Plot of 10-day linear returns for AAPL","from May 2019 to December 2019"])
xlabel("10-day period")
ylabel("Proportional change in price")

plot(1:13,future_linR(1:13,2),'-b')
title(["Plot of 10-day linear returns for GOOGL","from May 2019 to December 2019"])
xlabel("10-day period")
ylabel("Proportional change in price")

plot(1:13,future_linR(1:13,3),'-b')
title(["Plot of 10-day linear returns for INTC","from May 2019 to December 2019"])
xlabel("10-day period")
ylabel("Proportional change in price")

plot(1:13,future_linR(1:13,4),'-b')
title(["Plot of 10-day linear returns for MSFT","from May 2019 to December 2019"])
xlabel("10-day period")
ylabel("Proportional change in price")

plot(1:13,future_linR(1:13,5),'-b')
title(["Plot of 10-day linear returns for NVDA","from May 2019 to December 2019"])
xlabel("10-day period")
ylabel("Proportional change in price")

%Market index data.
future_NASDAQ = importdata("^IXIC.csv");
future_nasdaq = future_NASDAQ.data(:,5);
%Market 10-day linear returns.
future_market_linR = zeros(13,1);
for day = 1:13
    future_market_linR(day) = (future_nasdaq(10*(day+1))-future_nasdaq(10*day))/future_nasdaq(10*day);
end

plot(1:13,future_market_linR(1:13),'-b')
title(["Plot of 10-day linear returns for \^IXIC","from May 2019 to December 2019"])
xlabel("10-day period")
ylabel("Change in price of \^IXIC")

%%Plots of each portfolio return.%%
%Minimum variance portfolio - weights 0.2498,0.3551,0.3965,0.2372,-0.2387
mvp_linR = zeros(13,1);
weights = [0.2498,0.3551,0.3965,0.2372,-0.2387];
for day = 1:13
    for i = 1:5
        mvp_linR(day) = mvp_linR(day) + weights(i)*future_linR(day,i);
    end
end
%Portfolio return and index return
close all;
plot(1:13,mvp_linR(1:13),'-b');
hold on;
plot(1:13,future_market_linR(1:13),'-r');
title(["Plot of the 10-day linear returns"," of \Pi_{MVP} and \^IXIC from","May 2019 to December 2019"])
xlabel("10-day period")
ylabel("Proportional change in price")
legend('Portfolio linear returns','Market linear returns')
ylim([-0.06,0.15]);
market_linR_mean = mean(future_market_linR);
mvp_linR_mean = mean(mvp_linR);

%Optimal portfolio for utility function u_1 - weights 1.3698891255,-2.7643058911,0.4811715683,2.2264409674,-0.3131957700
weights = [1.3698891255,-2.7643058911,0.4811715683,2.2264409674,-0.3131957700];
u1_linR = zeros(13,1);
for day = 1:13
    for i = 1:5
        u1_linR(day) = u1_linR(day) + weights(i)*future_linR(day,i);
    end
end
%Portfolio return and index return
close all;
plot(1:13,u1_linR(1:13,1),'-b');
hold on;
plot(1:13,future_market_linR(1:13),'-r');
title(["Plot of the 10-day linear returns"," of \Pi_{u_1} and \^IXIC from","May 2019 to December 2019"])
xlabel("10-day period")
ylabel("Proportional change in price")
legend('Portfolio linear returns','Market linear returns')
%ylim([-0.2,0.4]);
market_linR_mean = mean(future_market_linR);
u1_linR_mean = mean(u1_linR);

%Optimal portfolio for the utility function u_2 - weights 0.4118869572,-0.0961943565,0.4087426154,0.5250073826,-0.2494425987
weights = [0.4118869572,-0.0961943565,0.4087426154,0.5250073826,-0.2494425987];
u2_linR = zeros(13,1);
for day = 1:13
    for i = 1:5
        u2_linR(day) = u2_linR(day) + weights(i)*future_linR(day,i);
    end
end
%Portfolio return and index return
close all;
plot(1:13,u2_linR(1:13,1),'-b');
hold on;
plot(1:13,future_market_linR(1:13),'-r');
title(["Plot of the 10-day linear returns"," of \Pi_{u_2} and \^IXIC from","May 2019 to December 2019"])
xlabel("10-day period")
ylabel("Proportional change in price")
legend('Portfolio linear returns','Market linear returns')
ylim([-0.05,0.15]);
market_linR_mean = mean(future_market_linR);
u2_linR_mean = mean(u2_linR);

%Code to configure plot.
current_figure = gcf;
set(current_figure,'PaperPositionMode','auto');         
set(current_figure,'PaperOrientation','landscape');
set(current_figure,'Position',[50 50 1200 800]);
set(gca,'FontSize',20)

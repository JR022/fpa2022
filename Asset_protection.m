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

%Prices of put and call options determined using the Black-Scholes model.
%Utilises the function blsprice: [Call,Put] = blsprice(Price, Strike, Rate, Time, Volatility, Yield)
%%% Plots for visual assistance.
plot(future_aapl)
plot(future_googl)
plot(future_intc)
plot(future_msft)
plot(future_nvda)

%%% MVP 0.2498,0.3551,0.3965,0.2372,-0.2387
time = 23/365;
aapl_strike = 1*future_aapl(23);
[aapl_call,aapl_put] = blsprice(51.245853,aapl_strike,0.00485,time,5.256617,5.698);
googl_strike = 1*future_googl(23);
[googl_call,googl_put] = blsprice(1173.319946,googl_strike,0.00485,time,69.326398,0);
intc_strike = 1*future_intc(23);
[intc_call,intc_put] = blsprice(47.043518,intc_strike,0.00485,time,2.898695,2.5827);
msft_strike = 1*future_msft(23);
[msft_call,msft_put] = blsprice(123.93103,msft_strike,0.00485,time,6.631603,1.4201);
nvda_strike = 1*future_nvda(23);
[nvda_call,nvda_put] = blsprice(44.867352,nvda_strike,0.00485,time,12.150209,1.3819);

%%% u_1 1.3698891255,-2.7643058911,0.4811715683,2.2264409674,-0.3131957700
time = 0.5;
aapl_strike = 1*future_aapl(1);
[aapl_call,aapl_put] = blsprice(51.245853,aapl_strike,0.00485,time,5.256617,5.698);
googl_strike = 0.5*future_googl(1);
[googl_call,googl_put] = blsprice(1173.319946,googl_strike,0.00485,time,69.326398,0);
intc_strike = 1*future_intc(1);
[intc_call,intc_put] = blsprice(47.043518,intc_strike,0.00485,time,2.898695,2.5827);
msft_strike = 1*future_msft(1);
[msft_call,msft_put] = blsprice(123.93103,msft_strike,0.00485,time,6.631603,1.4201);
nvda_strike = 1*future_nvda(1);
[nvda_call,nvda_put] = blsprice(44.867352,nvda_strike,0.00485,time,12.150209,1.3819);

%%% u_2 0.4118869572,-0.0961943565,0.4087426154,0.5250073826,-0.2494425987
time = 0.5;
aapl_strike = 1*future_aapl(23);
[aapl_call,aapl_put] = blsprice(51.245853,aapl_strike,0.00485,time,5.256617,5.698);
googl_strike = 1*future_googl(23);
[googl_call,googl_put] = blsprice(1173.319946,googl_strike,0.00485,time,69.326398,0);
intc_strike = 1*future_intc(23);
[intc_call,intc_put] = blsprice(47.043518,intc_strike,0.00485,time,2.898695,2.5827);
msft_strike = 1*future_msft(23);
[msft_call,msft_put] = blsprice(123.93103,msft_strike,0.00485,time,6.631603,1.4201);
nvda_strike = 1*future_nvda(23);
[nvda_call,nvda_put] = blsprice(44.867352,nvda_strike,0.00485,time,12.150209,1.3819);

%%% Function plots
prices = 0:0.1:2*future_googl(1);
[calls,puts] = blsprice(future_googl(1),prices,0.00485,0.5,69.326398,0);
plot(prices, calls);
prices = 0:0.1:2*future_nvda(1);
[calls,puts] = blsprice(future_nvda(1),prices,0.00485,0.5,69.326398,0);
plot(prices, calls);


%Text output.
fprintf("AAPL&%.10f&%.10f\\\\\n",aapl_call,aapl_put)
fprintf("GOOGL&%.10f&%.10f\\\\\n",googl_call,googl_put)
fprintf("INTC&%.10f&%.10f\\\\\n",intc_call,intc_put)
fprintf("MSFT&%.10f&%.10f\\\\\n",msft_call,msft_put)
fprintf("NVDA&%.10f&%.10f\n",nvda_call,nvda_put)
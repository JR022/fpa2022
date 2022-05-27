%The coefficient \beta_i for asset i is cov(R_i,R_m)/Var(R_m).
%The coefficient \alpha_i for asset i is E(R_i)-\beta_i*E(R_m).
beta = zeros(5,1); alpha = zeros(5,1);
for i = 1:5
    covMatrix = cov(market_linR,linR(1:250,i));
    beta(i) = covMatrix(1,2)/market_var;
    alpha(i) = means(i) - beta(i)*market_mean;
end
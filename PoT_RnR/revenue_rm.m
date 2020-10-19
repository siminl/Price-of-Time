% total revenue gain under a certain toll price

function rt = revenue_rm(df, cost, lambda, mu, r, qlen, tollp)
    
    rho = lambda/mu;
   % rt = lambda.*(1-rho.^(qlen))./(1-rho.^(qlen+1)).*(r-cost.*qlen./mu);
    rt = lambda.*(1-rho.^(qlen))./(1-rho.^(qlen+1)).*(tollp);
end
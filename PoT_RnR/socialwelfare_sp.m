% total revenue gain under a certain toll price

function rt = socialwelfare_sp(df, cost, lambda, mu, r, qlen,theta)
    
    rho = lambda/mu;
    rt = lambda*r.*((1-rho.^qlen)./(1-rho.^(qlen+1))) - ...
        cost.*(rho/(1-rho)-(qlen+1).*(rho.^(qlen+1))./(1-rho.^(qlen+1)));
    
end
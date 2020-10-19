
function rt = sp_bound(lambda, mu, r, c, v0)
 
    rho = lambda/mu;
    rt = (r*mu/c)*(1-rho)^2 + rho*v0 + rho*(1-rho^v0);
end
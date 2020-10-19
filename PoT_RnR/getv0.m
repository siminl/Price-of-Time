function v0 = getv0(lambda, mu, r, c)

    rho = lambda/mu;
    err = 1;
    x = 2;
    
    while abs(err)>1e-6
        xnew = sp_bound(lambda, mu, r, c, x);
        err = abs(x-xnew);
        x = xnew;
    end
    
    v0 = xnew;
end
function rt = rm_bound(lambda, mu, r, c, vr)
    
    rho = lambda/mu;
%    rt = r*mu/c - ((1-rho^(vr-1))*(1-rho^(vr+1)))/((rho^(vr-1))*((1-rho)^2));
    rt = 2*rho*vr - (rho^2)*vr + (r*mu/c)*((1-rho)^2)-rho^(1-vr)-...
        rho^(1+vr)+1+rho^2;
    
end 
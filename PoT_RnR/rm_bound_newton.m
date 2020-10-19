function rt = rm_bound_newton(lambda, mu, r, c, vr)
    
    rho = lambda/mu;
%    rt = r*mu/c - ((1-rho^(vr-1))*(1-rho^(vr+1)))/((rho^(vr-1))*((1-rho)^2));
    val = -vr + 2*rho*vr - (rho^2)*vr + (r*mu/c)*((1-rho)^2)-rho^(1-vr)-...
        rho^(1+vr)+1+rho^2;
    
    val_pri = -1+ 2*rho - rho^2 + (r*mu/c)*((rho^(1-vr))*log(rho) - ...
        (rho^(1+vr))*log(rho));
    
    rt.fx = val;
    rt.fxpri = val_pri;
end 
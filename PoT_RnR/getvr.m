function vr = getvr(lambda, mu, r, c)

    rho = lambda/mu;
    err = 1;
    x = 3;
    iter = 0; 
    
%     while abs(err)>1e-5 && iter<=10000
%         xnew = rm_bound(lambda, mu, r, c, x);
%         err = abs(x-xnew);
%         x = xnew;
%         iter = iter + 1;
%     end
    
    while abs(err)>1e-5 && iter<=10000
        rt = rm_bound_newton(lambda, mu, r, c, x);
        xnew = x - rt.fx/rt.fxpri;
        err = abs(x-xnew);
        x = xnew;
        iter = iter + 1;
    end
    
    if iter == 10001
        %fprintf('1, stopped\n');
        vr = NaN;
    else
        vr = xnew;
    end

%     vr =xnew;

end
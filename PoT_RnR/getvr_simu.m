function rt = getvr_simu(lambda, mu, r,w)
        
        rho = lambda/mu;

        vs = r*mu/w;
        
        vr_vec = 0:0.01:10;
        lhs = vr_vec + ((1-rho.^(vr_vec-1)).*(1-rho.^(vr_vec+1)))./((rho.^(vr_vec-1)).*((1-rho)^2));
        
        
        vr = vr_vec(find(abs(lhs-vs)<0.1));
        
        vrlen = size(vr,2);
        
        rt = vr(max(1,floor(vrlen/2)));
end
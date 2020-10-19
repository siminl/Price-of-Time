function rt = getDiscrepancy(df,lambda, mu, r, obj)
    %global lambda mu r
  
    wbar = df(:,7);
    R = df(:,2);
    [nr,nc] = size(df);


    v0_wbar = zeros(nr,1);
    v0_R = zeros(nr,1); 

    for i=1:nr
        if obj == 1
            v0_wbar(i) = getv0(lambda, mu, r, wbar(i));
            v0_R(i) = getv0(lambda, mu, r, R(i));
        else
            v0_wbar(i) = getvr(lambda, mu, r, wbar(i));
            v0_R(i) = getvr(lambda, mu, r, R(i));
%             v0_wbar(i) = getvr_simu(lambda, mu, r,wbar(i));
%             v0_R(i) = getvr_simu(lambda, mu, r, R(i));  
            
            
        end
% 
%         if mod(i,5) == 0
%             fprintf('i = %d.\n',i);
%         end
        
    end

    % plot the difference between the toll discrepancy against the differences
    % in the two measures of waiting costs. 
    rt.toll_wbar = r - wbar.*floor(v0_wbar)/mu;
    rt.toll_R = r-R.*floor(v0_R)/mu;
    
    rt.toll_wbar_splb = r - wbar.*(floor(v0_wbar)+1)/mu;
    rt.toll_R_splb = r - wbar.*(floor(v0_R)+1)/mu;
    

    rt.cost_discrepancy = (R-wbar);
    rt.toll_discrepancy = -(R.*floor(v0_R)-wbar.*floor(v0_wbar))/mu;
    rt.toll_discrepancy_cts = -(R.*(v0_R)-wbar.*(v0_wbar))/mu;
    
  

    % subplot(2,1,2)
    % plot(cost_discrepancy,toll_discrepancy_cts)
    % title('continuous v_0');

    % cost_discrepancy = (R./wbar);
    % toll_discrepancy = (r- R.*floor(v0_R)/mu)./(r - wbar.*floor(v0_wbar)/mu);
    % toll_discrepancy_cts = (r- R.*(v0_R)/mu)./(r - wbar.*(v0_wbar)/mu);
    % 
    % figure
    % % subplot(2,1,1)
    % plot(cost_discrepancy,toll_discrepancy,'b-',...
    %     cost_discrepancy,toll_discrepancy_cts,'k-')
    % xlabel('$R/ \bar{w}$','Interpreter','latex');
    % ylabel('$\tau(R)/ \tau(\bar{w})$','Interpreter','latex');

    % plot the number of people who would join the queue under a social
    % planners' choice of toll

    rt.queue_discrepancy = floor(v0_R) - floor(v0_wbar);
    rt.queue_discrepancy_cts = (v0_R) - (v0_wbar);
    
    rt.v0_R = v0_R;
    rt.v0_wbar = v0_wbar;
    
    

end
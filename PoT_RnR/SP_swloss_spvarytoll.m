% we made the comparison of a range of toll price under value wbar but cost R
% with the maximum social welfare can be obtained if the toll price is
% charged at the maximum under the full information scenario (know the
% exact cost of waiting of agent, which is R)

function rt = SP_swloss_spvarytoll(Rrange,WaitingCost,rho_vec,mu,r)

    R = WaitingCost(:,2);
    wbar = WaitingCost(:,7);
    colorstring = 'kbmcygr';
    
    perc_cost_mismeasure_vec = zeros(length(Rrange),length(rho_vec));
    perc_rev_change_vec = zeros(length(Rrange),length(rho_vec));
    


    unaffected_interval = zeros(length(rho_vec),1);
    max_perc_change = zeros(length(rho_vec),1);
    avg_perc_change = zeros(length(rho_vec),1);

    xrange = -1:0.01:1;
    xrange = xrange(xrange~=0);
    maxinrange = zeros(length(xrange),1);

        
    lambda = rho_vec*mu;
    rt = getDiscrepancy(WaitingCost,lambda, mu, r, 1);
%        theta_r = rt.toll_wbar; % the toll price under wbar
    % the maximum number of customers that will join the queue under toll price
    % toll would be as follows.

    theta_r_ub = rt.toll_wbar;
    theta_r_lb = rt.toll_wbar_splb;
    
   
    step = 0.01;
    for rn=1:length(theta_r_lb)
        
        theta_range = theta_r_lb(rn):step:theta_r_ub(rn);
        qlen = queue_toll_cost_rm(WaitingCost,lambda, mu, r, R(rn),theta_range');
        
        theta_R = rt.toll_R;
        rev_wbar_R = (socialwelfare_sp(WaitingCost,WaitingCost(rn,2),lambda, mu, r, floor(qlen'),theta_range))';
        rev_R_R = socialwelfare_sp(WaitingCost,WaitingCost(rn,2),lambda, mu, r, floor(rt.v0_R(rn)),theta_R(rn));
        
        perc_rev_change = (rev_wbar_R-rev_R_R)./rev_R_R;
        
        unaffected_interval(rn) = (length(perc_rev_change(perc_rev_change==0))-1)*step;     
        unaffected_interval(rn) = (unaffected_interval(rn)~=-step)*unaffected_interval(rn);
        
        % ------ check the proofs ---- %
        % minval1 = r - (WaitingCost(rn,7)*(rt.v0_wbar(rn)+1))/mu;
        minval1 = max(theta_r_lb(rn),0.5);
        minval2 = max(r - (WaitingCost(rn,2)*(floor(rt.v0_R(rn))+1))/mu,0);
        %maxval1 = r - (WaitingCost(rn,7)*(rt.v0_wbar(rn)))/mu;
        maxval1 = theta_r_ub(rn);
        maxval2 = r - (WaitingCost(rn,2)*(floor(rt.v0_R(rn))))/mu;
        
        if minval1 < maxval2 && maxval1 > maxval2
           check_proof(rn) = maxval2 - minval1;
           maxinterval_check(rn) = maxval2;
           mininterval_check(rn) = minval1;
        elseif minval2 < maxval1 && maxval2 > maxval1
           check_proof(rn) = maxval1 - minval2;
           maxinterval_check(rn) = maxval1;
           mininterval_check(rn) = minval2;
        else
           check_proof(rn) = 0;
           maxinterval_check(rn) = -1;
           mininterval_check(rn) = -1;
        end
  
        theta_range_len(rn) = length(theta_range);
        
        if length(theta_range(perc_rev_change==0))~=0
            maxinterval(rn) = max(theta_range(perc_rev_change==0));
            mininterval(rn) = min(theta_range(perc_rev_change==0));
        else
            maxinterval(rn) = -1;
            mininterval(rn) = -1;
        end
             
        
    end
    
    rt.unaffected_interval= unaffected_interval';
    rt.maxinterval = maxinterval';
    rt.mininterval = mininterval';
    rt.maxinterval_check = maxinterval_check';
    rt.mininterval_check = mininterval_check';
    rt.theta_range_len = theta_range_len*step;
    rt.check_proof = check_proof;

  
function rt = RM_revloss(Rrange,WaitingCost,rho_vec,mu,r,obj,purpose)

    R = WaitingCost(:,2);
    wbar = WaitingCost(:,7);
    colorstring = 'kbmcygr';
    
    perc_cost_mismeasure_vec = zeros(length(Rrange),length(rho_vec));
    perc_rev_change_vec = zeros(length(Rrange),length(rho_vec));
    perc_rev_change_vec1 = zeros(length(Rrange),length(rho_vec));
    


    unaffected_interval = zeros(length(rho_vec),1);
    max_perc_change = zeros(length(rho_vec),1);
    avg_perc_change = zeros(length(rho_vec),1);

    xrange = -0.5:0.01:0.5; 
    xrange = xrange(xrange~=0);
    maxinrange = zeros(length(xrange),1);
    
    jitteramt = [0 0 0];
    sz = [30 15 5];

    for i=1:length(rho_vec)
        
        lambda = rho_vec(i)*mu;
        rt = getDiscrepancy(WaitingCost,lambda, mu, r, obj);
        theta_r = rt.toll_wbar; % the toll price under wbar
        % the maximum number of customers that will join the queue under toll price
        % toll would be as follows.

        qlen = queue_toll_cost_rm(WaitingCost,lambda, mu, r, R, theta_r);
        
        theta_R = rt.toll_R;

        % name notation: rev_x_y: revenue under x-type-cost toll with cost y
        rev_wbar_R = revenue_rm(WaitingCost,WaitingCost(:,2),lambda, mu, r, floor(qlen),theta_r);
        rev_R_R = revenue_rm(WaitingCost,WaitingCost(:,2),lambda, mu, r, floor(rt.v0_R),theta_R);
        rev_wbar_wbar = revenue_rm(WaitingCost,WaitingCost(:,7),lambda, mu, r, floor(rt.v0_wbar),theta_r);
        rev_R_wbar = revenue_rm(WaitingCost,WaitingCost(:,7),lambda, mu, r, floor(rt.v0_R),theta_R);
       
        perc_rev_change1 = (rev_wbar_R - rev_R_R)./rev_R_R;
        perc_cost_mismeasure = (wbar-R)./R;
        perc_rev_change = (rev_wbar_R - rev_R_R)./rev_R_R;
  
   
        qlencheck = (wbar./R).*floor(rt.v0_wbar);
        
%         check = rho_vec(i)*mu*r.*((1-rho_vec(i).^floor(qlencheck))./(1-rho_vec(i).^(floor(qlencheck)+1))).*...
%             (1-floor(qlencheck).*R/(r*mu)) - ...
%             rho_vec(i)*mu*r.*((1-rho_vec(i).^floor(rt.v0_R))./(1-rho_vec(i).^(floor(rt.v0_R)+1))).*...
%             (1-floor(rt.v0_R).*R/(r*mu));

        checkmax = (((1-rho_vec(i))^2*rho_vec(i)^(floor(rt.v0_wbar(1))-1)*(rho_vec(i)*rt.v0_wbar(1)*wbar(1)-mu*rho_vec(i)*r)+...
            rho_vec(i)*wbar(1)*(1-rho_vec(i)^(floor(rt.v0_wbar(1))-1))*(1-rho_vec(i)^(floor(rt.v0_wbar(1))+1)))/...
            ((1-rho_vec(i)^(floor(rt.v0_wbar(1))))*(1-rho_vec(i)^(floor(rt.v0_wbar(1))+1))))/...
            (mu*rho_vec(i)*r*(1-rho_vec(i)^(floor(rt.v0_wbar(1))))*(1-floor(rt.v0_wbar(1))*wbar(1)/(r*mu))/(1-rho_vec(i)^(floor(rt.v0_wbar(1))+1)));
        
        for j=1:length(xrange)
            maxinrange(j) = min(perc_rev_change(perc_cost_mismeasure<max(0,xrange(j))&...
                perc_cost_mismeasure>min(0,xrange(j))));
        end
        
%         perc_rev_change = (rev_wbar_R-rev_R_R)./rev_wbar_R;
%         perc_cost_mismeasure = (wbar-R)./wbar; 
       

        perc_rev_change_vec(:,i) = perc_rev_change;
        perc_rev_change_vec1(:,i) = perc_rev_change1;
        perc_cost_mismeasure_vec(:,i) = perc_cost_mismeasure;
        
        
        stepstart = R((perc_rev_change==0 &[1;perc_rev_change(1:end-1)]~=0));
        stepend = R(perc_rev_change~=0 & isnan(perc_rev_change)==0 &[1;perc_rev_change(1:end-1)]==0);
        
        if length(stepend) == length(stepstart)
            zerointervals = sum(stepend - stepstart);
        elseif length(stepend) == length(stepstart)-1     
            stepend = [stepstart(1);stepend];
            zerointervals = sum(stepend - stepstart);
        else
            stepend = [stepstart(1);stepend;R(end)];
            zerointervals = sum(stepend - stepstart);

        end
        
        maxperc = min((perc_rev_change(isnan(perc_rev_change)==0&perc_rev_change~=-1&perc_rev_change~=0&perc_rev_change~=-Inf)));
        avgperc = mean((perc_rev_change(isnan(perc_rev_change)==0&perc_rev_change~=-1&perc_rev_change~=0&perc_rev_change~=-Inf)));
        
        if maxperc~=0
            max_perc_change(i) = maxperc;
            avg_perc_change(i) = avgperc;
        else 
            max_perc_change(i) = NaN;
            avg_perc_change(i) = NaN;
        end
        unaffected_interval(i) = zerointervals;
        
        if strcmp(purpose,'fixrho') == 1
            
           %subplot(1,2,1)
%             scatter(perc_cost_mismeasure(perc_rev_change>-1)*100,perc_rev_change(perc_rev_change>-1)*100,60,'.','MarkerFaceColor',colorstring(i));
            
            scatter(perc_cost_mismeasure(perc_rev_change>-1)*100,...
                perc_rev_change(perc_rev_change>-1)*100,sz(i),'MarkerFaceColor',colorstring(i),...
            'LineWidth', 0.01,... 
            'jitter','on','jitterAmount', jitteramt(i),...
            'MarkerFaceAlpha', 0.8);
            %set(gca,'ytickformat','percentage')
            ytickformat(gca,'percentage')
            xtickformat(gca,'percentage')
        %      set(gca,'yticklabel',{[]})
            hold on;

            lgd = legend(['\rho=' num2str(rho_vec(1))],['\rho=' num2str(rho_vec(2))],...
                    ['\rho=' num2str(rho_vec(3))], ...
            'Location', 'NorthWest');
            lgd.FontSize= 14;
%             xlabel('$(\bar{w}-R)/R$','Interpreter','latex','FontSize',16);
%             ylabel('$(\mathcal{P}(\bar{w};R)-\mathcal{P}(R;R))/\mathcal{P}(R;R)$','Interpreter','latex','FontSize',16);
            xlabel('$(w-c)/c$','Interpreter','latex','FontSize',16);
            ylabel('$(\mathcal{P}(w)-\mathcal{P}(c))/\mathcal{P}(c)$','Interpreter','latex','FontSize',16);
            
%            subplot(1,2,2)
%             scatter(xrange*100,maxinrange*100,'MarkerFaceColor',colorstring(i));
%             %set(gca,'ytickformat','percentage')
%             ytickformat(gca,'percentage')
%             xtickformat(gca,'percentage')
%         %      set(gca,'yticklabel',{[]})
%             hold on;
% 
%             lgd = legend(['\rho=' num2str(rho_vec(1))],['\rho=' num2str(rho_vec(2))],...
%                     ['\rho=' num2str(rho_vec(3))],...
%             'Location', 'SouthEast');
%             lgd.FontSize= 14;
%             xlabel('$x$','Interpreter','latex','FontSize',16);
% %             ylabel('min of $(\mathcal{P}(\bar{w})-\mathcal{P}(R))/\mathcal{P}(R)$ when $(\bar{w}-R)/R \in (0,x)$ ','Interpreter','latex','FontSize',16);
%             ylabel('min of $(\mathcal{P}(w)-\mathcal{P}(c))/\mathcal{P}(c)$ when $(w-c)/c \in (0,x)$ ','Interpreter','latex','FontSize',16);
% 
% %             scatter(perc_cost_mismeasure(perc_rev_change1>-1&perc_cost_mismeasure>0)*100,...
% %                 perc_rev_change1(perc_rev_change1>-1&perc_cost_mismeasure>0)*100,60,'.','MarkerFaceColor',colorstring(i));
% %             %set(gca,'ytickformat','percentage')
% %             ytickformat(gca,'percentage')
% %             xtickformat(gca,'percentage')
% %         %      set(gca,'yticklabel',{[]})
% %             hold on;
% % 
% %             lgd = legend(['\rho=' num2str(rho_vec(1))],['\rho=' num2str(rho_vec(2))],...
% %                     ['\rho=' num2str(rho_vec(3))], ['\rho=' num2str(rho_vec(4))],...
% %                     ['\rho=' num2str(rho_vec(5))],...
% %             'Location', 'NorthEast');
% %             lgd.FontSize= 14;
% %             xlabel('$(\bar{w}-R)/R$','Interpreter','latex','FontSize',16);
% % %            ylabel('$(\mathcal{P}(\bar{w};\bar{w})-\mathcal{P}(\bar{w};R))/\mathcal{P}(\bar{w};R)$','Interpreter','latex','FontSize',16);
% % %             ylabel('$(\mathcal{P}(w)-\mathcal{P}(r))/\mathcal{P}(r)$','Interpreter','latex','FontSize',16);
% % 

        end

        if mod(i,5) == 0 
            fprintf('%d cases.\n', i)
        end
    end
    % 
    %     ax = axes;
    %     set(ax, 'XTick', [-100:50:350], 'XLim', [-100, 350]);
    %     xtickformat(ax, 'percentage');

    if strcmp(purpose,'fixrho') == 1

        % ytickformat(ax, 'percentage');
        % xtickformat(ax, 'percentage');
        hold off

%     else 
%         figure 
%         plot(rho_vec, unaffected_interval,'-k','LineWidth',1.3)

    end
    
    rt.unaffected_interval = unaffected_interval;
    rt.max_perc_change = max_perc_change;
    rt.avg_perc_change = avg_perc_change;
    
    rt.perc_rev_change_vec = perc_rev_change_vec;
    rt.perc_rev_change_vec1 = perc_rev_change_vec1;
    rt.perc_cost_mismeasure = perc_cost_mismeasure;
    
    rt.xrange = xrange;
    rt.maxinrange = maxinrange;
    
    
    

end

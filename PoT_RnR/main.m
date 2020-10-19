% initiate reward: r and all queue primitives: lambda, mu

% import the wage rate: wbar and cost of waiting, SPr: R from file
% elasspr_1325.csv. The example illustrated in the paper.

%global lambda mu r
% all the time-related variables are using "hour" as the unit.

rho_vec = [0.2;0.3;0.4;0.5;0.6;0.7;0.8;0.9]; % rho for convergence under the individual max case
%rho_vec = 0.1:0.001:0.99; 
%rho_vec = rho_vec(randi(length(rho_vec),6,1));
%rho_vec = [0.6;0.7];
mu = 20;
%r = 2000/mu;  % rho for individual max
r = 60/mu; % this means reward = $60 per hour

WaitingCost = csvread('elasspr_1325.csv');
colorstring = 'kbmcyg';
cla;

% objective = 1 for 'social planner' or 2 for 'revenue max'
objective = 1;  
constrange = zeros(length(rho_vec),1);
v0_vec = zeros(length(rho_vec),1);
IntLen = zeros(length(rho_vec),1);

for j=1:length(rho_vec)
    %lambda = 400; % hourly rate

    lambda = mu*rho_vec(j);

    
    rt = getDiscrepancy(WaitingCost,lambda, mu, r, objective);
    
    constrange(j) = max(rt.cost_discrepancy(rt.queue_discrepancy_cts>-1&rt.queue_discrepancy_cts<1&rt.queue_discrepancy_cts~=0))-...
        min(rt.cost_discrepancy(rt.queue_discrepancy_cts>-1&rt.queue_discrepancy_cts<1&rt.queue_discrepancy_cts~=0));
    
    if (length(rho_vec) <=6)

        subplot(1,2,1)
        plot(rt.cost_discrepancy(rt.v0_R~=0),[rt.toll_discrepancy(rt.v0_R~=0) rt.toll_discrepancy_cts(rt.v0_R~=0)],...
            'Color',colorstring(j),'LineWidth',1.3)
        xlabel('$R - \bar{w}$','Interpreter','latex','FontSize',16);
        ylabel('$\tau(R) - \tau(\bar{w})$','Interpreter','latex','FontSize',16);
        hold on;
        lgd = legend(['\rho=' num2str(rho_vec(1))],'',['\rho=' num2str(rho_vec(2))],'', ...
            ['\rho=' num2str(rho_vec(3))],'', ['\rho=' num2str(rho_vec(4))],'',...
            'Location', 'NorthEast');
        lgd.FontSize= 14;
        if objective ==1 
            title(['\fontsize{20}Social Planner Toll Price']);
        else
            title(['\fontsize{20}Revenue Max Toll Price']);
        end


        subplot(1,2,2)
        plot(rt.cost_discrepancy(rt.v0_R~=0),[rt.queue_discrepancy(rt.v0_R~=0) rt.queue_discrepancy_cts(rt.v0_R~=0)],...
            'Color',colorstring(j),'LineWidth',1.3)
        xlabel('$R - \bar{w}$','Interpreter','latex','FontSize',16);
        ylabel('$n_0(R) - n_0(\bar{w})$','Interpreter','latex','FontSize',16);

        hold on;
        lgd = legend(['\rho=' num2str(rho_vec(1))],'',['\rho=' num2str(rho_vec(2))],'', ...
        ['\rho=' num2str(rho_vec(3))],'', ['\rho=' num2str(rho_vec(4))],'',...
        'Location', 'NorthEast');
        lgd.FontSize= 14;
        if objective ==1 
            title(['\fontsize{20}Social Planner Queue Length']);
        else
            title(['\fontsize{20}Revenue Max Queue Length']);
        end

    %     figure
    %     % subplot(2,1,1)
    %     plot(cost_discrepancy,queue_discrepancy,'b-',...
    %         cost_discrepancy,queue_discrepancy_cts,'k-')
    %     xlabel('$R - \bar{w}$','Interpreter','latex');
    %     ylabel('$n_0(R) - n_0(\bar{w})$','Interpreter','latex');
    
    
    else 
        colorstring = 'kbmcygrkbmcygr';
        plot(rt.cost_discrepancy(rt.v0_R~=0),[rt.queue_discrepancy_cts(rt.v0_R~=0)],...
            'Color',colorstring(j),'LineWidth',1.3)
        xlabel('$R - \bar{w}$','Interpreter','latex','FontSize',16);
        ylabel('$v_0(R) - v_0(\bar{w})$','Interpreter','latex','FontSize',16);

        hold on;
        lgd = legend(['\rho=' num2str(rho_vec(1))],['\rho=' num2str(rho_vec(2))], ...
        ['\rho=' num2str(rho_vec(3))], ['\rho=' num2str(rho_vec(4))],...
        ['\rho=' num2str(rho_vec(5))], ['\rho=' num2str(rho_vec(6))],...
        ['\rho=' num2str(rho_vec(7))], ['\rho=' num2str(rho_vec(8))],...
        'Location', 'NorthEast');
        lgd.FontSize= 14;
        if objective ==1 
            title(['\fontsize{20}Social Planner Queue Length']);
        else
            title(['\fontsize{20}Revenue Max Queue Length']);
        end


    end
    


    v0_wbar = getv0(lambda,mu,r,wbar);
    v0_vec(j) = v0_wbar;
%     Ru = ((1-rho_vec(i))^2)*r*mu/((v0_wbar+1)*(1-rho_vec(i))- rho_vec(i)*(1-rho_vec(i)^(v0_wbar+1)));
%     Rl = ((1-rho_vec(i))^2)*r*mu/((v0_wbar-1)*(1-rho_vec(i))- rho_vec(i)*(1-rho_vec(i)^(v0_wbar-1)));
%     IntLen(i) = (Rl-Ru);
    

    IntLen(j) = -(1-rho_vec(j))*(r*mu*(-(v0_wbar-r*mu/wbar))-lambda*r*(v0_wbar+(lambda*r+wbar)/wbar))/...
        (-(1-rho_vec(j))*(v0_wbar+(lambda*r+wbar)/wbar)*(v0_wbar-r*mu/wbar));
    
    
    
end
h1 = refline([0 1]);h2 = refline([0 -1]);
h1.Color = 'k';h1.LineWidth = 1.3;h1.LineStyle= '--';
h2.Color = 'k';h2.LineWidth = 1.3;h2.LineStyle= '--';
hold off;

% figure
% 
% constrange = [rho_vec' constrange];
% %scatter(constrange(:,1), constrange(:,2),5,'k','*');
% plot(constrange(:,1), constrange(:,2),'-b','LineWidth',1);
% xlabel('$\rho$','Interpreter','latex','FontSize',16);
% ylabel('Length of the Unaffected $R-\bar{w}$ Interval','Interpreter','latex','FontSize',16);
% 
% hold on
% plot(rho_vec,IntLen,'-k','LineWidth',1.2)
% hold off
% legend('Numerical results based on R (spr) in Fig. 1','Analytic expression',...
%     'Location','SouthEast')
% 
% 
% 


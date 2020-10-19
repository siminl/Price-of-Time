% initiate reward: r and all queue primitives: lambda, mu

% import the wage rate: wbar and cost of waiting, SPr: R from file
% elasspr_1325.csv. The example illustrated in the paper.

%global lambda mu r
% all the time-related variables are using "hour" as the unit.

rho_vec = 0.2:0.01:0.95; % rho for convergence under the individual max case
%rho_vec = [0.6;0.7];
mu = 20;
%r = 2000/mu;  % rho for individual max
r = 60/mu; % this means reward = $60 per hour

WaitingCost = csvread('elasspr_1325.csv');
colorstring = 'kbmcyg';
close all;


% objective = 1 for 'social planner' or 2 for 'revenue max'
objective = 2;  

mismeasure_vec = [5;16;17;40;60];
spr_vec = round(WaitingCost(mismeasure_vec,7),2);
toll_discrepancy_vec = zeros(length(rho_vec),length(mismeasure_vec));
toll_discrepancy_cts_vec= zeros(length(rho_vec),length(mismeasure_vec));
queue_discrepancy_vec= zeros(length(rho_vec),length(mismeasure_vec));
queue_discrepancy_cts_vec= zeros(length(rho_vec),length(mismeasure_vec));
cost_discrepancy_vec= zeros(length(rho_vec),length(mismeasure_vec));

for j=1:length(rho_vec)
    %lambda = 400; % hourly rate

    lambda = mu*rho_vec(j);

    
    rt = getDiscrepancy(WaitingCost(mismeasure_vec,:),lambda, mu, r, objective);
    
    
    toll_discrepancy_vec(j,:) = rt.toll_discrepancy';
    toll_discrepancy_cts_vec(j,:) = rt.toll_discrepancy_cts';
    
    queue_discrepancy_vec(j,:) = rt.queue_discrepancy';
    queue_discrepancy_cts_vec(j,:) = rt.queue_discrepancy_cts';
    
    cost_discrepancy_vec(j,:) = rt.cost_discrepancy';
    
    
%     subplot(1,2,1)
%     plot(rt.cost_discrepancy(rt.v0_R~=0),[rt.toll_discrepancy(rt.v0_R~=0) rt.toll_discrepancy_cts(rt.v0_R~=0)],...
%         'Color',colorstring(j),'LineWidth',1.3)
%     xlabel('$R - \bar{w}$','Interpreter','latex','FontSize',16);
%     ylabel('$\tau(R) - \tau(\bar{w})$','Interpreter','latex','FontSize',16);
%     hold on;
%     lgd = legend(['\rho=' num2str(rho_vec(1))],'',['\rho=' num2str(rho_vec(2))],'', ...
%         ['\rho=' num2str(rho_vec(3))],'', ['\rho=' num2str(rho_vec(4))],'',...
%         'Location', 'NorthEast');
%     lgd.FontSize= 14;
%     if objective ==1 
%         title(['\fontsize{20}Social Planner Toll Price']);
%     else
%         title(['\fontsize{20}Revenue Max Toll Price']);
%     end
%  
%     
%     subplot(1,2,2)
%     plot(rt.cost_discrepancy(rt.v0_R~=0),[rt.queue_discrepancy(rt.v0_R~=0) rt.queue_discrepancy_cts(rt.v0_R~=0)],...
%         'Color',colorstring(j),'LineWidth',1.3)
%     xlabel('$R - \bar{w}$','Interpreter','latex','FontSize',16);
%     ylabel('$n_0(R) - n_0(\bar{w})$','Interpreter','latex','FontSize',16);
%     
%     hold on;
%     lgd = legend(['\rho=' num2str(rho_vec(1))],'',['\rho=' num2str(rho_vec(2))],'', ...
%     ['\rho=' num2str(rho_vec(3))],'', ['\rho=' num2str(rho_vec(4))],'',...
%     'Location', 'NorthEast');
%     lgd.FontSize= 14;
%     if objective ==1 
%         title(['\fontsize{20}Social Planner Queue Length']);
%     else
%         title(['\fontsize{20}Revenue Max Queue Length']);
%     end
%     
% %     figure
% %     % subplot(2,1,1)
% %     plot(cost_discrepancy,queue_discrepancy,'b-',...
% %         cost_discrepancy,queue_discrepancy_cts,'k-')
% %     xlabel('$R - \bar{w}$','Interpreter','latex');
% %     ylabel('$n_0(R) - n_0(\bar{w})$','Interpreter','latex');
%     
    
end

figure 
subplot(2,2,1)
p = plot(rho_vec,toll_discrepancy_vec);
set(p, {'color'}, {['k']; ['b']; ['m']; ['c']; ['g']},...
    {'LineWidth'},{1.3});
xlabel('$\rho$','Interpreter','latex','FontSize',16);
ylabel('$\tau(R) - \tau(\bar{w})$, cts','Interpreter','latex','FontSize',16);
lgd = legend(['$R -\bar{w}= $ ' num2str(spr_vec(1)-13.25)],...
    ['$R -\bar{w}= $ ' num2str(spr_vec(2)-13.25)],...
    ['$R -\bar{w}= $ ' num2str(spr_vec(3)-13.25)],...
    ['$R -\bar{w}= $ ' num2str(spr_vec(4)-13.25)],...
    ['$R -\bar{w}= $ ' num2str(spr_vec(5)-13.25)],...
    'Location', 'SouthWest');
lgd.FontSize= 14;
set(lgd, 'interpreter', 'latex')
if objective == 1
    title(['\fontsize{20}Social Planner Toll Price']);
else
    title(['\fontsize{20}Revenue Max Toll Price']);
end


subplot(2,2,2)
p = plot(rho_vec,toll_discrepancy_cts_vec);
set(p, {'color'}, {['k']; ['b']; ['m']; ['c']; ['g']},...
    {'LineWidth'},{1.3});
xlabel('$\rho$','Interpreter','latex','FontSize',16);
ylabel('$\tau(R) - \tau(\bar{w})$, cts','Interpreter','latex','FontSize',16);
% lgd = legend(['$R -\bar{w}= $ ' num2str(spr_vec(1)-13.25)],...
%     ['$R -\bar{w}= $ ' num2str(spr_vec(2)-13.25)],...
%     ['$R -\bar{w}= $ ' num2str(spr_vec(3)-13.25)],...
%     ['$R -\bar{w}= $ ' num2str(spr_vec(4)-13.25)],...
%     ['$R -\bar{w}= $ ' num2str(spr_vec(5)-13.25)],...
%     'Location', 'SouthWest');
% lgd.FontSize= 14;
% set(lgd, 'interpreter', 'latex')
if objective == 1
    title(['\fontsize{20}Social Planner Toll Price, cts']);
else
    title(['\fontsize{20}Revenue Max Toll Price, cts']);
end

subplot(2,2,3)
p = plot(rho_vec,queue_discrepancy_vec);
set(p, {'color'}, {['k']; ['b']; ['m']; ['c']; ['g']},...
    {'LineWidth'},{1.3});
xlabel('$\rho$','Interpreter','latex','FontSize',16);
ylabel('$\tau(R) - \tau(\bar{w})$, cts','Interpreter','latex','FontSize',16);
% lgd = legend(['$R -\bar{w}= $ ' num2str(spr_vec(1)-13.25)],...
%     ['$R -\bar{w}= $ ' num2str(spr_vec(2)-13.25)],...
%     ['$R -\bar{w}= $ ' num2str(spr_vec(3)-13.25)],...
%     ['$R -\bar{w}= $ ' num2str(spr_vec(4)-13.25)],...
%     ['$R -\bar{w}= $ ' num2str(spr_vec(5)-13.25)],...
%     'Location', 'SouthWest');
% lgd.FontSize= 14;
% set(lgd, 'interpreter', 'latex')
if objective == 1
    title(['\fontsize{20}Social Planner Queue Length']);
else
    title(['\fontsize{20}Revenue Max Queue Length']);
end

subplot(2,2,4)
p = plot(rho_vec,queue_discrepancy_cts_vec);
set(p, {'color'}, {['k']; ['b']; ['m']; ['c']; ['g']},...
    {'LineWidth'},{1.3});
xlabel('$\rho$','Interpreter','latex','FontSize',16);
ylabel('$\tau(R) - \tau(\bar{w})$, cts','Interpreter','latex','FontSize',16);
% lgd = legend(['$R -\bar{w}= $ ' num2str(spr_vec(1)-13.25)],...
%     ['$R -\bar{w}= $ ' num2str(spr_vec(2)-13.25)],...
%     ['$R -\bar{w}= $ ' num2str(spr_vec(3)-13.25)],...
%     ['$R -\bar{w}= $ ' num2str(spr_vec(4)-13.25)],...
%     ['$R -\bar{w}= $ ' num2str(spr_vec(5)-13.25)],...
%     'Location', 'SouthWest');
% lgd.FontSize= 14;
% set(lgd, 'interpreter', 'latex')
if objective == 1
    title(['\fontsize{20}Social Planner Queue Length, cts']);
else
    title(['\fontsize{20}Revenue Max Queue Length, cts']);
end

% hold off;

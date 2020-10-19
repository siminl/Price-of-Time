% fixed rho, toll price vs the length of mis-measurement that does not affect social
% planners' decisions.

rho_vec = [0.6;0.7;0.8;0.9;0.99]; % rho for convergence under the individual max case
%rho_vec = 0.1:0.001:0.99; 
%rho_vec = rho_vec(randi(length(rho_vec),6,1));
rho_vec = [0.6;0.7];
%rho = 0.5;
mu = 30;
%r = 2000/mu;  % rho for individual max
r = 120/mu; % this means reward = $60 per hour
%r_vec = [60;80;90;100]/mu;
%r_vec = [200;250;300;350]/mu;
%r_vec = [120;150;180;200]/mu;
R = 35;

%WaitingCost = csvread('elasspr_1325.csv');

% % wrange = 2.9:0.01:40.0;
% wrange = (wbar/2):0.01:(wbar*2);
% wrange = 2.9:0.01:40.0;
step = 0.01;
wrange = (R/2.5):step:(R*2.5);

WaitingCost = zeros(length(wrange),7);
WaitingCost(:,7) = wrange';
WaitingCost(:,2) = R*ones(size(WaitingCost,1),1);

close all

colorstring = 'kbmcygr';
for rhoi =1:length(rho_vec)
   rt = SP_swloss_spvarytoll(wrange,WaitingCost,rho_vec(rhoi),mu,r);
   perc_cost_mismeasure = ((wrange-R)/R)'; 
   unaffected_interval_vec(:,rhoi) = rt.unaffected_interval;
   maxinterval_vec(:,rhoi) = rt.maxinterval;
   mininterval_vec(:,rhoi) = rt.mininterval;
   theta_range_vec(:,rhoi) = rt.theta_range_len;
   
   maxinterval_check_vec(:,rhoi) = rt.maxinterval_check;
   mininterval_check_vec(:,rhoi) = rt.mininterval_check;
   
   check_proof(:,rhoi) = rt.check_proof;
end


% figure
% for rhoi =1:length(rho_vec)
% 
% 
%    subplot(2,1,1)
%    scatter(perc_cost_mismeasure*100,theta_range_vec(:,rhoi),...
%        'MarkerFaceColor','k',...
%        'jitter','on'); 
%        lgd = legend(['range of toll prices'],...
%             'Location', 'SouthWest');
% 
%         lgd.FontSize= 14;
%     xtickformat(gca,'percentage') 
%     xlabel('$(\bar{w}-R)/R$','Interpreter','latex','FontSize',16);
%     ylabel('Range of toll price $(\theta_l(\bar{w}),\theta_u(\bar{w}))$','Interpreter','latex','FontSize',16);
% 
%      subplot(2,1,2)
%     scatter(perc_cost_mismeasure*100,unaffected_interval_vec(:,rhoi),...
%        'MarkerFaceColor',colorstring(rhoi),...
%        'jitter','on');
%    
%    lgd = legend(['\rho=' num2str(rho_vec(1))],['\rho=' num2str(rho_vec(2))],...
%             ['\rho=' num2str(rho_vec(3))], ['\rho=' num2str(rho_vec(4))],...
%             ['\rho=' num2str(rho_vec(5))],...
%             'Location', 'SouthWest');
% 
%    
% %     lgd = legend(['range of toll prices'],...
% %             'Location', 'SouthWest');
%     lgd.FontSize= 14;
%     xtickformat(gca,'percentage') 
%     
%    xlabel('$(\bar{w}-R)/R$','Interpreter','latex','FontSize',16);
%     ylabel('Range of indifferent toll price $\theta\in (\theta_l(\bar{w}),\theta_u(\bar{w}))$','Interpreter','latex','FontSize',16);
% 
%    hold on;
% 
%  
% end
%   
%  
% 
% hold off
% 
% 
% figure
% for rhoi =1:length(rho_vec)
%    subplot(2,1,1)
%    scatter(perc_cost_mismeasure(maxinterval_vec(:,rhoi)~=-1)*100,maxinterval_vec(maxinterval_vec(:,rhoi)~=-1,rhoi),...
%        'MarkerFaceColor',colorstring(rhoi),...
%        'jitter','on');
% 
% 
%    lgd = legend(['\rho=' num2str(rho_vec(1))],['\rho=' num2str(rho_vec(2))],...
%             ['\rho=' num2str(rho_vec(3))], ['\rho=' num2str(rho_vec(4))],...
%             ['\rho=' num2str(rho_vec(5))],...
%             'Location', 'SouthWest');
%    lgd.FontSize= 14;
%    xtickformat(gca,'percentage')
%    hold on;
%    xlabel('$(\bar{w}-R)/R$','Interpreter','latex','FontSize',16);
%    ylabel('Max of indifferent toll price','Interpreter','latex','FontSize',16);
% 
% 
% 
%    
%    subplot(2,1,2)
%    scatter(perc_cost_mismeasure(mininterval_vec(:,rhoi)~=-1)*100,mininterval_vec(mininterval_vec(:,rhoi)~=-1,rhoi),...
%        'MarkerFaceColor',colorstring(rhoi),...
%        'jitter','on');
%    xtickformat(gca,'percentage')
%    hold on;
% 
%    lgd = legend(['\rho=' num2str(rho_vec(1))],['\rho=' num2str(rho_vec(2))],...
%             ['\rho=' num2str(rho_vec(3))], ['\rho=' num2str(rho_vec(4))],...
%             ['\rho=' num2str(rho_vec(5))],...
%             'Location', 'SouthWest');
%    lgd.FontSize= 14;
%    xlabel('$(\bar{w}-R)/R$','Interpreter','latex','FontSize',16);
%    ylabel('Min of indifferent toll price','Interpreter','latex','FontSize',16);
%   
% end
% 
% 
% 
% hold off



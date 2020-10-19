rho_vec = [0.9]; % rho for convergence under the individual max case
%rho_vec = 0.1:0.001:0.99; 
%rho_vec = rho_vec(randi(length(rho_vec),6,1));
%rho_vec = [0.6;0.7];
%rho = 0.5;
mu = 30;
%r = 2000/mu;  % rho for individual max
r = 250/mu; % this means reward = $60 per hour
%r_vec = [60;80;90;100]/mu;
%r_vec = [200;250;300;350]/mu;
%r_vec = [120;150;180;200]/mu;
R = 35;

%WaitingCost = csvread('elasspr_1325.csv');

% % wrange = 2.9:0.01:40.0;
% wrange = (wbar/2):0.01:(wbar*2);
% wrange = 2.9:0.01:40.0;
wrange = (R/2):0.1:(R*1.9);

WaitingCost = zeros(length(wrange),7);
WaitingCost(:,7) = wrange';
WaitingCost(:,2) = R*ones(size(WaitingCost,1),1);

close all

colorstring = 'kbmcygr';
% purpose = fixrho or zerointerval
purpose = 'zerointerval';
mutefig = 'no';

if strcmp(purpose,'fixrho') == 1 
    if strcmp(mutefig,'no') == 1
        %rho_vec = [0.5;0.6;0.7;0.8;0.9];
        rho_vec = [0.5;0.7;0.9];
    else
        rho_vec = 0.6:0.05:0.95;
    end
else
    rho_vec = 0.5:0.01:0.9;
end


%     lgd = legend(['\rho=' num2str(rho_vec(1))],['\rho=' num2str(rho_vec(2))], ...
%     ['\rho=' num2str(rho_vec(3))], ['\rho=' num2str(rho_vec(4))],...
%     ['\rho=' num2str(rho_vec(5))], ['\rho=' num2str(rho_vec(6))],...
%     ['\rho=' num2str(rho_vec(7))], ...
%     'Location', 'NorthEast');

objective = 2;

% for i = 1:length(r_vec)
%     r = r_vec(i)
%     if objective ==1
%         rt = SP_swloss(wrange,WaitingCost,rho_vec,mu,r,1,'zerointerval');
%     else
%         rt = RM_revloss(wrange,WaitingCost,rho_vec,mu,r,2,'zerointerval');
%     end
%         
%     
% %     subplot(1,3,1)
% %     plot(rho_vec(rt.unaffected_interval~=0), rt.unaffected_interval(rt.unaffected_interval~=0),...
% %         '-k','LineWidth',1.3,'Color',colorstring(i))
% %     
% %     hold on
% % 
% %     lgd = legend(['r=' num2str(r_vec(1))],['r=' num2str(r_vec(2))],...
% %             ['r=' num2str(r_vec(3))],['r=' num2str(r_vec(4))],...
% %             'Location', 'SouthEast');
% %     lgd.FontSize= 14;
% %     xlabel('$\rho$','Interpreter','latex','FontSize',16);
% %     ylabel('Length of the Unaffected Interval','FontSize',16);
% % 
% %     
% %     subplot(1,3,2)
% %     plot(rho_vec(isnan(rt.max_perc_change)==0), rt.max_perc_change(isnan(rt.max_perc_change)==0)*100,'-k','LineWidth',1.3,'Color',colorstring(i))
% %     ytickformat(gca,'percentage')
% %     
% %     hold on
% % 
% % %     lgd = legend(['r=' num2str(r_vec(1))],['r=' num2str(r_vec(2))],...
% % %             ['r=' num2str(r_vec(3))], ['r=' num2str(r_vec(4))],...
% % %             ['r=' num2str(r_vec(5))],...
% % %             'Location', 'SouthEast');
% %       
% %         
% %     lgd = legend(['r=' num2str(r_vec(1))],['r=' num2str(r_vec(2))],...
% %         ['r=' num2str(r_vec(3))],['r=' num2str(r_vec(4))],...
% %         'Location', 'SouthEast');
% %     lgd.FontSize= 14;
% %     xlabel('$\rho$','Interpreter','latex','FontSize',16);
% %     if objective ==1
% %         ylabel('Min $(\mathcal{S}(\bar{w})-\mathcal{S}(R))/\mathcal{S}(R)$','Interpreter','latex','FontSize',16);
% %     else
% %         ylabel('Min $(\mathcal{P}(\bar{w})-\mathcal{P}(R))/\mathcal{P}(R)$','Interpreter','latex','FontSize',16);
% %     end
% %     
% %     subplot(1,3,3)
% %     plot(rho_vec(isnan(rt.avg_perc_change)==0), rt.avg_perc_change(isnan(rt.avg_perc_change)==0)*100,'-k','LineWidth',1.3,'Color',colorstring(i))
% %     ytickformat(gca,'percentage')
% %     
% %     hold on
% % 
% % %     lgd = legend(['r=' num2str(r_vec(1))],['r=' num2str(r_vec(2))],...
% % %             ['r=' num2str(r_vec(3))], ['r=' num2str(r_vec(4))],...
% % %             ['r=' num2str(r_vec(5))],...
% % %             'Location', 'SouthEast');
% %       
% %         
% %     lgd = legend(['r=' num2str(r_vec(1))],['r=' num2str(r_vec(2))],...
% %         ['r=' num2str(r_vec(3))],['r=' num2str(r_vec(4))],...
% %         'Location', 'SouthEast');
% %     lgd.FontSize= 14;
% %     xlabel('$\rho$','Interpreter','latex','FontSize',16);
% %     if objective ==1
% %         ylabel('Mean $(\mathcal{S}(\bar{w})-\mathcal{S}(R))/\mathcal{S}(R)$','Interpreter','latex','FontSize',16);
% %     else
% %         ylabel('Mean $(\mathcal{P}(\bar{w})-\mathcal{P}(R))/\mathcal{P}(R)$','Interpreter','latex','FontSize',16);
% %     end
% %     
%     
%     plot(rho_vec(isnan(rt.max_perc_change)==0), rt.max_perc_change(isnan(rt.max_perc_change)==0)*100,'-k','LineWidth',1.3,'Color',colorstring(i))
%     ytickformat(gca,'percentage')
%     
%     hold on
% 
% %     lgd = legend(['r=' num2str(r_vec(1))],['r=' num2str(r_vec(2))],...
% %             ['r=' num2str(r_vec(3))], ['r=' num2str(r_vec(4))],...
% %             ['r=' num2str(r_vec(5))],...
% %             'Location', 'SouthEast');
%       
%         
%     lgd = legend(['r=' num2str(r_vec(1))],['r=' num2str(r_vec(2))],...
%         ['r=' num2str(r_vec(3))],['r=' num2str(r_vec(4))],...
%         'Location', 'SouthEast');
%     lgd.FontSize= 14;
%     xlabel('$\rho$','Interpreter','latex','FontSize',16);
%     if objective ==1
%         ylabel('Min $(\mathcal{S}(\bar{w})-\mathcal{S}(R))/\mathcal{S}(R)$ when $R\in(\bar{w}/2,\bar{w})$','Interpreter','latex','FontSize',16);
%     else
%         ylabel('Min $(\mathcal{P}(\bar{w})-\mathcal{P}(R))/\mathcal{P}(R)$ when $R\in(\bar{w}/2,\bar{w})','Interpreter','latex','FontSize',16);
%     end
%     
% end


% % ytickformat(ax, 'percentage');
% % xtickformat(ax, 'percentage');
% hold off

purpose = 'fixrho';

% if strcmp(purpose,'fixrho') == 1
%     rho_vec = [0.5;0.6;0.7;0.8;0.9];
% else
%     rho_vec = 0.5:0.01:0.99;
% end


if strcmp(purpose,'fixrho') == 1 
    if strcmp(mutefig,'no') == 1
        %rho_vec = [0.5;0.6;0.7;0.8;0.9];
        rho_vec = [0.5;0.7;0.95];
    else
        rho_vec = 0.6:0.007:0.95;
    end
else
    rho_vec = 0.5:0.01:0.9;
end

if objective ==1
    rt = SP_swloss(wrange,WaitingCost,rho_vec,mu,r,1,'fixrho','yes');
    
    figure
    plot(rho_vec, rt.unaffected_interval);
else
    rt = RM_revloss(wrange,WaitingCost,rho_vec,mu,r,2,'fixrho');
end

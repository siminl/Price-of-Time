% 
% %rho_vec = 0.1:0.1:0.9;
% rho_vec = 0.1:0.01:0.99; 
% r_vec = 60:100:500;
% % 
% % for i =1:length(rho_vec)
% %     x =0.01:0.1:20;
% %     fx = rho_vec(i).*(1-rho_vec(i).^x) - (1-rho_vec(i)).*x;
% %     
% %    plot(x,fx)
% %    hold on
% % end
% % 
% % hold off
% 
% mu = 20;
% r = 60/mu;
% wbar = 13.25;
% 
% v0_vec = zeros(length(rho_vec),1);
% IntLen = zeros(length(rho_vec),1);
% 
% colorstring = 'kbmcgy';
% 
% for j = 1:length(r_vec)
%     for i=1:length(rho_vec)
%         r = r_vec(j)/mu;
%     
%         lambda = rho_vec(i)*mu;
% 
%         v0_wbar = getv0(lambda,mu,r,wbar);
%         v0_vec(i) = v0_wbar;
% 
%     %     Ru = ((1-rho_vec(i))^2)*r*mu/((v0_wbar+1)*(1-rho_vec(i))- rho_vec(i)*(1-rho_vec(i)^(v0_wbar+1)));
%     %     Rl = ((1-rho_vec(i))^2)*r*mu/((v0_wbar-1)*(1-rho_vec(i))- rho_vec(i)*(1-rho_vec(i)^(v0_wbar-1)));
%     %     IntLen(i) = (Rl-Ru);
% 
% 
%         IntLen(i) = (r*mu*(-(v0_wbar-r*mu/wbar))-lambda*r*(v0_wbar+(lambda*r+wbar)/wbar))/...
%             ((v0_wbar+(lambda*r+wbar)/wbar)*(v0_wbar-r*mu/wbar));
% 
% 
%     %     Numer(i) = (r*mu*(-(v0_wbar-r*mu/wbar))-lambda*r*(v0_wbar+(lambda*r+wbar)/wbar));
%     %     Denom(i) =  ((v0_wbar+(lambda*r+wbar)/wbar)*(v0_wbar-r*mu/wbar));
%     end
% 
%     plot(rho_vec,IntLen,'-k','Color',colorstring(j),'LineWidth',1.3)
%     hold on;
%     lgd = legend(['r=' num2str(r_vec(1))],['r=' num2str(r_vec(2))], ...
%     ['r=' num2str(r_vec(3))], ['r=' num2str(r_vec(4))],...
%     ['r=' num2str(r_vec(5))],...
%     'Location', 'NorthWest');
%     lgd.FontSize= 14;
% 
% 
% end
% 
% hold off


% for i=1:length(rho_vec)
%     
%     lambda = rho_vec(i)*mu;
% 
%     v0_wbar = getv0(lambda,mu,r,wbar);
%     v0_vec(i) = v0_wbar;
%     
% %     Ru = ((1-rho_vec(i))^2)*r*mu/((v0_wbar+1)*(1-rho_vec(i))- rho_vec(i)*(1-rho_vec(i)^(v0_wbar+1)));
% %     Rl = ((1-rho_vec(i))^2)*r*mu/((v0_wbar-1)*(1-rho_vec(i))- rho_vec(i)*(1-rho_vec(i)^(v0_wbar-1)));
% %     IntLen(i) = (Rl-Ru);
%     
%     
%     IntLen(i) = (r*mu*(-(v0_wbar-r*mu/wbar))-lambda*r*(v0_wbar+(lambda*r+wbar)/wbar))/...
%         ((v0_wbar+(lambda*r+wbar)/wbar)*(v0_wbar-r*mu/wbar));
%     
% %     Numer(i) = (r*mu*(-(v0_wbar-r*mu/wbar))-lambda*r*(v0_wbar+(lambda*r+wbar)/wbar));
% %     Denom(i) =  ((v0_wbar+(lambda*r+wbar)/wbar)*(v0_wbar-r*mu/wbar));
% 
% end

% close all
% 
% figure
% plot(rho_vec,IntLen,'-k')
% 
% figure
% plot(rho_vec,IntLen,'-k')
% hold on
% plot(rho_vec,Denom,'-b')
% hold on
% plot(rho_vec,Numer,'-g')
% hold on
% r1 = refline([0 0]);
% r1.LineStyle = '--';
% hold off
% 
% figure 
% plot(rho_vec, v0_vec);
% 


x = [1:1:100];
for i=1:length(x)
    y(:,i) = revenue_rm(WaitingCost, WaitingCost(:,7), 10, 20, 2, x(i));
end
figure
plot(x',y(996,:))




% rho = 0.9;
% n = 1:1:100;
% fn = (1-rho.^n)./(1-rho.^(n+1));
% 
% figure
% plot(n,fn)
% 
% figure
% plot(WaitingCost(:,7),rt.toll_wbar)

rho = 0.95;
n = 1:1:100;
fn = (n-1).*(rho.^(2*n)-rho.^(n+1)-rho.^(n-1))-1;
figure
plot(n,fn)

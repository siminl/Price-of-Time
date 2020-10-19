function qlen = queue_toll_cost_rm(df,lambda, mu, r, c,toll)
 
    [nr,nc] = size(df);
    
 
    qlen = (r-toll)*mu./c;


end
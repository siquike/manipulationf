function G = buildRRT(qi,K,dq)

%=========Inputs============
% qi: Initial Configuration
% K: Number of Vertices in RRT
% dq: Incremental Distance 
%========Outputs============
% G: Output graph

%% Implementation
G =  
for i = 1:K
  qrand = randFreeConfig;
  qnear = nearestVertex(qrand,G);
  qnew = newConfig(qrand,G); 
  
end	
end

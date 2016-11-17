function G = buildRRT(qi,K,dq,G)

%=========Inputs============
% qi: Initial Configuration
% K: Number of Vertices in RRT
% dq: Incremental Distance 
% G: Graph
%========Outputs============
% G: Output graph

%% Implementation
G = AreaGraph(zeros(50));
G.Initial = qi;
for i = 1:K
  qrand = randConf();
  % qrand = randFreeConfig;
  qnear = nearestVertex(qrand,G);
  qnew = newConfig(qrand,G); 
  
end	

end

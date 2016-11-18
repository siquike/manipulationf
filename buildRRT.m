function G = buildRRT(qi,K,dq)

%=========Inputs============
% qi: Initial Configuration
% K: Number of Vertices in RRT
% dq: Incremental Distance 
% G: Graph
%========Outputs============
% G: Output graph
 
%% Implementation
G = AreaGraph(zeros(50));
G = G.init(qi)
for i = 1:K
  qrand = randConf();
  qnear = nearestVertex(qrand,G);
  qnew = newConfig(qnear,qrand,dq); 
  G = G.addVertex(qnew)
  G = G.addEdges([qnear qnew])
end	

end

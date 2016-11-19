function G = buildRRT(qi,K,dq)

%=========Inputs============
% qi: Initial Configuration
% K: Number of Vertices in RRT
% dq: Incremental Distance 
% G: Graph
%========Outputs============
% G: Output graph
 
%% Implementation
G = AreaGraph(zeros(3));
G = G.init(qi)
b = 0;
for i = 1:K
    qrand = randConf(G);
    if b == 0
        qnear = qi;
        b = 1;
    else
        qnear = nearestVertex(qrand,G);
    end
    qnew = newConfig(qnear,qrand,dq);
  if (sum(qnear > 0) == 2) && (sum(qnew > 0) == 2)
	G = G.addVertex(qnew);
	G = G.addEdges([qnear qnew]);
  end
end	

end

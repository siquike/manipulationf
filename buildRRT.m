function [G,o1] = buildRRT(qi,K,dq,nG)

%=========Inputs============
% qi: Initial Configuration
% K: Number of Vertices in RRT
% dq: Incremental Distance 
% nG: size of Graph

%========Outputs============
% G: Output graph
 
%% Implementation
G = AreaGraph(zeros(nG));
G = G.init(qi);
o1 = Cylinder([10 10 5]);
b = 0;
for i = 1:K
%     qrand = randConf(G);
    qrand = randFreeConfig(G,o1);
    if b == 0
        qnear = qi;
        inside1 = o1.Dist(qnear);
        b = 1;
    else
        qnear = nearestVertex(qrand,G);
        inside1 = o1.Dist(qnear);
    end
    qnew = newConfig(qnear,qrand,dq);
    inside2 = o1.Dist(qnew);    
  if (sum(qnear > 0) == 2) && (sum(qnew > 0) == 2) && (inside1 ~= 1) && (inside2 ~= 1)
	G = G.addVertex(qnew);
	G = G.addEdges([qnear qnew]);
  end
end	

end

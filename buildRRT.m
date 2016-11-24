function G = buildRRT(qi,K,dq,nG)

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
    qrand = randFreeConf(G,o1);
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

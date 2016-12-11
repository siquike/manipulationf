function [G,o1,body] = buildRRT(qi,K,dq,nG,goal)

%=========Inputs============
% qi: Initial Configuration
% K: Number of Vertices in RRT
% dq: Incremental Distance 
% nG: size of Graph

%========Outputs============
% G: Output graph
 body = [];
 I = [];
%% Implementation
G = AreaGraph(zeros(nG));
G = G.init(qi);
G = G.addConfiguration([51 51 51]);
o1 = Cylinder([70 15 10]);
first = 1;
for i = 1:K
    [qrand,bodyn,iteration] = randConf(G,o1,goal);
%     conf = iteration;
%     [qrand,bodyn,iteration] = randFreeConfig(G,o1);
    if first == 1
        qnear = qi;
        inside1 = o1.Dist(qnear);
        first = 0;
        conf = [51 51 51];
    else
        [qnear] = nearestVertex(qrand,G,iteration);
        inside1 = o1.Dist(qnear);
    end
    [qnew,bodyn,conf] = newConfig(qnear,qrand,bodyn,dq,o1,iteration,G,conf);
%     qnear = nearestVertex(qnew,G);
    inside1 = o1.Dist(qnear);
    inside2 = o1.Dist(qnew);
    inside3 = o1.Dist(bodyn(:,:,1));
    inside4 = o1.Dist(bodyn(:,:,2));
    inside5 = o1.Dist(bodyn(:,:,3));
    [D,I] = pdist2(G.Nodes,qnew,'euclidean','Smallest',1);
%     D
%     qnew
  if (sum(qnear > 0) == 2) && (sum(qnew > 0) == 2) && (inside1 ~= 1) && (inside2 ~= 1) && (inside3 ~= 1) && (inside4 ~= 1) && (inside5 ~= 1) && (D ~=0)
	G = G.addVertex(qnew);
    G = G.addConfiguration(conf);
	G = G.addEdges([qnear qnew]);
    body = cat(4, body, bodyn);
  end
end	

end

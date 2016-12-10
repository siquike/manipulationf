function [G,o1,body] = buildRRT(qi,K,dq,nG)

%=========Inputs============
% qi: Initial Configuration
% K: Number of Vertices in RRT
% dq: Incremental Distance 
% nG: size of Graph

%========Outputs============
% G: Output graph
 body = [];
%% Implementation
G = AreaGraph(zeros(nG));
G = G.init(qi);
o1 = Cylinder([100 100 10]);
first = 1;
for i = 1:K
    [qrand,bodyn,iteration] = randConf(G,o1);
%     [qrand,bodyn,iteration] = randFreeConfig(G,o1);
    if first == 1
        qnear = qi;
        inside1 = o1.Dist(qnear);
        first = 0;
    else
        qnear = nearestVertex(qrand,G);
        inside1 = o1.Dist(qnear);
    end
    [qnew,bodyn] = newConfig(qnear,qrand,bodyn,dq,o1,iteration,G);
%     qnear = nearestVertex(qnew,G);
%     inside1 = o1.Dist(qnear);
%     inside2 = o1.Dist(qnew);
%     inside3 = o1.Dist(bodyn(:,:,1));
%     inside4 = o1.Dist(bodyn(:,:,2));
%     inside5 = o1.Dist(bodyn(:,:,3));
%     qnew
%   if (sum(qnear > 0) == 2) && (sum(qnew > 0) == 2) && (inside1 ~= 1) && (inside2 ~= 1) && (inside3 ~= 1) && (inside4 ~= 1) && (inside5 ~= 1)
	G = G.addVertex(qnew);
	G = G.addEdges([qnear qnew]);
    body = cat(4, body, bodyn);
%   end
end	

end

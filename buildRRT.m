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
o1 = Cylinder([35 40 10]);
first = 1;
endeffprev = [50 60];
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
    [qnew,bodyn,conf,endeff] = newConfig(qnear,qrand,bodyn,dq,o1,iteration,G,conf);
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
    G = G.addEndeff(round(endeff));
    G = G.addConfiguration(conf);
	G = G.addEdges([qnear qnew]);
%     [endeffprev endeff]
    G = G.addEdges2([endeffprev round(endeff)]);
    body = cat(4, body, bodyn);
    endeffprev = round(endeff);
    [Dend,Iend] = pdist2(G.Endeff,goal,'euclidean','Smallest',1);
    if Dend <= 2
        G = G.addEndeff(goal);
        G = G.addEdges2([round(endeff) goal]);
        break
    end
  end
end	

end

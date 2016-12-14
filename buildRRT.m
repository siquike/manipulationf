function [G,object,body] = buildRRT(start,goal,K,dq,sizeGraph)
%% Desccription
%=========Inputs============
% Start:     Initial Position of End-Effector
% K:         Number of iterations in RRT
% dq:        Incremental Distance 
% sizeGraph: Square size of Graph

%========Outputs============
% G:         Output graph
% object:    Obstacles
% body:      Constructed body of robot
 
%% Initialization

body = [];
I = [];

G = AreaGraph(zeros(sizeGraph));
G = G.init(start);
G = G.addConfiguration([51 51 51]);

object = Cylinder([35 20 10]);
initial = 1;
endeffprev = [50 60];

%% Implementation
for i = 1:K
    % Random Configuration, Multi-module build and table iteration 
    [qrand,bodyn,iteration] = randConf(sizeGraph,goal); 
    
    % Nearest Vertex Selection (First and subsequent nodes)
    if initial == 1
        qnear = start;
        inside1 = object.Dist(qnear);
        initial = 0;
        conf = [51 51 51];
    else
        [qnear] = nearestVertex(qrand,G);
        inside1 = object.Dist(qnear);
    end
    % New Configuration Selection 
    [qnew,bodyn,conf,endeff] = newConfig(qnear,bodyn,dq,iteration,sizeGraph,conf);
    
    inside1 = object.Dist(qnear);
    inside2 = object.Dist(qnew);
    inside3 = object.Dist(bodyn(:,:,1));
    inside4 = object.Dist(bodyn(:,:,2));
    inside5 = object.Dist(bodyn(:,:,3));
    [D,I] = pdist2(G.Nodes,qnew,'euclidean','Smallest',1);

    % If states do not lie inside object, add verteces and edges accordingly
    if (sum(qnear > 0) == 2) && (sum(qnew > 0) == 2) && (inside1 ~= 1) && (inside2 ~= 1) && (inside3 ~= 1) && (inside4 ~= 1) && (inside5 ~= 1) && (D ~=0)
        G = G.addVertex(qnew);
        G = G.addEndeff(round(endeff));
        G = G.addConfiguration(conf);
        G = G.addEdges([qnear qnew]);
        G = G.addEdges2([endeffprev round(endeff)]);
        body = cat(4, body, bodyn);
        endeffprev = round(endeff);
        [Dend,Iend] = pdist2(G.Endeff,goal,'euclidean','Smallest',1);
        % if close enough to goal, end the sequence
        if Dend <= 2
            G = G.addEndeff(goal);
            G = G.addEdges2([round(endeff) goal]);
            break
        end
    end
end	

end

function [qnew,bodyn,conf,endeff] = newConfig(qnear,bodyn,dq,iteration,sizeGraph,conf)
%% Desccription
%=========Inputs============
% qnear:     Nearest coordinate to random ened-effector position selected in randConfig function
% bodyn:     Constructed body of robot
% dq:        Incremental Distance
% iteration: Index of lookup table for particular configuration built  
% sizeGraph: Square size of Graph
% conf:      Configuration of arm selected

%========Outputs============
% qnew:      End-effector Position based on step dq from the direction of qnear to qrand for RRT 
% bodyn:     Constructed body of robot
% conf:      Configuration of arm selected
% endeff:    End-effector Position based on step dq from the direction of qnear to qrand for real end-effector

%% Implementation
load states.mat

% Find direction of step
v = iteration - conf;
dq(1) = dq(1)*sign(v(1));
dq(2) = dq(2)*sign(v(2));
dq(3) = dq(3)*sign(v(3));
% End effector step-size RRT
qnew = qnear + dq(1:2);
% Configuration step size
it = conf + dq;

% Biased random selection of iteration in lookup table which is relatively close to qrand  
n = 3; 
iteration(1) = round(n*rand(1,1) + 0.5 - n/2 + it(1));
iteration(2) = round(n*rand(1,1) + 0.5 - n/2 + it(2));

% Make sure iteration stays inside table size
if iteration(1) < 1
    iteration(1) = 1;
end
if iteration(1) > 101
    iteration(1) = 101;
end
if iteration(2) < 1
    iteration(2) = 1;
end
if iteration(2) > 101
    iteration(2) = 101;
end

% Construct new configuration based on new iteration
[X_body2]= moduleTransform(X_body,X_body,direction,iteration(1));
[X_body3]= moduleTransform(X_body,X_body2,direction,iteration(2));
X_body(:,1,:) = X_body(:,1,:) + 0.5;
X_body2(:,1,:) = X_body2(:,1,:) + 0.5;
X_body3(:,1,:) = X_body3(:,1,:) + 0.5;

% Select closest vertex to new configuration of RRT
qnewcomp = X_body3(end,:,:)*sizeGraph; 
qnewcomp = permute(qnewcomp,[3 2 1]);
[~,I1] = pdist2(qnewcomp,qnew,'euclidean','Smallest',1);
bodyn(:,:,1) = X_body(:,:,iteration(1))*sizeGraph;
bodyn(:,:,2) = X_body2(:,:,iteration(2))*sizeGraph;
bodyn(:,:,3) = X_body3(:,:,I1)*sizeGraph;
conf = [iteration(1) iteration(2) I1];

% Selected end-effector position
endeff = X_body3(end,:,I1)*100;


end


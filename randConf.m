function [qrand,bodyn,iteration] = randConf(sizeGraph,goal)
%% Desccription
%=========Inputs============
% sizeGraph: Square size of Graph
% goal:      Desired final position of end effector

%========Outputs============
% qrand:     End-effector Position based on randomly selected configurations  
% bodyn:     Constructed body of robot
% iteration: Index of lookup table for particular configuration built  

%% Implementation
load states.mat

% Biased sample selection of iteration from lookup table
n = size(X_body,1);

if goal(1) > 50
    iteration(1) = round(n/25*rand(1,1)+70);
    iteration(2) = round(n/25*rand(1,1)+90);
    iteration(3) = round(n/25*rand(1,1)+90);
elseif goal(1) < 50
    iteration(1) = round(n/25*rand(1,1)+30);
    iteration(2) = round(n/25*rand(1,1)+10);
    iteration(3) = round(n/25*rand(1,1)+10);
else
    iteration(1) = round(n*rand(1,1)+.5);
    iteration(2) = round(n*rand(1,1)+.5);
    iteration(3) = round(n*rand(1,1)+.5);
end

% Compute module configurations
[X_body2]= moduleTransform(X_body,X_body,direction,iteration(1));
[X_body3]= moduleTransform(X_body,X_body2,direction,iteration(2));
% Set ground at X = 50
X_body(:,1,:) = X_body(:,1,:) + 0.5; 
X_body2(:,1,:) = X_body2(:,1,:) + 0.5;
X_body3(:,1,:) = X_body3(:,1,:) + 0.5;
% Select End effector position based on random configuration
qrand = X_body3(end,:,iteration(3))*100;

% Size Adjustment based on graph size 
bodyn(:,:,1) = X_body(:,:,iteration(1))*sizeGraph;
bodyn(:,:,2) = X_body2(:,:,iteration(2))*sizeGraph;
bodyn(:,:,3) = X_body3(:,:,iteration(3))*sizeGraph;

end

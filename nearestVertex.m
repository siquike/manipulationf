function [qnear] = nearestVertex(qrand,G)
%% Desccription
%=========Inputs============
% qrand:     End-effector Position based on randomly selected configurations  
% G:         Graph object

%========Outputs============
% qnear:     Nearest coordinate to random ened-effector position selected in randConfig function

%% Implementation
coordinates = G.Nodes;
[~,I] = pdist2(coordinates,qrand,'euclidean','Smallest',1);
qnear = coordinates(I,:);
end
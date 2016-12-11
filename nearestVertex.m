function [qnear] = nearestVertex(qrand,G,iteration)
% IND = 1:numel(G.Graph);
% [x,y] = ind2sub(size(G.Graph),IND);
% load states.mat
coordinates = G.Nodes;
configs = G.Configurations;
% [~,I] = pdist2(configs,iteration,'euclidean','Smallest',1);
[~,I] = pdist2(coordinates,qrand,'euclidean','Smallest',1);
qnear = coordinates(I,:);
% conf = iteration;
% Check if body works
end
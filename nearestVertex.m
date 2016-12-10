function qnear = nearestVertex(qrand,G)
% IND = 1:numel(G.Graph);
% [x,y] = ind2sub(size(G.Graph),IND);
coordinates = G.Nodes;
[~,I] = pdist2(coordinates,qrand,'euclidean','Smallest',1);
qnear = coordinates(I,:);
% Check if body works
end
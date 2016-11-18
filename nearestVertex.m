function qnear = nearestVertex(qrand,G)
IND = 1:numel(G.Graph);
[x,y] = ind2sub(size(G.Graph),IND);
coordinates = [x' y'];
[~,I] = pdist2(coordinates,qrand,'euclidean','Smallest',1);
qnear = coordinates(I,:);
end
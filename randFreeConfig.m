function qrand = randFreeConfig(G,o1)
% load states.mat
n = size(G.Graph);
% n = size(X_body,1);
inside = 1;
while inside == 1
    qrand = [n(1)*rand(1,1) n(2)*rand(1,1)];
    inside = o1.Dist(qrand);
% buildArm()
end
end

%% Dynamics of Robot
%% Build a graph

% subp = 1:prod(size(S)); %linear indeces of matrix V
% connected = % indeces of connected states

% determine qi based on initial configuration of robot
qi = [1 1];
K = 10; % K is number of vertices. !!!What does this mean? Initial? !!!! Revisit

dq = [1 1];% Incremental distance for the state

G = buildRRT(qi,K,dq); 

figure
hold on

plot(qi(1),qi(2),'*R')
plot(G.Nodes(:,1),G.Nodes(:,2),'oB');
A = G.Adjacency;
for i = 2:size(A,1)
    for j = i:size(A,1)
        if A(i,j) == 1
            node1 = G.Coords(i,:);
            node2 = G.Coords(j,:);
            plot([node1(1) node2(1)],[node1(2) node2(2)],'-b');
        end
    end
end
% plot(A,'-*')
axis([1,3,1,3])
axis square

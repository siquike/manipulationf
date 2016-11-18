%% Dynamics of Robot
%% Build a graph

% subp = 1:prod(size(S)); %linear indeces of matrix V
% connected = % indeces of connected states

% determine qi based on initial configuration of robot
qi = [5 5];
K = 20; % K is number of vertices. !!!What does this mean? Initial? !!!! Revisit

dq = [1 1];% Incremental distance for the state

G = buildRRT(qi,K,dq) 

figure
hold on
plot(G.Edges(1,1:2),G.Edges(1,3:4),'b') % Rearrange edges
plot(qi(1),qi(2),'*') 
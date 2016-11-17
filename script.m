%% Dynamics of Robot
%% Build a graph
G =  zeros(50); % Activated states matrix
% subp = 1:prod(size(S)); %linear indeces of matrix V
% connected = % indeces of connected states

% determine qi based on initial configuration of robot
q1 = [5 5];
K = 4; % K is number of vertices. !!!What does this mean? Initial? !!!! Revisit

dq = [1 1];% Incremental distance for the state

G = buildRRT(qi,K,dq,G) 


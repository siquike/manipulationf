%% RRT-ish for 3 Module Soft Robotic Manipulator
% This script builds and displays RRT-ish

%% Initialize

start = [50 60]; % Intial End-effector Position of Robot
K = 200; % K is number times RRT-ish loops
goal = [88 32]; % Target for the end-effector
dq = [2 2 2]; % Incremental distance for the states of manipulator
sizeGraph = 100; % Square size of the graph

%% Implement

[G,o1,body] = buildRRT(start,goal,K,dq,sizeGraph); 


%% Plot

figure
hold on

A = G.Adjacency;
A2 = G.Adjacency2;
for i = 1:size(A,1)
    for j = i:size(A,1)
        if A(i,j) == 1
            node1 = G.Coords(i,:);
            node2 = G.Coords(j,:);
            plot([node1(1) node2(1)],[node1(2) node2(2)],'-g','LineWidth',2);            
        end
        if A2(i,j) == 1
            nodeee1 = G.Coords2(i,:);
            nodeee2 = G.Coords2(j,:);            
            plot([nodeee1(1) nodeee2(1)],[nodeee1(2) nodeee2(2)],'-m','LineWidth',2);
        end
    end
end

plot(G.Nodes(:,1),G.Nodes(:,2),'gs','MarkerSize',7,'MarkerFaceColor',[0.5,0.5,0.5]);
plot(G.Endeff(:,1),G.Endeff(:,2),'bs','MarkerSize',7,'MarkerFaceColor',[0.5,0.5,0.5]);
plot(start(1),start(2),'*R','MarkerSize',10);
plot(goal(1),goal(2),'*R','MarkerSize',10);

for i = 1:size(body,4)
    plot(body(:,1,1,i),body(:,2,1,i),'r')
    plot(body(:,1,2,i),body(:,2,2,i),'g')
    plot(body(:,1,3,i),body(:,2,3,i),'b')
end

pos = [o1.Center(1)-o1.Radius o1.Center(2)-o1.Radius o1.Radius*2 o1.Radius*2];
rectangle('Position',pos,'Curvature',[1 1],'FaceColor',[0 .5 .5],'EdgeColor','b',...
    'LineWidth',3)
axis([1,sizeGraph,1,sizeGraph])
axis equal

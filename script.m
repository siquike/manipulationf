%% Dynamics of Robot
%% Build a graph

% subp = 1:prod(size(S)); %linear indeces of matrix V
% connected = % indeces of connected states

% determine qi based on initial configuration of robot
% load states.mat
% n = size(X_body,1);
% iteration1 = round(n*rand(1,1)+.5 + X_body(:,:,1));
% iteration2 = round(n*rand(1,1)+.5 + X_body(:,:,1));
% iteration3 = round(n*rand(1,1)+.5 + X_body(:,:,1));
% [X_body2]= moduleTransform(X_body,X_body(end,:,iteration1),X_body,direction,iteration1);
% [X_body3]= moduleTransform(X_body,X_body2(end,:,iteration2),X_body2,direction,iteration2);
% qi = round(X_body3(end,:,iteration3)*100);
% % qi = round(bodyn(end,:,3));
%%
% load states.mat
% figure
% hold on
% for i = 1:size(X_body,3)
%     plot(X_body(:,1,i),X_body(:,2,i))
% end
%%
qi = [50 60];
K = 300; % K is number of vertices.
goal = [40 70];
dq = [2 2 2];% Incremental distance for the state
nG = 100;
[G,o1,body] = buildRRT(qi,K,dq,nG,goal); 

figure
hold on

A = G.Adjacency;
for i = 1:size(A,1)
    for j = i:size(A,1)
        if A(i,j) == 1
            node1 = G.Coords(i,:);
            node2 = G.Coords(j,:);
            plot([node1(1) node2(1)],[node1(2) node2(2)],'-g','LineWidth',2);
        end
    end
end

plot(G.Nodes(:,1),G.Nodes(:,2),'gs','MarkerSize',7,'MarkerFaceColor',[0.5,0.5,0.5]);
plot(qi(1),qi(2),'*R','MarkerSize',8)
%%
for i = 1:size(body,4)
%     for j = 1:size(body,3)
        plot(body(:,1,1,i),body(:,2,1,i),'r')
        plot(body(:,1,2,i),body(:,2,2,i),'g')
        plot(body(:,1,3,i),body(:,2,3,i),'b')
%     end
end
%%
pos = [o1.Center(1)-o1.Radius o1.Center(2)-o1.Radius o1.Radius*2 o1.Radius*2];
rectangle('Position',pos,'Curvature',[1 1],'FaceColor',[0 .5 .5],'EdgeColor','b',...
    'LineWidth',3)
% fill(x,y,'r')
% plot(A,'-*')
axis([1,nG,1,nG])
axis equal

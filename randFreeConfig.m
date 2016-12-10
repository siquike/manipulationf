function [qrand,bodyn,iteration] = randFreeConfig(G,o1)
load states.mat
% X_body(:,1,:) = X_body(:,1,:) + 0.5;
% X_body(:,2,:) = X_body(:,2,:) + 60;
% n = size(G.Graph);
n = size(X_body,1);
inside = 1;
while inside == 1
%     qrand = [n(1)*rand(1,1) n(2)*rand(1,1)];
    iteration1 = round(n*rand(9,1)+.5);
    iteration2 = round(n*rand(9,1)+.5);
    iteration3 = round(n*rand(9,1)+.5);
    for i = 1:size(iteration1)
        [X_body2]= moduleTransform(X_body,X_body(end,:,iteration1(i)),X_body,direction,iteration1(i));
        [X_body3]= moduleTransform(X_body,X_body2(end,:,iteration2(i)),X_body2,direction,iteration2(i));
        X_body(:,1,:) = X_body(:,1,:) + 0.5;
        X_body2(:,1,:) = X_body2(:,1,:) + 0.5;
        X_body3(:,1,:) = X_body3(:,1,:) + 0.5;
        qrand = X_body3(end,:,iteration3(i))*100;
        inside = o1.Dist(qrand);
        if inside == 0
            bodyn(:,:,1) = X_body(:,:,iteration1(i))*100;
            bodyn(:,:,2) = X_body2(:,:,iteration2(i))*100;
            bodyn(:,:,3) = X_body3(:,:,iteration3(i))*100;
            iteration = [iteration1(i) iteration2(i) iteration3(i)];
            break
        end
    end
% buildArm()
end
end

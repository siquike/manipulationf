function  [X_nmod]= moduleTransform(X_body,X_ee,X_new,direction,iteration)
%
X_new(:,1,iteration) = X_new(:,1,iteration) - X_new(1,1,iteration);
X_new(:,2,iteration) = X_new(:,2,iteration) - X_new(1,2,iteration);
v1 = [X_new(end,1,iteration)-X_new(end-1,1,iteration) X_new(end,2,iteration)-X_new(end-1,2,iteration)];
v2 = [0 1];
theta = direction(iteration)*acos(dot(v1,v2)/(norm(v1)*norm(v2)));
for i = 1:size(X_new,3)
    R = [cos(theta) -sin(theta); 
         sin(theta) cos(theta)];
    X_nmod(:,:,i) = (R*X_body(:,:,i)')';
    v2 = [X_nmod(1,1,i)-X_nmod(2,1,i) X_nmod(1,2,i)-X_nmod(2,2,i)];
    if (pi-abs(acos(dot(v1,v2)/(norm(v1)*norm(v2))))) > .3;
        R = [cos(-theta) -sin(-theta); 
             sin(-theta) cos(-theta)];
        X_nmod(:,:,i) = (R*X_body(:,:,i)')';  
    end
end
X_nmod(:,1,:) = X_nmod(:,1,:) + X_ee(1);
X_nmod(:,2,:) = X_nmod(:,2,:) + X_ee(2);
end
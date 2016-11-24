function  [X_body]= moduleTransform(X_body,X_ee,direction)
%
for i = 1:size(X_body,3)
    X_body(:,1,i) = X_body(:,1,i) - X_body(1,1,i);
    X_body(:,2,i) = X_body(:,2,i) - X_body(1,2,i);
    v1 = [X_body(end,1,i)-X_body(end-1,1,i) X_body(end,2,i)-X_body(end-1,2,i)];
    v2 = [0 1];
%     if direction < 0
    theta(i) = direction(i)*acos(dot(v1,v2)/(norm(v1)*norm(v2)));
%     elseif direction > 0
%         theta = acos(dot(v1,v2)/(norm(v1)*norm(v2)))+pi/2;
%     end
    R = [cos(theta(i)) -sin(theta(i)); 
         sin(theta(i)) cos(theta(i))];
    X_body(:,:,i) = (R*X_body(:,:,i)')';

    X_body(:,1,i) = X_body(:,1,i) + X_ee(1);
    X_body(:,2,i) = X_body(:,2,i) + X_ee(2);
end
end
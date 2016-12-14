function [qnew,bodyn,conf,endeff] = newConfig(qnear,qrand,bodyn,dq,o1,iteration,G,conf)
% Built based on
% http://math.stackexchange.com/questions/180418/calculate-rotation-matrix-to-align-vector-a-to-vector-b-in-3d

v = iteration - conf;
dq(1) = dq(1)*sign(v(1));
dq(2) = dq(2)*sign(v(2));
dq(3) = dq(3)*sign(v(3));
qnew = qnear + dq(1:2);
it = conf + dq;
load states.mat

n = 3;
inside = 1;
while inside == 1
    iteration1 = round(n*rand(1,1)+.5 - n/2 + it(1));
    iteration2 = round(n*rand(1,1)+.5 - n/2 + it(2));
%     iteration1 = round(n*rand(1,1)+.5 - n/2 + iteration(1));
%     iteration2 = round(n*rand(1,1)+.5 - n/2 + iteration(2));
    if iteration1 < 1
        iteration1 = 1;
    end
    if iteration1 > 101;
        iteration1 = 101;
    end
    if iteration2 < 1
        iteration2 = 1;
    end
    if iteration2 > 101;
        iteration2 = 101;
    end
%     iteration3 = round(n*rand(1,1)+.5);
    for i = 1:size(iteration1)
            [X_body2]= moduleTransform(X_body,X_body(end,:,iteration1(i)),X_body,direction,iteration1(i));
            [X_body3]= moduleTransform(X_body,X_body2(end,:,iteration2(i)),X_body2,direction,iteration2(i));
            X_body(:,1,:) = X_body(:,1,:) + 0.5;
            X_body2(:,1,:) = X_body2(:,1,:) + 0.5;
            X_body3(:,1,:) = X_body3(:,1,:) + 0.5;
            qnewcomp = X_body3(end,:,:)*100; 
            qnewcomp = permute(qnewcomp,[3 2 1]);
            [D1,I1] = pdist2(qnewcomp,qnew,'euclidean','Smallest',1);
            [D2,I2] = pdist2(qnewcomp,qnear,'euclidean','Smallest',1);
% %             D1
% %             D2
%             %             [row,col] = find(D' <= 5);
            if D1 < 50 && D2 < 50
                inside = 0;
                bodyn(:,:,1) = X_body(:,:,iteration1(i))*100;
                bodyn(:,:,2) = X_body2(:,:,iteration2(i))*100;
                bodyn(:,:,3) = X_body3(:,:,I1)*100;
%                 qnew = round(bodyn(end,:,3));
                conf = [iteration1(i) iteration2(i) I1];
                endeff = X_body3(end,:,I1)*100;
                break
            end
    end
% buildArm()
end
% Make sure to check if body works
end

% function hat = skew(v)
% hat = [0    -v(3)  v(2);
%        v(3)   0   -v(1);
%       -v(2)  v(1)   0];
% end
function qnew = newConfig(qnear,qrand,dq)
% Built based on
% http://math.stackexchange.com/questions/180418/calculate-rotation-matrix-to-align-vector-a-to-vector-b-in-3d
qrand
qnear
v = qrand - qnear;
dq(1) = dq(1)*sign(v(1));
dq(2) = dq(2)*sign(v(2));
qnew = qnear + dq;
end

% function hat = skew(v)
% hat = [0    -v(3)  v(2);
%        v(3)   0   -v(1);
%       -v(2)  v(1)   0];
% end
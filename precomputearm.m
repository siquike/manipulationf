%% Initialization Parameters

r_ma = 0.025; % [m] % moment arm
r = 0.0125; % [m] radius of arm
l = 0.20;  % [m]
m = 2.5; % [kg]
E = 0.5e+3; % Elastic modulus [N/m^2] (Change)
I = 1/4*m*r^2 + 1/12*m*l^2; % Moment of inertia
F = (-50:50)';

%% Starting Position

x0 = 0;
y0 = 0;
w = 0;

%% Calculation

k = F*r_ma*E*I;

% End Effector Coordinates
x_ee = (1 - cos(k*l))./k + x0;
y_ee = sin(k*l)./k + y0;
middle = 51;
x_ee(middle) = 0;
y_ee(middle) = y_ee(middle-1);


% Body Coordinates and orientation
for i = 1:size(F,1)
    x_module = linspace(0,y_ee(i),size(F,1))';
    y_module = F(i).*x_module.^2./(6.*E.*I).*(3.*l-x_module);
    if i == middle
       y_module = 1; 
    end
    % Scaling
    y_module = y_module/y_module(end)*x_ee(i);
    x_module = x_module/x_module(end)*y_ee(i);
    X_body(:,1,i) = y_module + x0;
    X_body(:,2,i) = x_module + y0;
    % Angle
    v1 = [X_body(end,1,i)-X_body(end-1,1,i) X_body(end,2,i)-X_body(end-1,2,i)];
    v2 = [0 1];
    direction(i) = -sign(F(i));
    angle(i) = direction(i)*acos(dot(v1,v2)/(norm(v1)*norm(v2)));
end

save('states.mat','X_body','angle','direction')

%%
iteration1 = 1;
iteration2 = 1;
iteration3 = 1;
[X_body2]= moduleTransform(X_body,X_body(end,:,iteration1),X_body,direction,iteration1);
[X_body3]= moduleTransform(X_body,X_body2(end,:,iteration2),X_body2,direction,iteration2);
figure
hold on
plot(x_ee,y_ee,'--')
plot(permute(X_body2(end,1,:),[3 2 1]),permute(X_body2(end,2,:),[3 2 1]),'--')
plot(permute(X_body3(end,1,:),[3 2 1]),permute(X_body3(end,2,:),[3 2 1]),'--')
plot(X_body(:,1,iteration1),X_body(:,2,iteration1),'r')
plot(X_body2(:,1,iteration2),X_body2(:,2,iteration2),'g')
plot(X_body3(:,1,iteration3),X_body3(:,2,iteration3),'b')
axis equal

%% Build entire statespace
allstates = [];
for i = 1:size(F,1)
    for j = 1:size(F,1)
        for k = 1:size(F,1)
            iteration1 = i;
            iteration2 = j;
            iteration3 = k;
            [X_body2]= moduleTransform(X_body,X_body(end,:,iteration1),X_body,direction,iteration1);
            [X_body3]= moduleTransform(X_body,X_body2(end,:,iteration2),X_body2,direction,iteration2);
            allstates = [allstates; i j k X_body3(end,1,iteration3) X_body3(end,2,iteration3)];
        end
    end
end
save('allstates.mat','allstates')

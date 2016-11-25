function arm = buildArm()
load states.mat

[X_body2]= moduleTransform(X_body,X_body(end,:,iteration),X_body,direction)
[X_body3]= moduleTransform(X_body,X_body2(end,:,iteration),X_body2,direction)
end
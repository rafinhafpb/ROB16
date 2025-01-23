function [ u ] = BicycleToPoseControl( xTrue,xGoal )
%Computes a control to reach a pose for bicycle
%   xTrue is the robot current pose : [ x y theta ]'
%   xGoal is the goal point
%   u is the control : [v phi]'

k_rho = 30;
k_alpha = 10;
k_bheta = -5;

rho = sqrt((xGoal(1) - xTrue(1))^2 + (xGoal(2) - xTrue(2))^2);
alpha = atan2((xGoal(2) - xTrue(2)), (xGoal(1) - xTrue(1))) - xTrue(3);
alpha = AngleWrap(alpha)
bheta = xGoal(3) - atan2((xGoal(2) - xTrue(2)), (xGoal(1) - xTrue(1)))

v = k_rho * rho;
phi = k_alpha * alpha + k_bheta * bheta;

u = [v; phi];

end


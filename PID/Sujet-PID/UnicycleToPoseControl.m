function [ u ] = UnicycleToPoseControl( xTrue,xGoal )
%Computes a control to reach a pose for unicycle
%   xTrue is the robot current pose : [ x y theta ]'
%   xGoal is the goal point
%   u is the control : [v omega]'

k_rho = 20;
k_alpha = 10;
k_bheta = 25;
alpha_max = pi/3;

rho = sqrt((xGoal(1) - xTrue(1))^2 + (xGoal(2) - xTrue(2))^2);
alpha = atan2 ((xGoal(2) - xTrue(2)), (xGoal(1) - xTrue(1))) - xTrue(3);
alpha = AngleWrap(alpha)

if abs(alpha) > alpha_max
  v = 0;
else
  v = k_rho * rho;
end

if rho > 0.05
  omega = k_alpha * alpha
else
  bheta = xGoal(3) - xTrue(3)
  omega = k_bheta * bheta;
end

u = [v; omega];

end


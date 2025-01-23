function [ u ] = BicycleToPathControl( xTrue, Path )
%Computes a control to follow a path for bicycle
%   xTrue is the robot current pose : [ x y theta ]'
%   Path is set of points defining the path : [ x1 x2 ... ;
%                                               y1 y2 ...]
%   u is the control : [v phi]'

k_rho = 10;
k_alpha = 5;
p = 0.3;

% Persistent index to track the current goal point
persistent index_count xGoal;

if xTrue==[0;0;0]
    index_count=1;
    xGoal = Path(:, index_count);
end

if norm((Path(:, index_count) - xTrue)(1:2)) < p && index_count < size(Path, 2)
  index_count = index_count + 1;
  xGoal = Path(:, index_count - 1);
endif

path_direction = Path(:, index_count) - Path(:, index_count-1);
path_direction = path_direction/norm(path_direction);

if norm(xGoal(1:2) - xTrue(1:2)) < p && norm(Path(:, end) - xTrue) > .001
  xGoal = xGoal + p * path_direction;
endif

rho = sqrt((xGoal(1) - xTrue(1))^2 + (xGoal(2) - xTrue(2))^2);
alpha = atan2 ((xGoal(2) - xTrue(2)), (xGoal(1) - xTrue(1))) - xTrue(3);
alpha = AngleWrap(alpha);

v = k_rho * rho;
phi = k_alpha * alpha;

u = [v; phi];

end


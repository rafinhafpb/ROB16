function [PathSmooth] = InterpolatePath(Path, numPoints)
% Interpolates a given path to create a smoother trajectory.
%
% Inputs:
%   Path      - Original path as [x; y; theta] with size 3xN.
%   numPoints - Number of points to interpolate between consecutive waypoints.
%
% Output:
%   PathSmooth - Smoothed path as [x; y; theta] with more points.

% Initialize the smooth path
PathSmooth = [];

% Loop through each segment of the path
for i = 1:size(Path, 2) - 1
    % Extract start and end points of the current segment
    p1 = Path(:, i);
    p2 = Path(:, i + 1);

    % Interpolate x, y, and theta linearly along the segment
    t = linspace(0, 1, numPoints + 2); % Include endpoints
    xInterp = (1 - t) * p1(1) + t * p2(1);
    yInterp = (1 - t) * p1(2) + t * p2(2);
    thetaInterp = (1 - t) * p1(3) + t * p2(3);

    % Append the interpolated points (excluding the last one to avoid duplicates)
    PathSmooth = [PathSmooth, [xInterp(1:end-1); yInterp(1:end-1); thetaInterp(1:end-1)]];
end

% Add the final point of the original path
PathSmooth = [PathSmooth, Path(:, end)];
end


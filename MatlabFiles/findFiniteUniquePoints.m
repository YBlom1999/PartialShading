function ind = findFiniteUniquePoints(Values)
% findFiniteUniquePoints finds the unique and finite points of a certain
% array that can be used for interpolation
%
% Inputs:
% ------
%   Values: double
%       The values that should be considered
%
% Outputs:
% ------
%   ind: logical
%       The indices of points that are finite and unique
%
% Author: Youri Blom

[~,un_ind] = unique(Values);
ind = zeros(1,length(Values));
ind(un_ind) = 1;
ind = logical(~isinf(Values).*ind);
end
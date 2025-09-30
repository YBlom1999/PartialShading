function [VoltageString] = combineCell2String(Voltage,Current,CurrentString)
% combineCell2String combines the IV curves of the different cells into
% a string of cells
%
% Inputs:
% ------
%   Voltage: double
%       The voltage of all cell IV curves
%   Current: double
%       The current of all cell IV curves
%   CurrentString: double
%       The current axis for the string IV curves should be calculated
%
% Outputs:
% ------
%   VoltageStrings: double
%       The voltage of the string IV curve
%
% Author: Youri Blom

% Initialize a string that represent the voltage of the string
VoltageString = zeros(size(CurrentString));

for cell_i = 1:size(Current,1)
    % For each cell, its voltage is added to the voltage of the string
    ind = ~isinf(Current(cell_i,:));
    VoltageString = VoltageString + interp1(Current(cell_i,ind),Voltage(ind),CurrentString,'linear','extrap');
end

% Since a bypass diode is connected, the minimum voltage of the string is 0
VoltageString = max(VoltageString,0);
end
function [VoltageStrings,VoltageSeries] = combineCell2Series(Voltage,Current,Iaxis)
% combineCell2Series combines the IV curves of the different cells into
% the IV curve of a series-connected module
%
% Inputs:
% ------
%   Voltage: double
%       The voltage of all cell IV curves
%   Current: double
%       The current of all cell IV curves
%   Iaxis: double
%       The current axis for which all substring IV curves should be
%       calculated
%
% Outputs:
% ------
%   VoltageStrings: double
%       The voltage of all substrings IV curves
%   VoltageSeries: double
%       The voltage of the series module IV curve
%
% Author: Youri Blom

% Initialize a string that represent the voltage of all string
VoltageStrings = zeros(3,length(Iaxis));

for str_i = 1:3
    % For each string, the voltage of the corresponding cells are added
    ind = (1:24) + 24*(str_i-1);
    VoltageStrings(str_i,:) = combineCell2String(Voltage,Current(ind,:),Iaxis);
end
VoltageSeries = sum(VoltageStrings);
end
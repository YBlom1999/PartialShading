function [CurrentStrings,Vaxis,VoltageButterfly,CurrentButterfly] = combineCell2Butterfly(Voltage,Current,Iaxis)
% combineCell2Butterfly combines the IV curves of the different cells into
% the IV curve of a butterfly module
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
%   CurrentStrings: double
%       The current of all substrings IV curves
%   Vaxis: double
%       The voltage axis for which all substring IV curves are defined
%   VoltageButterfly: double
%       The voltage of the butterfly module IV curve
%   CurrentButterfly: double
%       The current of the butterfly module IV curve
%
% Author: Youri Blom

% The indices at which all substrings start
start_index = [0,6,24,30,48,54];

% Define a new voltage axis and current array for all substrings IV curves
Vaxis = 0:0.001:max(max(Voltage))*12;
CurrentStrings = zeros(6,length(Vaxis));

for str_i = 1:6
    % For each string, the voltage of the corresponding cells are added
    ind = [1:6, 13:18] + start_index(str_i);
    VoltageStrings = combineCell2String(Voltage,Current(ind,:),Iaxis);
    
    % The IV curve is translated from V(I) to I(V) to support current
    % addition in a later step
    [~,un_ind] = unique(VoltageStrings);
    CurrentStrings(str_i,:) = interp1(VoltageStrings(un_ind),Iaxis(un_ind),Vaxis,'linear','extrap');
end

% The currents of the substrings are added according to the schematic
Istr1 = CurrentStrings(1,:)+CurrentStrings(2,:);
Istr2 = CurrentStrings(3,:)+CurrentStrings(4,:);
Istr3 = CurrentStrings(5,:)+CurrentStrings(6,:);

% The current of the butterfly module is twice the current of a single
% string
CurrentButterfly = 2*Iaxis;

% The voltage of the butterfly module is the sum of all substring voltages
VoltageButterfly = interp1(Istr1,Vaxis,CurrentButterfly,'linear','extrap')+interp1(Istr2,Vaxis,CurrentButterfly,'linear','extrap')+interp1(Istr3,Vaxis,CurrentButterfly,'linear','extrap');
end
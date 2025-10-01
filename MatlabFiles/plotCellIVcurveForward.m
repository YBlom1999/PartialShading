function [fig] = plotCellIVcurveForward(fig,Voltage,Current,Area)
% plotCellIVcurveForward plots the IV curve of cell in forward bias
%
% Inputs:
% ------
%   fig: figure
%       The figure of the cell at forward bias
%   Voltage: double
%       The voltage of the cell IV curve
%   Current: double
%       The current of the cell IV curve
%   Area: double
%       The area of the solar cell
%
% Outputs:
% ------
%   fig: figure
%       The figure of the cell at forward bias
%
% Author: Youri Blom

% Initialize the figure
cla(fig);
hold(fig,"on");
box(fig,"on");
grid(fig,"on");

% Plot the IV curve of the cell at forward bias
plot(fig,Voltage(Voltage>=0),Current(Voltage>=0)/Area/10);

% Specify limits of axis and labels
xlim(fig,[0,Voltage(end)])
ylim(fig,[0,60])
xlabel(fig,'Voltage [V]')
ylabel(fig,'Current [mA/cm^2]')
title(fig,'');
fig.FontSize = 15;

end


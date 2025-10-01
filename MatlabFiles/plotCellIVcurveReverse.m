function [fig] = plotCellIVcurveReverse(fig,Voltage,Current,Area)
% plotCellIVcurveReverse plots the IV curve of cell in reverse bias
%
% Inputs:
% ------
%   fig: figure
%       The figure of the cell at reverse bias
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
%       The figure of the cell at reverse bias
%
% Author: Youri Blom

% Initialize the figure
cla(fig);
hold(fig,"on");
box(fig,"on");
grid(fig,"on");

% Plot the IV curve of the cell at forward bias
plot(fig,Voltage,Current/Area/10);

% Specify limits of axis and labels
xticks(fig,-50:10:0)
xlim(fig,[-50,0])
ylim(fig,[0,60])
xlabel(fig,'Voltage [V]')
ylabel(fig,'Current [mA/cm^2]')
title(fig,'');
fig.FontSize = 15;
end


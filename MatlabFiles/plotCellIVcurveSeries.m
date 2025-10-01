function [fig] = plotCellIVcurveSeries(fig,VoltageString,CurrentString,VoltageSeries,Area)
% plotCellIVcurveSeries plots the IV curve of series module in the figure
%
% Inputs:
% ------
%   fig: figure
%       The figure of the butterfly module
%   VoltageStrings: double
%       The voltage of the substring IV curves
%   CurrentStrings: double
%       The current of the substring IV curves
%   VoltageSeries: double
%       The voltage of the series module IV curve
%   Area: double
%       The area of the solar cell
%
% Outputs:
% ------
%   fig: figure
%       The figure of the series module
%
% Author: Youri Blom

% Initialize the figure
cla(fig);
hold(fig,"on");
box(fig,"on");
grid(fig,"on");

% The legend of the figure
lgd_text = {'String 1','String 2','String 3','Total'};

% Plot the IV curve of the various strings
plot(fig,VoltageString(1,:),CurrentString,'LineWidth',2);
plot(fig,VoltageString(2,:),CurrentString,'LineWidth',2);
plot(fig,VoltageString(3,:),CurrentString,'LineWidth',2);

% Plot the module IV curve
plot(fig,VoltageSeries,CurrentString,'LineWidth',2,'Color','k');

% Calculate and indicate the maximum power point
[Pmpp,mpp_ind] = max(VoltageSeries.*CurrentString);
plot(fig,VoltageSeries(mpp_ind),CurrentString(mpp_ind),'x','MarkerSize',10,'LineWidth',2,'Color','k');
text(fig,0.7*50,1.1*400*Area,append('P_{mpp} = ',num2str(round(Pmpp)),'W'),'FontSize',15)

% Specify limits of axis and labelsxlim(fig,[0,0.7*72])
ylim(fig,[0,1.2*400*Area])
xlabel(fig,'Voltage [V]')
ylabel(fig,'Current [A]')
title(fig,'');
legend(fig,lgd_text,'Location','northoutside','NumColumns',3)
fig.FontSize = 15;

end


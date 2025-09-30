function [fig] = plotCellIVcurveString(fig,Voltage,Current,VoltageString,CurrentString,Shaded,Area,xLimit)
% plotCellIVcurveString plots the IV curve of string
%
% Inputs:
% ------
%   fig: figure
%       The figure of the string
%   Voltage: double
%       The voltage of the cell IV curves
%   Current: double
%       The current of the cell IV curves
%   VoltageString: double
%       The voltage of the string IV curve
%   CurrentString: double
%       The current of the string IV curve
%   Shaded: boolean
%       Index of which cells are shaded
%   Area: double
%       The area of the solar cell
%   xlimit: double
%       Range of voltages that should be shown
%
% Outputs:
% ------
%   fig: figure
%       The figure of the string
%
% Author: Youri Blom

% Initialize the figure
cla(fig);
hold(fig,"on");
box(fig,"on");
grid(fig,"on");

% The legend of the figure
lgd_text = {'Shaded cell','Unshaded cell','Total string'};
lgd_ind = [0,0,1];

if find(Shaded)
    %If there is a shaded cell, plot the IV curve and show its legend
    plot(fig,Voltage,Current(find(Shaded,1),:),'LineWidth',2)
    lgd_ind(1) = 1;
end
if find(~Shaded)
    %If there is an unshaded cell, plot the IV curve and show its legend
    plot(fig,Voltage,Current(find(~Shaded,1),:),'LineWidth',2)
    lgd_ind(2) = 1;
end

% Plot the string IV curve
plot(fig,VoltageString,CurrentString,'LineWidth',2,'Color','k');

% Calculate and indicate the maximum power point
[~,mpp_ind] = max(VoltageString.*CurrentString);
plot(fig,VoltageString(mpp_ind),CurrentString(mpp_ind),'x','MarkerSize',10,'LineWidth',2,'Color','k');

% Specify limits of axis and labels
xlim(fig,xLimit)
ylim(fig,[0,1.2*400*Area])
xlabel(fig,'Voltage [V]')
ylabel(fig,'Current [A]')
title(fig,'');
legend(fig,lgd_text(find(lgd_ind)),'Location','northoutside','NumColumns',3)
fig.FontSize = 15;

end


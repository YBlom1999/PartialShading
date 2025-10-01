function [fig] = plotCellIVcurveButterfly(fig,CurrentStrings,VoltageStrings,VoltageButterfly,CurrentButterfly,Area,plotSeperate)
% plotCellIVcurveButterfly plots the IV curve of butterfly module in the
% figure
%
% Inputs:
% ------
%   fig: figure
%       The figure of the butterfly module
%   CurrentStrings: double
%       The current of the substring IV curves
%   VoltageButterfly: double
%       The voltage of the butterfly module IV curve
%   CurrentButterfly: double
%       The current of the butterfly module IV curve
%   Area: double
%       The area of the solar cell
%   plotSeperate: boolean
%       Indicator whether the seperate a and b strings should be plotted
%
% Outputs:
% ------
%   fig: figure
%       The figure of the butterfly module
%
% Author: Youri Blom

% Obtain the RGB codes of colors
RGB = orderedcolors("gem");

% Initialize the figure
cla(fig);
hold(fig,"on");
box(fig,"on");
grid(fig,"on");

% The legend of the figure
lgd_text = {'String 1','String 2','String 3','Total'};

% Plot the IV curve of the various strings (sum of a and b)
plot(fig,VoltageStrings,CurrentStrings(1,:)+CurrentStrings(2,:),'LineWidth',2,'Color',RGB(1,:));
plot(fig,VoltageStrings,CurrentStrings(3,:)+CurrentStrings(4,:),'LineWidth',2,'Color',RGB(2,:));
plot(fig,VoltageStrings,CurrentStrings(5,:)+CurrentStrings(6,:),'LineWidth',2,'Color',RGB(3,:));

% Plot the module IV curve
plot(fig,VoltageButterfly,CurrentButterfly,'LineWidth',2,'Color','k');

if plotSeperate
    % Plot the a and b substrings if desired
    plot(fig,VoltageStrings,CurrentStrings(1,:),'LineWidth',1,'Color',RGB(1,:),'LineStyle','--');
    plot(fig,VoltageStrings,CurrentStrings(2,:),'LineWidth',1,'Color',RGB(1,:),'LineStyle',':');
    plot(fig,VoltageStrings,CurrentStrings(3,:),'LineWidth',1,'Color',RGB(2,:),'LineStyle','--');
    plot(fig,VoltageStrings,CurrentStrings(4,:),'LineWidth',1,'Color',RGB(2,:),'LineStyle',':');
    plot(fig,VoltageStrings,CurrentStrings(5,:),'LineWidth',1,'Color',RGB(3,:),'LineStyle','--');
    plot(fig,VoltageStrings,CurrentStrings(6,:),'LineWidth',1,'Color',RGB(3,:),'LineStyle',':');
end

% Calculate and indicate the maximum power point
[Pmpp,mpp_ind] = max(VoltageButterfly.*CurrentButterfly);
plot(fig,VoltageButterfly(mpp_ind),CurrentButterfly(mpp_ind),'x','MarkerSize',10,'LineWidth',2,'Color','k');
text(fig,0.7*25,2*1.1*400*Area,append('P_{mpp} = ',num2str(round(Pmpp)),'W'),'FontSize',15)

% Specify limits of axis and labels
xlim(fig,[0,0.7*36])
ylim(fig,[0,2*1.2*400*Area])
xlabel(fig,'Voltage [V]')
ylabel(fig,'Current [A]')
title(fig,'');
legend(fig,lgd_text,'Location','northoutside','NumColumns',4)
fig.FontSize = 15;

end


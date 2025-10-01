function [app] = ExecuteScriptSeries(app)
% ExecuteScriptSeries executes the script needed to calculate the IV
% curve of the series module
%
% Inputs:
% ------
%   app: matlab-object
%       All information and details of the current state of the application
%
% Outputs:
% ------
%   app: matlab-object
%       All information and details of the current state of the application
%
% Author: Youri Blom

% Obtain the selected breakdown voltage and irradiance of the shaded cells
% from the application
Vb = app.BreakdownVoltage_Series.Value;
Irr = app.Irradiance_Series.Value;

% Define a voltage axis for which all cell IV curves should be calculated
Voltage = Vb:0.001:1;

% Check which cells are shaded
Shaded = zeros(1, 72); % Preallocate string array
for i = 1:72
    Shaded(i) = app.("ShadedSeries_" + i).Value;
end

% Initialize an array that represents the current of all cells
Current = zeros(length(Shaded),length(Voltage));

for cell_i = 1:length(Shaded)
    % For each cell, the IV curve is calculated
    if Shaded(cell_i)
        % For a shaded cell, the value from the application is used as
        % irradiance
        [Current(cell_i,:),Area] = makeCellIVcurve(Irr,Voltage,Vb);
    else
        % For a non-shaded cell, a value of 1000 W/m^2 is used
        [Current(cell_i,:),Area] = makeCellIVcurve(1000,Voltage,Vb);
    end
end

% Define a new current axis for the module IV curve
CurrentString = 0:0.01:1.5*max(max(Current(:,Voltage>0)));

% Calculate the module IV curve and substring IV curves
[VoltageSeries,VoltageString] = combineCell2Series(Voltage,Current,CurrentString);

% Plot the results into the figure
app.figSeries = plotCellIVcurveSeries(app.figSeries,VoltageSeries,CurrentString,VoltageString,Area);
end

function [app] = ExecuteScriptCell(app)
% ExecuteScriptCell executes the script needed to calculate the IV
% curve of a single cell
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

% Obtain the selected breakdown voltage and irradiance of the cell from the
% application
Vb = app.BreakdownVoltage.Value;
Irr = app.Irradiance.Value;

% Define a voltage axis for which all cell IV curves should be calculated
Voltage = Vb:0.01:1;

% Calculate the IV curve of the cell
[Current,Area] = makeCellIVcurve(Irr,Voltage,Vb);

% Plot the results of the script into the figures
app.figCellForward = plotCellIVcurveForward(app.figCellForward,Voltage,Current,Area);
app.figCellReverse = plotCellIVcurveReverse(app.figCellReverse,Voltage,Current,Area);
end
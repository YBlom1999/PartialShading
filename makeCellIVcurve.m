function [Current,Area] = makeCellIVcurve(Irradiance,Voltage,BreakDownVoltage)
% makeCellIVcurve calculates the IV curve of a single cell at forward and
% reverse bias. At reverse bias, the model of Alonso-Garcia is used[1].
%[1] M. C. Alonso-Garcia, J. M. Ruiz, Analysis and modelling the reverse
% characteristic of photovoltaic cells, Solmat 90 (7), 1105-1120 (2006), 
% https://doi.org/10.1016/j.solmat.2005.06.006
%
% Inputs:
% ------
%   Irradiance: double
%       The amount of irradiance the cell receives
%   Voltage: double
%       The voltage for which the IV curve is defined
%   BreakdownVoltage: double
%       The breakdown voltage of the cell
%
% Outputs:
% ------
%   Current: double
%       The current of the cell IV curve
%   Area: double
%       The area of the solar cell
%
% Author: Youri Blom

% Constants
Area = 0.21*0.21; %A cell size of G12 is assumed
k=1.3806e-23;
q=1.6022e-19;
T = 298.15;

% Assumption on the cell behaviour
Jph = 400*Irradiance/1000; %[A/m^2]
n = 1.2; %[-]
J0 = 10^-7; %[A/m^2]
Be = 7; %[-]
phi_t = 0.5; %[V]

% Initialize an array for the cell current
Current = zeros(size(Voltage));

% Make indices for positive and negative voltages
Pos_Vol = Voltage >= 0;
Neg_Vol = Voltage < 0;

% The current at forward bias is defined with a one-diode equivalent model
Current(Pos_Vol) = Area*(Jph - J0*(exp(q*Voltage(Pos_Vol)/n/k/T)-1));

% The current at reverse bias is defined with the model from Alonso-Garcia[1]
K_e = exp(Be*(1-sqrt((phi_t-BreakDownVoltage)./(phi_t-Voltage(Neg_Vol)))));
Current(Neg_Vol) = Area*Jph./(1-K_e);

end
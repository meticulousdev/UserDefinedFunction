function excelData = ImportDataFromExcel(fileName, ext, unitT, unitP)
% Program: ImportDataFromExcel.m
% File Type: m file (function)
% Date: 20190606
% 
% This function imports data from excel file 'fileName'.
% And then, return dataset in structure
%
% Input: fileName 
% File name of excel file
% Output: excelData
% Structure of dataset
%
% A     B   C     D     E   F   G   H    I     J    K    L
% 1     2   3     4     5   6   7   8    9    10   11   12
% Day   Tf  Qb    Qp    Pf  Pb  Pp  Rec  DP   Cf   Cp   dTime
%       oC  m3/h  m3/h  bar bar bar  -   bar  ppm  ppm  day
%       K               Pa  Pa  Pa       Pa
% 
%
%
%
%
% fileName : -
% ext : ('xls' and 'csv') or ('xlsx')
% unitT : 'K' stands for Kelvin and 'C' stands for Celsious
% unitP : 'P' stands for Pascal and 'B' stands for Bar

if strcmp(ext, 'xls') || strcmp(ext, 'csv')
    excelLoad = readmatrix(fileName);
elseif strcmp(ext, 'xlsx')
    excelLoad = readmatrix(fileName);
else
    
end

excelData.day = excelLoad(:, 1);                    % Operation days [day]
excelData.dTime = excelLoad(:, 12);                 % Date in time [day]

if strcmp(unitT, 'K')
    excelData.Tf = 273.15 + excelLoad(:, 2);        % Operation temperature [K]
elseif strcmp(unitT, 'C')
    excelData.Tf = excelLoad(:, 2);                 % Operation temperature [oC]
else
    
end

excelData.Cf = excelLoad(:, 10);                   % Feed concentration [mg/L][ppm]
excelData.Cp = excelLoad(:, 11);                   % Permeate concentration [mg/L][ppm]

% To calculate flow rate per one vessel, Q should be divided by
% membrane area and the number of vessel. 
excelData.Qb = excelLoad(:, 3);                    % Flow rate of concentrate (brine, retentate) [m3/h]
excelData.Qp = excelLoad(:, 4);                    % Permeate flow rate [m3/h]
excelData.Qf = excelData.Qb + excelData.Qp;        % Feed flow rate [m3/h]

if strcmp(unitP, 'P')
    excelData.Pf = excelLoad(:, 5) * 1e5;          % Feed pressure [Pa]
    excelData.Pb = excelLoad(:, 6) * 1e5;          % Retentate (brine, retentate) pressure [Pa]
    excelData.Pp = excelLoad(:, 7) * 1e5;          % Permeate pressure [Pa]
    excelData.DP = excelLoad(:, 9) * 1e5;
elseif strcmp(unitP, 'B')
    excelData.Pf = excelLoad(:, 5);                % Feed pressure [bar]
    excelData.Pb = excelLoad(:, 6);                % Retentate (brine, retentate) pressure [bar]
    excelData.Pp = excelLoad(:, 7);                % Permeate pressure [bar]
    excelData.DP = excelLoad(:, 9);                % Pressure Drop [bar]
else
    
end

excelData.Rec = excelLoad(:, 8);
end

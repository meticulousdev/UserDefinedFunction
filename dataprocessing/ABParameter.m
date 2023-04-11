function [A, B] = ABParameter(excelData, mArea, nPV, nEle)
%% [0] Program Information
% Program: ABParameter.m
% File Type: function file
% Last modification date : 20161218
% 
% Calculate water permeability (A) and salt permeability (B) using plant 
% operating data.
% 
% Input : excelData
% Output : A, B
% 
% Please contact to me, if you have any question about this code.
% e-mail : meticulousdev@gmail.com
% 
%% [1] Data assignment
% Pf : Feed pressure [bar]
% Pb : Retentate (brine, retentate) pressure [bar]
% Pp : Permeate pressure [bar]
% Rec : % Recovery ratio of RO system
% Cf : Feed concentration [mg/L][ppm]
% Cp : Permeate concentration [mg/L][ppm]
% Qp : Permeate flow rate [m3/h]
Pf = excelData.Pf;
Pb = excelData.Pb;
Pp = excelData.Pp;

Cf = excelData.Cf;
Cp = excelData.Cp;

Qb = excelData.Qb;
Qp = excelData.Qp;

Rec = Qp ./ (Qb + Qp);
%% [1] Condition setup 
% SWC3 membrane area 34.4 m2
% memArea : chennel length [m]
% numVessel : Number of vessel
% numElement : Numver of Element
% mArea = 37;
% 
% nPV = 1;
% nEle = 7;

%% [2-1] A parameter
% CF : Concentration factor
% avgCf : Average feed salinity [ppm]
% avgPi : Average osmotic pressure
% NDP : Net driving pressure
% avgFlux : Average element permeate flux in the system
% A : Water permeability

CF = log(1 ./ (1 - Rec)) ./ Rec;
avgCf = Cf .* CF;
avgPosm = 0.5 * avgCf / 1000;
NDP = Pf - 0.5 * (Pf - Pb) - Pp - avgPosm;
avgFlux =  Qp / nPV / nEle / mArea * 1000;

A = avgFlux ./ NDP;         % [LMH / bar]

%% [2-2] B parameter
B = avgFlux .* (Cp ./ avgCf);
% Use empirical model in here (Ȯ�� �ʿ�)
% B = (0.0432 * (A).^2 - 0.0686 * A + 0.0651) * 10;         % [LMH]
% B = 0.0638 * A - 0.0323;         % [LMH]
end

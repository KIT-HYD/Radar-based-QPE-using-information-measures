function [Z]=f_dBZ2Z(dBZ)

% Funktion die vom dBZ Wert Z berechnet
% kurz und schmerzlos
%
%
% author: Malte Neuper (malte.neuper(at)web.de)
% Version vom 02.04.2014 
% modified 02.04.2014         To DOs

zwi=dBZ/10;
zwi=10.^(zwi);
Z=zwi;

end
function [R]=f_dBZ2R_easy_a_b(dBZ,a,b)

% Funktion die vom dBZ Wert  fuer vorgegebene Parameter a und b die Regenrate
% R in [mm/h]
% Z2R_easy_a_b(Z) benutzt als default a=200, b=1.6 (klassische Marshall-Palmer Beziehung
%
% author: Malte Neuper (malte.neuper(at)web.de)
% Version vom 08.04.2014 
% modified 08.04.2014         To DOs noch fuer Matrizen mit .*


if nargin<3
  b=1.6;
end

if nargin<2
  a=200;
end

Z=f_dBZ2Z(dBZ);

zwi=Z/a;

R=(zwi.^(1/b));
 
end
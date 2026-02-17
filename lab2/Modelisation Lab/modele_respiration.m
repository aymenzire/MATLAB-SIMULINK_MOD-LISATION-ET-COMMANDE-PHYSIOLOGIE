function [dx,y] = modele_respiration(x,u)
% Déclaration des paramètres
C_L = 0.2;
C_W = 0.2;
C_S = 0.005;
C_T = 1/(1/C_L + 1/C_W + 1/C_S);
R_C = 1;
R_P = 0.5;
L_C = 0.005;
L_P = 0.005;

% Déclaration des matrices
A= ...
B= ...
C= ...
D= ...

% Evaluation du modèle d’état
dx= ...
y= ... ;

end
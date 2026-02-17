function y = methode_euler(fonction,x0,u,dt)
% fonction | fonction contenant le modèle d’état
% x0 | vecteur d’état initial
% u | vecteur d’entrée
% dt | pas de résolution
% Longueur du vecteur d’entrée = longueur du vecteur de temps

n = length(u);
% Initialisation et allocation des vecteurs de données x et y
[dx,y0] = fonction(x0,u(1));
x = [ x0, zeros( length(x0),n-1 ) ];
y = [ y0, zeros( length(y0),n-1 ) ];

% Boucle de la méthode d’Euler
for k = 1:n-1
[dx_k,y_k] = fonction(x(:,k),u(k));
x_k_plus_1 = ... ; % Itération k+1 à compléter
x(:,k+1) = x_k_plus_1;
y(:,k+1) = y_k;
end
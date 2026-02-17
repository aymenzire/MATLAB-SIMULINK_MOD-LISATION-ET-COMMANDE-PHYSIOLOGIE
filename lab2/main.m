%1.1 Fonction de transfert
%%1
K=1;
to=1;
s=tf('s');
F=K/(to*s+1);
%step(F)
T_5=stepinfo(F,"SettlingTimeThreshold",0.05,'RiseTime',[0.1,0.9])
T_1=stepinfo(F,"SettlingTimeThreshold",0.01,'RiseTime',[0.1,0.9])
T_theo5=3*to;;
T_theo1=5*to;
fprintf(['la valeur théorique avec un temps de réponse de 5 pourcent est %d, ' ...
    'tandis que lui à 1 pourcent est %d'],T_theo5, T_theo1)
%sur le graphique j'obtient pour 5% un temps de réponse de 3s et pour 1%
%j'ai un temps de réponse de 4,61s

%%2
K=1;
figure(1)
% Plot the step response for the original transfer function F

legend('F_1', 'F_2', 'F_3');
title('Influence du to');
xlabel('Time (s)');
ylabel('Response');

s=tf('s');
F_1=1/(s+1);
step(F_1)
hold on
s=tf('s');
F_2=1/(2*s+1);
step(F_2)
hold on
s=tf('s');
F_3=1/(5*s+1);
step(F_3)
hold off

%% 3
figure(2)
% Plot the step response for the original transfer function F

legend('K_1', 'K_2', 'K_5');
title('Influence du K');
xlabel('Time (s)');
ylabel('Response');

s=tf('s');
K_1=1/(s+1);
step(K_1)

hold on
s=tf('s');
K_2=2/(s+1);
step(K_2)

hold on 
s=tf('s');
K_5=5/(s+1);
step(K_5)

hold off

%% 4

clear; close all; clc;
K = 1;
tau = 1;

s = tf('s');

F_0 = K*(0*s + 1)/(tau*s + 1);
F_1 = K*(0.1*s + 1)/(tau*s + 1);
F_2 = K*(0.2*s + 1)/(tau*s + 1);
F_3 = K*(0.5*s + 1)/(tau*s + 1);
F_4 = K*(2*s + 1)/(tau*s + 1);

figure(3); hold on; grid on;
step(F_0); step(F_1); step(F_2); step(F_3); step(F_4);

legend('T=0','T=0.1','T=0.2','T=0.5','T=2','Location','southeast');
title('Step responses of F(s)=K(Ts+1)/(tau s+1), K=1, tau=1');
xlabel('Time (s)');
ylabel('Response');
hold off;

%% 5


%% 1.1.2 système du deuxième ordre

%1

s = tf('s');
F = 20/(s^2 + 2*s + 4);

% Réponse à l'échelon
figure;
step(F)
grid on
title('Réponse à l''échelon unité')

omega = 2;
xi = 0.5;
K = 5;

omega_d = omega*sqrt(1-xi^2);

Ts_theorique = 4/(xi*omega);          % Temps de réponse 2%
Mp_theorique = exp(-xi*pi/sqrt(1-xi^2))*100; % Dépassement %
Tp_theorique = pi/omega_d;            % Temps de pic

% Informations numériques exactes
info = stepinfo(F);

Ts_num = info.SettlingTime;           % Temps de réponse 2%
Mp_num = info.Overshoot;              % Dépassement %
Tp_num = info.PeakTime;               % Temps de pic
Tr_num = info.RiseTime;               % Temps de montée (10%-90%)

% Affichage
disp('--- Paramètres identifiés ---')
disp(['K = ', num2str(K)])
disp(['xi = ', num2str(xi)])
disp(['omega = ', num2str(omega)])

disp(' ')
disp('--- Résultats théoriques ---')
disp(['Ts (2%) = ', num2str(Ts_theorique)])
disp(['Mp (%) = ', num2str(Mp_theorique)])
disp(['Tp = ', num2str(Tp_theorique)])

disp(' ')
disp('--- Résultats numériques MATLAB ---')
disp(['Ts (2%) = ', num2str(Ts_num)])
disp(['Mp (%) = ', num2str(Mp_num)])
disp(['Tp = ', num2str(Tp_num)])
disp(['Tr (10-90%) = ', num2str(Tr_num)])



%% q2

%Influence du facteur d'amortissement xi (K=1, w=1)
clear; clc; close all;

s = tf('s');
K = 1;
w = 1;

xis = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 2];
t = 0:0.01:20;

% Réponses à l'échelon superposées
figure; hold on; grid on;
for xi = xis
    F = (K*w^2)/(s^2 + 2*xi*w*s + w^2);
    y = step(F,t);
    plot(t,y,'DisplayName',sprintf('\\xi = %.1f',xi));
end
title('Réponses à l''échelon (K=1, \omega=1) pour différents \xi')
xlabel('Temps (s)')
ylabel('Sortie')
legend('Location','eastoutside');

% Évolution des pôles
figure; hold on; grid on;
for xi = xis
    % pôles : racines de s^2 + 2*xi*w*s + w^2 = 0
    p = roots([1 2*xi*w w^2]);
    plot(real(p),imag(p),'x','MarkerSize',8,'LineWidth',1.5, ...
        'DisplayName',sprintf('\\xi = %.1f',xi));
end
xlabel('Re(s)')
ylabel('Im(s)')
title('Évolution des pôles en fonction de \xi (K=1, \omega=1)')
yline(0); xline(0);

%% Q3 : xi négatif
K = 1; w = 1;
xis_neg = [-0.5 -1 -2];
t10 = 0:0.001:10;

figure; hold on; grid on;
for xi = xis_neg
    F = (K*w^2)/(s^2 + 2*xi*w*s + w^2);
    y = step(F,t10);
    plot(t10,y,'DisplayName',sprintf('\\xi = %.1f',xi));
end
title('Q3: Réponses à l''échelon (K=1, \omega=1) pour \xi négatif')
xlabel('Temps (s)'); ylabel('Sortie');
legend('Location','best');

disp('=== Q3: Valeur des pôles (K=1, w=1) ===')
for xi = xis_neg
    p = roots([1 2*xi*w w^2]);
    fprintf('xi = %.1f -> p1 = %.4f%+.4fj, p2 = %.4f%+.4fj\n', ...
        xi, real(p(1)), imag(p(1)), real(p(2)), imag(p(2)));
end

%% Q4 : influence de w
K = 1; xi = 0.5;
ws = [1 2 5];
t20 = 0:0.001:20;

figure; hold on; grid on;
for w = ws
    F = (K*w^2)/(s^2 + 2*xi*w*s + w^2);
    y = step(F,t20);
    plot(t20,y,'DisplayName',sprintf('\\omega = %g',w));
end
title('Q4: Réponses à l''échelon (K=1, \xi=0.5) pour différents \omega')
xlabel('Temps (s)'); ylabel('Sortie');
legend('Location','best');

figure; hold on; grid on;
for w = ws
    p = roots([1 2*xi*w w^2]);
    plot(real(p),imag(p),'x','MarkerSize',9,'LineWidth',1.5, ...
        'DisplayName',sprintf('\\omega = %g',w));
end
xlabel('Re(s)'); ylabel('Im(s)');
title('Q4: Évolution des pôles en fonction de \omega (\xi=0.5)')
yline(0); xline(0);
legend('Location','best');

disp('=== Q4: Pôles (K=1, xi=0.5) ===')
for w = ws
    p = roots([1 2*xi*w w^2]);
    fprintf('w = %g -> p1 = %.4f%+.4fj, p2 = %.4f%+.4fj\n', ...
        w, real(p(1)), imag(p(1)), real(p(2)), imag(p(2)));
end

%% Q5 : ajout d'un zéro (T >= 0)
K = 1; xi = 0.5; w = 1;
Ts_pos = [0 0.1 1 5];
t20 = 0:0.001:20;

figure; hold on; grid on;
for T = Ts_pos
    Fz = (K*w^2*(T*s + 1))/(s^2 + 2*xi*w*s + w^2);
    y = step(Fz,t20);
    plot(t20,y,'DisplayName',sprintf('T = %g',T));
end
title('Q5: Influence du zéro (K=1, \xi=0.5, \omega=1, T >= 0)')
xlabel('Temps (s)'); ylabel('Sortie');
legend('Location','best');

%% Q6 : zéro dans le demi-plan droit (T < 0) 
Ts_neg = [0 -0.1 -1 -5];

figure; hold on; grid on;
for T = Ts_neg
    Fz = (K*w^2*(T*s + 1))/(s^2 + 2*xi*w*s + w^2);
    y = step(Fz,t20);
    plot(t20,y,'DisplayName',sprintf('T = %g',T));
end
title('Q6: Zéro demi-plan droit (K=1, \xi=0.5, \omega=1, T < 0)')
xlabel('Temps (s)'); ylabel('Sortie');
legend('Location','best');

disp('=== Q6: Zéro = -1/T (attention: T=0 -> pas de zéro) ===')
for T = Ts_neg
    if T == 0
        fprintf('T = 0 -> aucun zéro ajouté\n');
    else
        a = 1/T;              % car T = 1/a
        z = -a;               % zéro en s = -a
        fprintf('T = %g -> a = %g -> zéro en s = %g\n', T, a, z);
    end
end

%% 1.1.3 Systèmes d'ordre supérieur (F1 et F2)

%% Cas F1(s)
F1 = 10 / ((s+0.5)*(s^2 + 5*s + 25));
p1 = pole(F1);

% Approximation ordre 1 (pôle dominant -0.5)
F1app = 0.4/(s+0.5);

fprintf('\n=== F1: Pôles du système original ===\n');
for k = 1:length(p1)
    fprintf('p%d = %.4f %+.4fj\n', k, real(p1(k)), imag(p1(k)));
end

fprintf('\nApproximation choisie: F1app = 0.4/(s+0.5)\n');

% Plan des pôles
figure; grid on;
pzmap(F1);
title('F1: pôles (système original)')

% Réponse indicielle comparée
t1 = 0:0.001:20;
figure; hold on; grid on;
step(F1, t1);
step(F1app, t1);
title('F1: réponse à l''échelon, original vs approximation ordre 1')
legend('F1 original','F1 approx ordre 1','Location','best');

%% Cas F2(s)

F2 = 8 / ((0.05*s + 1)*(0.1*s + 1)*(s^2 + s + 4));

p2 = pole(F2);

% Approximation ordre 2 (pôles dominants du 2e ordre)
F2app = 8/(s^2 + s + 4);

fprintf('\n=== F2: Pôles du système original ===\n');
for k = 1:length(p2)
    fprintf('p%d = %.4f %+.4fj\n', k, real(p2(k)), imag(p2(k)));
end

fprintf('\nApproximation choisie: F2app = 8/(s^2 + s + 4)\n');

% Plan des pôles
figure; grid on;
pzmap(F2);
title('F2: pôles (système original)')

% Réponse indicielle comparée
t2 = 0:0.001:20;
figure; hold on; grid on;
step(F2, t2);
step(F2app, t2);
title('F2: réponse à l''échelon, original vs approximation ordre 2')
legend('F2 original','F2 approx ordre 2','Location','best');

%QUIZ DU PROCHAIN COURS
%droit à tout, fichier simulink, et note de cours, etc
%question reprend ce qu'On fait en labo, mais ça ce fait en 2h
%quand on ouvre matlab ya un onglet en haut appelé home, préférence, menu souvre avec simulink, open simulink, modal file, DÉCOCHER : indication poru pas do not open newer vrsion simulink
%PAPIER
%temps de réponse, dépassement des trucs demee à comprendre, relation
%dépassement et xi, 
% RETROUVER PARAMÈTRE AVEC DÉPASSEMENT ET TEMPS DE PIC

minreal(feedback(,))
%% Les bases
% Variables
a=2
b=3;

% Opérateurs
c=a*a+b/a-a;

% Fonction help

%% Les matrices

A = [1 2 3 ; 4 5 6 ; 7 8 9]

B = [1 2 3
     4 5 6
     7 8 9]
 
C = A.*B
D = A*B

B(1,2)
B(1,:)
B([1,3],:)
B(:,1)

%% Les graphes
% données
t=0:0.01:10;
y=sin(t);
y2=cos(t);

%Affichage sur un même graphe
figure(1)
plot(t,y,"+");
hold on
plot(t,y2);
title("Exemple de graphe")
xlabel("Temps")
ylabel("Amplitude")
legend("sin(t)","cos(t)")

%Subplot
figure(2)
subplot(1,2,1)
plot(t,y,"+");
title("Graphe 1")
xlabel("Temps 1")
ylabel("Amplitude 1")
legend("sin(t)")

subplot(1,2,2)
plot(t,y2);
title("Graphe 2")
xlabel("Temps 2")
ylabel("Amplitude 2")
legend("cos(t)")


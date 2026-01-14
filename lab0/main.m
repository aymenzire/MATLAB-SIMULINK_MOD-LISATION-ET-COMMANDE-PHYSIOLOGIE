%Fonctions de transfert et modèle d'état
%P=[6 5 0 3 2 1 0]
%Pour obtenir les racines on met les polynomes dans un vecteur
%roots(P)
%damp(P)
%F=tf([1 1 0],[1 3 1 1]);%ou
%s=tf('s');
%F=(s^2+s)/(s^3+3*s^2+s+1);
%pole(F);
%zero(F);
%dcgain(F);
%zpk(F);

%F=tf([1],[1 1])
%G=F/1+F
%H=minreal(F/1+F)
%A=[0 1 0; 0 0 1; -1 -1 -3];
%B=[0; 0; 1];
%C=[0 1 1];
%D=[0];
%sys=ss(A,B,C,D);

%sys.a
%damp(sys)
%eig(sys)
%pole(sys)

%tf(sys)
%zpk(sys)

F=1/(s^3+3*s^2+s+1)

stepinfo(F)
adsfasdf
asdf


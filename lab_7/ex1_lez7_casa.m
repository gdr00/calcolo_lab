clear all;
clc; 

y= [1.081472368639318; 0.815623938503011; 0.264095434559032;
-0.252848906174545; -0.892111226657974; -1.459959155014975;
-1.766075861433004; -1.819704100115936; -1.613278176259043;
-1.250824907620662; -0.862891009748491; -0.314666627135050;
0.046156477792090; 0.182512161087846; 0.190879110714435;
-0.080869277646918; -0.371753017609851; -0.654997944383704;
-0.908605679502703; -0.955459143503488; -0.824901178793667;
-0.505623916026125; 0.122274653404417; 0.748401831158879;
1.299060920457728; 1.735835000538698; 1.940338650596930;
1.859694970292042; 1.613403187791179; 1.136844347208049;
0.708708595857479; 0.215190648098014; -0.039799084319580;
-0.143340812469280; -0.017595122703702; 0.328483160028172;
0.654742714596673; 0.916442688538714; 1.140889511394805;
1.003444608050291];

% Definisco vettori riga
y = y';
x = linspace(-pi,pi,length(y));

% Parametri
N = 10;
x0 = pi/4;

% Calcolo dei coefficienti del polinomio 1
coeff1 = polyfit(x,y,10);

% Valutazione in x0 del polinomio 1
pol1valx0 = polyval(coeff1,x0);

% Calcolo dei coefficienti del polinomio 2
coeff2 = polyfit(x(2:2:end),y(2:2:end),10);

% Valutazione in x0 del polinomio 2
pol2valx0 = polyval(coeff2,x0);

% Funzione sottostante senza rumore
f = @(x) sin(x) - cos(3*x);

% Calcolo errori assoluti
err1 = abs(f(x0) - pol1valx0);
err2 = abs(f(x0) - pol2valx0);

fprintf('\n \t Il valore del polinomio 1 in x0: %1.10e \n', pol1valx0)
fprintf('\n \t Il valore del polinomio 2 in x0: %1.10e \n', pol2valx0)
fprintf('\n \t Errore del polinomio 1 in x0: %1.10e \n', err1)
fprintf('\n \t Errore del polinomio 2 in x0: %1.10e \n', err2)
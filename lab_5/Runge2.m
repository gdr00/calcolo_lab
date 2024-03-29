clear all
close all
clc
% dati globali
f=@(x) 1./(25*x.^2+1);
a=-1;b=1; % estremi intervallo
m=5001; % num punti valutazione
degs=2:2:20; % gradi polinomiali considerati
%% corpo dell'esperimento
xeval=linspace(a,b,5001);
f_eval=f(xeval)';
E_equi=[];
E_cheb=[];
for n=degs
    xinterp_equi=linspace(a,b,n+1);
    yinterp_equi=f(xinterp_equi)';
    xinterp_cheb=cos((2*(n:-1:0)+1)./(2*n+2)*pi); % pti di Chebyshev
    %xinterp_cheb=cos((n:-1:0)./n*pi); % pti di Gauss-Chebyshev
    yinterp_cheb=f(xinterp_cheb)';
    L_equi=LagrangePoly(xinterp_equi,xeval);
    L_cheb=LagrangePoly(xinterp_cheb,xeval);
    yeval_equi=L_equi*yinterp_equi;
    yeval_cheb=L_cheb*yinterp_cheb;
    c_equi_inter=polyfit(xinterp_equi, yinterp_equi, length(xinterp_equi)-1);
    c_cheb_inter=polyfit(xinterp_cheb, yinterp_cheb, length(xinterp_cheb)-1);
    
    y_equi_inter=polyval(c_equi_inter, xinterp_equi);
    y_cheb_inter=polyval(c_cheb_inter, xinterp_cheb);
    figure(1);
    plot()
    %figure(1);
    %plot(xeval,f_eval,'LineWidth',2);
    %hold on
    %plot(xinterp_equi,yinterp_equi,'*')
    %plot(xinterp_cheb,yinterp_cheb,'p')
    %plot(xeval,yeval_equi);
    %plot(xeval,yeval_cheb);
    %legend('f Runge','dati interpolati equi','dati interpolati Cheb',...
    %    'Interp. equi','Interp. cheb')
    %title(['Interpolazione a grado ' num2str(n)]);
    %hold off
    pause()
    E_equi_inter=[E_equi,max(abs(yinterp_equi-y_equi_inter))];
    E_cheb_inter=[E_cheb,max(abs(yinterp_cheb-y_cheb_inter))];
    E_poli_equi =[E_equi,max(abs(y_equi_inter-yeval_equi))];
    E_poli_cheb =[E_cheb,max(abs(y_cheb_inter-yeval_cheb))];
end
%% grafico errori
figure(2);
semilogy(degs,E_equi);
hold on
semilogy(degs,E_cheb);
xlabel('grado di interpolazione');
ylabel('errore assoluto')
legend('err interp equi','err interp cheb');
title('Errori')
hold off
%% stampa a video
A=[degs;E_equi;E_cheb];
fprintf('Interpolazione della f. di Runge\n')
fprintf('-----------------------------------------------------\n')
fprintf(['Parametri: a=-1, b=1, ' num2str(m) ' punti di valutazione\n'])
fprintf('-----------------------------------------------------\n')
fprintf('Risultati:\n')
fprintf('|grado|\t |err interp equi   |\t |err interp cheb   |\n')
fprintf('-----------------------------------------------------\n')
fprintf('|%5d|\t |%1.12e|\t |%1.12e| \n',A)
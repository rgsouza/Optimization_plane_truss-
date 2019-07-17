% Programa para minimizar a fun��o objetivo correspondente ao peso da treli�a
% plana de 10 barras
% Desenvolvido por: Rayanne Souza & Manoel Feliciano
%
% PUC-Rio  
% Abr.2017
% ------------------------------------------------------------------------

clc
close all
clear all %#ok<CLALL>
format long
%#ok<*NOPTS>


%% Define constantes de ajuste do problema
max_it=50; %n�mero m�ximo de itera��es
tol=1e-5; %toler�ncia num�rica
d_0=0.1*ones(10,1); %ponto inicial
%delta=1e-3; %incremento alfa barreira
delta=2e-5; %incremento alfa penalidade
tam=size(d_0,1); %determina a dimens�o do problema 
rp=0.01; %fator de penalidade
rb=100; %/fator de barreira
betap=10; %beta para m�todo da penalidade
betab=0.5; %beta para m�todo da barreira
d(:,1)=d_0;

k=1; %contador de itera��es

menu_cr=menu('M�todo de otimiza��o com restri��o','Penalidade',...
    'Barreira');
menu_sr=menu('M�todo de otimiza��o sem restri��o','Univariante',...
    'Powell');

tic
while(k<=max_it)

    %otimiza��o
    switch menu_cr
        case 1
            [dmin, x]=otim_semrest(menu_sr,menu_cr,rp,500,tol,d_0,...
                delta,tam);
        case 2
            [dmin, x]=otim_semrest(menu_sr,menu_cr,rb,500,tol,d_0,...
                delta,tam);    
    end
    d(:,k) = dmin; 
    d_0=dmin; %atualiza valor de d_0
    tp = 0;
    
    switch menu_cr
        case 1
            tp = rest (d_0, rp, menu_cr)           
        case 2
            [tp, c] = rest (d_0, rb, menu_cr)
    end

    phi_value(:,k) = phi( d_0, tp );
    vrp(:,k) = rp;
    vrb(:,k) = rb;
    %checa converg�ncia
    if(abs(tp)<tol)
        break;
    else
        k=k+1; %incrementa contador
        %corrige fator de penalidade/barreira com o beta adequado
        switch menu_cr
            case 1
                rp=rp*betap;
            case 2
                rb=rb*betab;
        end
    end
  
end

toc



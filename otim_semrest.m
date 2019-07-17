function [ x_post, x ] = otim_semrest(metodo, menu_cr, r, max_it,tol,x_0,delta,tam )

%% Define vari�veis auxiliares
k=1; %contador de itera��es
x_atual=x_0; %ponto atual para a 1a itera��o
dir=zeros(tam,max_it); %matriz para guardar dire��es
x(:,1)=x_0; %matriz para guardar os pontos
dir_powell=eye(tam); %matriz para as dire��es de Powell

while(k<=max_it)
    %% Define equa��o de recorr�ncia
    calc_x_post=@(alfa,d) x_atual+alfa.*d;
    
    
    %% Encontra a dire��o de busca utilizando Univariante ou Powell
    switch metodo
        case 1
            d=univariante(k,tam);
        case 2
            [d, dir_powell]=powell(x, k, dir_powell, tam);
    end
    
    %% Encontra o intervalo de busca de alfa pelo M�todo do Passo Constante
    [alfa_l,alfa_u, delta]=passoconstante(delta,x_atual,d,r, menu_cr);
    %% Encontra o valor de alfa pelo M�todo da Se��o �urea
    alfa=secao_aurea(alfa_l,alfa_u,x_atual,d,tol,r, menu_cr);
  
    
    %% Encontra o novo ponto com a dire��o e alfa definidos anteriormente
    x_post=calc_x_post(alfa,d);
    
    if( k == 1)
        x_1 = x_post;
    end
   
    
    %% Condi��o de converg�ncia       
    if( norm(x_post - x_atual)/norm( x_1 - x_0) < tol)
        break
    end
   
    x_atual=x_post; %atualiza valor de x
    dir(:,k)=d; %guarda dire��o
    k=k+1; %incrementa contador de itera��es
    x(:,k)=x_post; %guarda ponto
   
end

end


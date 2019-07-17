function [ x_post, x ] = otim_semrest(metodo, menu_cr, r, max_it,tol,x_0,delta,tam )

%% Define variáveis auxiliares
k=1; %contador de iterações
x_atual=x_0; %ponto atual para a 1a iteração
dir=zeros(tam,max_it); %matriz para guardar direções
x(:,1)=x_0; %matriz para guardar os pontos
dir_powell=eye(tam); %matriz para as direções de Powell

while(k<=max_it)
    %% Define equação de recorrência
    calc_x_post=@(alfa,d) x_atual+alfa.*d;
    
    
    %% Encontra a direção de busca utilizando Univariante ou Powell
    switch metodo
        case 1
            d=univariante(k,tam);
        case 2
            [d, dir_powell]=powell(x, k, dir_powell, tam);
    end
    
    %% Encontra o intervalo de busca de alfa pelo Método do Passo Constante
    [alfa_l,alfa_u, delta]=passoconstante(delta,x_atual,d,r, menu_cr);
    %% Encontra o valor de alfa pelo Método da Seção Áurea
    alfa=secao_aurea(alfa_l,alfa_u,x_atual,d,tol,r, menu_cr);
  
    
    %% Encontra o novo ponto com a direção e alfa definidos anteriormente
    x_post=calc_x_post(alfa,d);
    
    if( k == 1)
        x_1 = x_post;
    end
   
    
    %% Condição de convergência       
    if( norm(x_post - x_atual)/norm( x_1 - x_0) < tol)
        break
    end
   
    x_atual=x_post; %atualiza valor de x
    dir(:,k)=d; %guarda direção
    k=k+1; %incrementa contador de iterações
    x(:,k)=x_post; %guarda ponto
   
end

end


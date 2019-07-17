function  [phi] = phi( d, rest )

    rho=27.143*ones(10,1); %vetor peso específico para cada barra
    l=9.144; %largura da estrutura
    
    %vetor de comprimento para cada barra
    L=[l; l; l; l; l; l; (l)*sqrt(2);(l)*sqrt(2); (l)*sqrt(2); (l)*sqrt(2)];
    %vetor de área transversal para cada barra
    A=(pi/4)*(d).^2;
    f=0;

    %define a função objetivo
    %-- somatório do peso de cada barra
    for i=1:length(d)
        f=f+rho(i)*L(i)*A(i);
    end

    phi = f + rest;
    
end


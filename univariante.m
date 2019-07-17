function [ d, nome ] = univariante( k, tam )

    %% Define a direção para minimização
    row=k-(fix(k/tam))*tam;
   
    % Caso k tenha atingido o valor de tam, a subtração acima sera nula.
    % Entao ajusta o valor de col para tam
    if(row == 0)
        row = tam;
    end
    
    % Retorna a direção canonica
    d = zeros(tam,1);
    d(row,1)=1;
    %disp('direcoes criadas');
    %disp(d);
    nome='Método Univariante';
    
end
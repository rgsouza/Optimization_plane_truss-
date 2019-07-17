function [ d, nome ] = univariante( k, tam )

    %% Define a dire��o para minimiza��o
    row=k-(fix(k/tam))*tam;
   
    % Caso k tenha atingido o valor de tam, a subtra��o acima sera nula.
    % Entao ajusta o valor de col para tam
    if(row == 0)
        row = tam;
    end
    
    % Retorna a dire��o canonica
    d = zeros(tam,1);
    d(row,1)=1;
    %disp('direcoes criadas');
    %disp(d);
    nome='M�todo Univariante';
    
end
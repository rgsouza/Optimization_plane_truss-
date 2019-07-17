function [ d, dir_, nome ] = powell( x, k, dir, tam )
    
    % Fornece o n�mero de ciclos de Powell
    integer_of_division = fix(k/(tam+1));
    
    % Coluna que define a dire��o a ser usada
    col=k-(integer_of_division)*(tam+1);
  
    % Caso col seja zero, ent�o atingiu-se o fim do ciclo de Powell
    if( col == 0 )
        
        if( mod(integer_of_division, (tam +1)) == 0 )
            dir = eye(tam);
            d = zeros(tam,1);
        
        else    
            % Descarta a primeira dire��o
            for n = 1:(tam - 1)
                dir(:, n) = dir(:, n + 1); 
            end
        
            d = x(:,k) - x(:,k - tam);
            dir(:, tam) = d; %adiciona a nova dire��o de busca
        end
        
    else
        d = dir(:, col);
    end
    
    dir_ = dir;

    nome='M�todo de Powell';
    
end


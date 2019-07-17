function [ d, dir_, nome ] = powell( x, k, dir, tam )
    
    % Fornece o número de ciclos de Powell
    integer_of_division = fix(k/(tam+1));
    
    % Coluna que define a direção a ser usada
    col=k-(integer_of_division)*(tam+1);
  
    % Caso col seja zero, então atingiu-se o fim do ciclo de Powell
    if( col == 0 )
        
        if( mod(integer_of_division, (tam +1)) == 0 )
            dir = eye(tam);
            d = zeros(tam,1);
        
        else    
            % Descarta a primeira direção
            for n = 1:(tam - 1)
                dir(:, n) = dir(:, n + 1); 
            end
        
            d = x(:,k) - x(:,k - tam);
            dir(:, tam) = d; %adiciona a nova direção de busca
        end
        
    else
        d = dir(:, col);
    end
    
    dir_ = dir;

    nome='Método de Powell';
    
end


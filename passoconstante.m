function [alfa_l, alfa_u, delta] = passoconstante(delta, x_atual, d, r, menu_cr )
    %% Defini��es auxiliares antes do loop
    calc_x_post=@(alfa) x_atual+alfa.*d; %equa��o de recorr�ncia
    tol = 1e-10;
    %obtem a funcao de restricao
    [frest, c] = rest(x_atual, r, menu_cr);
    f_ant=phi(x_atual, frest); %valor da fun��o no ponto inicial
   
    x_post=calc_x_post(delta); %novo ponto com o primeiro valor de alfa
    [frest, c] = rest(x_post, r, menu_cr); % funcao de restricao
    f_post=phi(x_post, frest); %valor da fun��o no novo ponto
    
    if( (sum(c{1} >= 0) | sum(c{2} >= 0)) & menu_cr == 2 )
        delta = delta/100;
        alfa_l = delta; 
        alfa_u = delta;
        return;
    end

    %% Loop de Minimiza��o
    if(f_ant > f_post)
    %% Caso em que a minimiza��o ocorre com incremento (delta) positivo
        alfa_l=delta; %valor inicial do limite inferior ap�s primeiro alfa
        
        %% Busca intervalo de alfa enquanto a fun��o diminuir de valor
        while(f_ant > f_post)
            x_ant=calc_x_post(alfa_l); %calcula valor do ponto anterior
            [frest, c] = rest(x_ant, r, menu_cr); %calcula a restri��o no ponto anterior
            f_ant=phi(x_ant, frest); %calcula valor da fun��o no ponto anterior
            
            alfa_u=alfa_l+delta; %calcula novo valor de alfa
            
            x_post=calc_x_post(alfa_u); %calcula valor do ponto posterior
            [frest, c] = rest(x_post, r, menu_cr); %calcula a restri��o no novo ponto
            f_post=phi(x_post, frest); %calcula o valor da fun��o no novo ponto
           
            if( (sum(c{1} >= 0) | sum(c{2} >= 0)) & menu_cr == 2)
                delta = delta/100;
                alfa_l = alfa_u;
                return;
            end
            
            %verifica condi��o de parada
            if(f_post>f_ant)
                break;
            else
                alfa_l=alfa_u;
            end
        end

    else
        %% Caso em que a minimiza��o ocorre com incremento (delta) negativo
        %f_post_ant = f_post; % Armazena o f_post para delta
        x_post=calc_x_post(-delta); %novo ponto com primeiro valor de alfa
        [frest, c] = rest(x_post, r, menu_cr); % restri��o no novo ponto
        f_post=phi(x_post, frest);   %valor da fun��o no novo ponto
        
        % avalia se alguma restri��o foi violada para o m�todo barreira
        if( (sum(c{1} >= 0) | sum(c{2} >= 0)) & menu_cr == 2 )
                delta = delta/100;
                alfa_l = delta;
                alfa_u = delta;
                return;
        end
            
        %% Verifica se o comportamento da fun��o e define valores para alfa
        if(f_ant <= f_post) %caso em que a fun��o aumentou de valor        
           alfa_l = 0;
           alfa_u = alfa_l;
        else %caso em que a fun��o diminuiu de valor
            alfa_u=-delta; %valor inicial do limite superior de alfa
        end
               
        while(f_ant > f_post)
            x_ant=calc_x_post(alfa_u); %calcula valor do ponto anterior
            [frest, c] = rest(x_ant, r, menu_cr); % calcula o valor da restri��o do ponto anterior
            f_ant=phi(x_ant, frest); %calcula a fun��o do ponto anterior

            alfa_l=alfa_u-delta; %calcula novo valor de alfa
            
            x_post=calc_x_post(alfa_l); %calcula o novo ponto
            [frest, c] = rest(x_post, r, menu_cr); %calcula a fun��o de restri�ao no novo ponto 
            f_post=phi(x_post, frest); %calcula o valor da fun��o no novo ponto
            
            if( (sum(c{1} >= 0) | sum(c{2} >= 0)) & menu_cr == 2)
                delta = delta/100;
                alfa_u = alfa_l;
                return;
            end
            
            %verifica condi��o de parada
            if(f_post>=f_ant)
                break;
            else
                alfa_u=alfa_l;
            end
        end

    end

end


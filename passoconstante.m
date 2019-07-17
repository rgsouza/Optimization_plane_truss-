function [alfa_l, alfa_u, delta] = passoconstante(delta, x_atual, d, r, menu_cr )
    %% Definições auxiliares antes do loop
    calc_x_post=@(alfa) x_atual+alfa.*d; %equação de recorrência
    tol = 1e-10;
    %obtem a funcao de restricao
    [frest, c] = rest(x_atual, r, menu_cr);
    f_ant=phi(x_atual, frest); %valor da função no ponto inicial
   
    x_post=calc_x_post(delta); %novo ponto com o primeiro valor de alfa
    [frest, c] = rest(x_post, r, menu_cr); % funcao de restricao
    f_post=phi(x_post, frest); %valor da função no novo ponto
    
    if( (sum(c{1} >= 0) | sum(c{2} >= 0)) & menu_cr == 2 )
        delta = delta/100;
        alfa_l = delta; 
        alfa_u = delta;
        return;
    end

    %% Loop de Minimização
    if(f_ant > f_post)
    %% Caso em que a minimização ocorre com incremento (delta) positivo
        alfa_l=delta; %valor inicial do limite inferior após primeiro alfa
        
        %% Busca intervalo de alfa enquanto a função diminuir de valor
        while(f_ant > f_post)
            x_ant=calc_x_post(alfa_l); %calcula valor do ponto anterior
            [frest, c] = rest(x_ant, r, menu_cr); %calcula a restrição no ponto anterior
            f_ant=phi(x_ant, frest); %calcula valor da função no ponto anterior
            
            alfa_u=alfa_l+delta; %calcula novo valor de alfa
            
            x_post=calc_x_post(alfa_u); %calcula valor do ponto posterior
            [frest, c] = rest(x_post, r, menu_cr); %calcula a restrição no novo ponto
            f_post=phi(x_post, frest); %calcula o valor da função no novo ponto
           
            if( (sum(c{1} >= 0) | sum(c{2} >= 0)) & menu_cr == 2)
                delta = delta/100;
                alfa_l = alfa_u;
                return;
            end
            
            %verifica condição de parada
            if(f_post>f_ant)
                break;
            else
                alfa_l=alfa_u;
            end
        end

    else
        %% Caso em que a minimização ocorre com incremento (delta) negativo
        %f_post_ant = f_post; % Armazena o f_post para delta
        x_post=calc_x_post(-delta); %novo ponto com primeiro valor de alfa
        [frest, c] = rest(x_post, r, menu_cr); % restrição no novo ponto
        f_post=phi(x_post, frest);   %valor da função no novo ponto
        
        % avalia se alguma restrição foi violada para o método barreira
        if( (sum(c{1} >= 0) | sum(c{2} >= 0)) & menu_cr == 2 )
                delta = delta/100;
                alfa_l = delta;
                alfa_u = delta;
                return;
        end
            
        %% Verifica se o comportamento da função e define valores para alfa
        if(f_ant <= f_post) %caso em que a função aumentou de valor        
           alfa_l = 0;
           alfa_u = alfa_l;
        else %caso em que a função diminuiu de valor
            alfa_u=-delta; %valor inicial do limite superior de alfa
        end
               
        while(f_ant > f_post)
            x_ant=calc_x_post(alfa_u); %calcula valor do ponto anterior
            [frest, c] = rest(x_ant, r, menu_cr); % calcula o valor da restrição do ponto anterior
            f_ant=phi(x_ant, frest); %calcula a função do ponto anterior

            alfa_l=alfa_u-delta; %calcula novo valor de alfa
            
            x_post=calc_x_post(alfa_l); %calcula o novo ponto
            [frest, c] = rest(x_post, r, menu_cr); %calcula a função de restriçao no novo ponto 
            f_post=phi(x_post, frest); %calcula o valor da função no novo ponto
            
            if( (sum(c{1} >= 0) | sum(c{2} >= 0)) & menu_cr == 2)
                delta = delta/100;
                alfa_u = alfa_l;
                return;
            end
            
            %verifica condição de parada
            if(f_post>=f_ant)
                break;
            else
                alfa_u=alfa_l;
            end
        end

    end

end


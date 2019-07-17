function alfa = secao_aurea(intinf, intsup, x_atual, d, tol, r, menu_cr)
    i=0; %% contador
    calc_x_post=@(alfa) x_atual+alfa*d; %equação de recorrência

    r_aur=(-1+sqrt(5))/2; %define razão áurea
    beta=(intsup-intinf); %define intervalo de busca
    
    intesq=intinf+(1-r_aur)*beta; %calcula subintervalo a esquerda
    intdir=intinf+r_aur*beta; %calcula subintervalo a direita
    
    x_esq=calc_x_post(intesq); %calcula ponto para o limite a esquerda
    x_dir=calc_x_post(intdir); %calcula ponto para o limite a direita
   
    [frest, c] = rest(x_esq, r, menu_cr);
    f_esq=phi(x_esq, frest);
    %f_esq=f(x_esq, r); %calcula valor da função a esquerda
    
    [frest, c] = rest(x_dir, r, menu_cr);
    f_dir=phi(x_dir, frest);
    %f_dir=f(x_dir, r); %calcula valor da função a direita
    
    
    while(abs(intinf-intsup) > tol) %checa convergência
    
        i=i+1; %incrementa contador
    
        % compara os valores e elimina o maior resultado
        if(f_esq >= f_dir)
            intinf=intesq;
            intesq=intdir;
            f_esq=f_dir;
            beta=intsup - intinf;
            intdir=r_aur*beta + intinf;
            x_dir=calc_x_post(intdir);
            
            [frest, c] = rest(x_dir, r, menu_cr);
            f_dir=phi(x_dir, frest);
            
            if( (sum(c{1} >= 0) | sum(c{2} >= 0)) & menu_cr == 2 )
                 alfa=(intsup+intinf)/2;
                 return;
            end
            
        else
            intsup=intdir;
            intdir=intesq;
            f_dir=f_esq;
            beta=intsup - intinf;
            intesq=(1 - r_aur)*beta + intinf;
            x_esq=calc_x_post(intesq);
            
            [frest, c] = rest(x_esq, r, menu_cr);
            f_esq=phi(x_esq, frest);
            
            if( (sum(c{1} >= 0) | sum(c{2} >= 0)) & menu_cr == 2 )
                 alfa=(intsup+intinf)/2;
                 return;
            end
            
        end
    end

    alfa=(intsup+intinf)/2;

end
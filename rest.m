function [rest, c] = rest (d, r, menu_cr)

    E = 6.89476e7; %módulo de elasticidade
    Sesc = 172369; %Tensão de escoamento
    
    %calcula tensão axial nas barras
    [Sfem,Lf]=truss3D_FEM(d,E);
    
    %vetor de área transversal para cada barra
    A=(pi/4)*(d).^2;
    
    %restrições
    %Scr = (pi^2*E*((pi*d.^4)/64))./((Lf.^2).*A);
    Scr = 0;
    for i=1:length(d)
        Scr=Scr + (pi^2*E*((pi*d(i)^4)/64))/((Lf(i)^2)*A(i));
    end

    c{1}=-Sfem./Scr-1;
    c{2}= (abs(Sfem))./Sesc - 1;
    
    rest = 0;
    switch menu_cr
        case 1
            rest=penalidade(c,r);
        case 2
            rest=barreira(c,r);
    end
    
end
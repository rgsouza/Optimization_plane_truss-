function [ tpf ] = barreira( c,r )
tp=0; %inicializa vari�vel para soma das restri��es

%soma restri��es de desigualdade
for j=1:length(c)
    for i=1:length(c{j})
       tp=tp-(1/c{j}(i)); 
    end    
end

%define a fun��o de barreira
tpf=r*tp;

end
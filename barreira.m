function [ tpf ] = barreira( c,r )
tp=0; %inicializa variável para soma das restrições

%soma restrições de desigualdade
for j=1:length(c)
    for i=1:length(c{j})
       tp=tp-(1/c{j}(i)); 
    end    
end

%define a função de barreira
tpf=r*tp;

end
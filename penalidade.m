function [ tpf ] = penalidade( c,r )
tp=0; %inicializa vari�vel para soma das restri��es

for j=1:length(c)
    for i=1:length(c{j})
        if(c{j}(i) > 0)
            tp=tp+(c{j}(i))^2;
        end
    end     
end

%define a fun��o de penalidade
tpf=(r/2)*tp;

end


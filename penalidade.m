function [ tpf ] = penalidade( c,r )
tp=0; %inicializa variável para soma das restrições

for j=1:length(c)
    for i=1:length(c{j})
        if(c{j}(i) > 0)
            tp=tp+(c{j}(i))^2;
        end
    end     
end

%define a função de penalidade
tpf=(r/2)*tp;

end


function [ S, Lf ] = truss3D_FEM( d, E )
% Programa:  Truss3D_FEM
% Calcula uma Treli�a Espacial pelo M�todo dos Elementos 
% Finitos considerando o Comportamento Linear El�stico e
% Regime de Pequenos Deslocamentos. No Final, Calcula as 
% Tens�es Axiais nas Barras.
% Desenvolvido por: Anderson Pereira & Ivan Menezes
%
% DEM / PUC-Rio  
% Fev.2017
% ------------------------------------------------------------------------
format long;

    %% Defini��es para o script de Elementos Finitos 
% Coordenadas Nodais     
NODE = [     0.0,  9.144, 0.0;
           9.144,  9.144, 0.0;
  	      18.288,  9.144, 0.0;
           0.0,    0.0,   0.0;
           9.144,  0.0,   0.0;
          18.288,  0.0,   0.0];
% Conectividade dos Elementos     
ELEM = [ 1,2;
         2,3;
         4,5;
         5,6;
         2,5;
         3,6;
         1,5;
         4,2;
         2,6;
         5,3 ];
% Graus de Liberdade Fixos     
FIX = [ 1 2 3 6 9 10 11 12 15 18 ];

% Obtem o N�mero Total de N�s e de Elementos
Nn = size(NODE,1); Ne = size(ELEM,1);

% Define as Cargas Concentradas (F)
F = zeros(3*Nn,1);
F(14) = -444.822; 
F(17) = -444.822;

% Montagem da Matriz de Rigidez Global
K = zeros(3*Nn,3*Nn); L = zeros(Ne,1);

%vetor de �rea transversal para cada barra
A=(pi/4)*(d).^2;

for i=1:Ne
  ni = ELEM(i,1); nj = ELEM(i,2);
  DOFe = [3*ni-2, 3*ni-1, 3*ni, 3*nj-2, 3*nj-1, 3*nj];
  L(i) = ( (NODE(nj,1)-NODE(ni,1))^2 + ...
           (NODE(nj,2)-NODE(ni,2))^2 + ... 
           (NODE(nj,3)-NODE(ni,3))^2 )^(1/2);
  cx = (NODE(nj,1)-NODE(ni,1))/L(i);
  cy = (NODE(nj,2)-NODE(ni,2))/L(i);
  cz = (NODE(nj,3)-NODE(ni,3))/L(i);
  B = [-cx,-cy,-cz,cx,cy,cz]/L(i);
  K(DOFe,DOFe) = K(DOFe,DOFe) + B'*E*B*A(i)*L(i);
end
FREE = setdiff(1:3*Nn,FIX);
U = zeros(3*Nn,1); 
% Resolve o Sistema de Equa��es
U(FREE) = K(FREE,FREE)\F(FREE);

% C�lculo das Tens�es nas Barras
Lf = zeros(Ne,1); S = zeros(Ne,1);
for i=1:Ne
  ni = ELEM(i,1); nj = ELEM(i,2);
  Lf(i)=(((NODE(nj,1)+U(3*nj-2))-(NODE(ni,1)+U(3*ni-2)) )^2 + ...
         ((NODE(nj,2)+U(3*nj-1))-(NODE(ni,2)+U(3*ni-1)) )^2 + ... 
         ((NODE(nj,3)+U(3*nj))  -(NODE(ni,3)+U(3*ni)) )^2 )^(1/2);
  S(i) = E * ( Lf(i) - L(i) ) / L(i);
end

% Deslocamentos Nodais:
U;

% Tens�es nas Barras:
S;


end


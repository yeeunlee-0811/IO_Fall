clear

%% Setting Parameters _ Table 2

sigma = 5689;
gamma = 9162;
phi = 0.5084;
delta = 0.8475;
sigmar = 1.579;
mu = 4.705;
theta = 0.099;

param = [sigma; gamma; phi; delta; sigmar; mu; theta];

inp.param = param;

%% Renewal fee schedule 

yr = [2:1:20]';
rfee = [12.5:12.5:200]';
rfee = [0;0;0;rfee];

L = size(yr,1);

%% Discretizing the state space of returns

R = 2000;
ssr = [0:20:R]';
m = size(ssr,1);

inp.R = R;
inp.ssr = ssr;
inp.m = m;
inp.rfee = rfee;
inp.yr = yr;
inp.L = L;

%% V L-1 

vL_1 = zeros(m,1);

for i = 1:m
    s = ssr(i,1);
    vL1i = vL1(s,inp);
    vL_1(i,1) = vL1i;
end

plot(ssr,vL_1)

%% V L-(a+1)

S = 100;
inp.S = S;
ta = 18;

vL_a1 = zeros(m,ta);
inp.y = vL_1;

for iy = 1:ta
    a = iy;
    
    for i = 1:m
        s = ssr(i,1);
        vLa1i = vLa1(s,a,inp);
        vL_a1(i,iy) = vLa1i ;
    end
    
    inp.y = vL_a1(:,iy);
end

%% 

valfunction = [vL_1, vL_a1];
plot(ssr,valfunction,'LineWidth',1)
legend('20', '19',    '18',    '17',    '16',    '15',    '14',    '13',    '12',    '11',    '10',     '9',     '8',     '7',     '6',     '5',     '4',     '3',     '2')


%%
rfeemat1 = zeros(L,1);
zerosL = zeros(m,1);

for j = 1:L
    valcol = valfunction(:,j);
    id = valfunction(:,j) == 0;
    id1 = double(id);
    id2 = sum(id1);
    zerosL(id2+1,1) = 1; 
    zerosLL = logical(zerosL);
    rfeemat1(j,1) = ssr(zerosLL);
    zerosL = zeros(m,1);
end

rfeemat1fin = flip(rfeemat1);
%%

rfee2 = [0  0  0  0.781  3.125  7.031  12.5  19.53  28.13  38.28  50  63.28  78.13  94.53  112.5  132  153.1  175.8  200]' ;

inp.rfee = rfee2;
%%

vL_1_2 = zeros(m,1);

for i = 1:m
    s = ssr(i,1);
    vL1i_2 = vL1(s,inp);
    vL_1_2(i,1) = vL1i_2;
end



%%

vL_a1_2 = zeros(m,ta);
inp.y = vL_1_2;

for iy = 1:ta
    a = iy;
    
    for i = 1:m
        s = ssr(i,1);
        vLa1i = vLa1(s,a,inp);
        vL_a1_2(i,iy) = vLa1i ;
    end
    
    inp.y = vL_a1_2(:,iy);
end

%%
valfunction2 = [vL_1_2, vL_a1_2];
plot(ssr,valfunction2,'LineWidth',1)
legend('20','19',    '18',    '17',    '16',    '15',    '14',    '13',    '12',    '11',    '10',     '9',     '8',     '7',     '6',     '5',     '4',     '3',     '2')
%%

rfeemat2 = zeros(L,1);
zerosL = zeros(m,1);

for j = 1:L
    valcol = valfunction2(:,j);
    id = valfunction2(:,j) == 0;
    id1 = double(id);
    id2 = sum(id1);
    zerosL(id2+1,1) = 1; 
    zerosLL = logical(zerosL);
    rfeemat2(j,1) = ssr(zerosLL);
    zerosL = zeros(m,1);
end

rfeemat2fin = flip(rfeemat2);


%%


valfunction3 = [vL_1_2(:,1), vL_a1_2(:,1)];
plot(ssr,valfunction3,'LineWidth',1)




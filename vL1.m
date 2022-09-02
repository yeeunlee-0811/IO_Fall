% Given parameters, first solve the dynamic problem, get rbar for each year

function vL_1 = vL1(s,inp)

param = inp.param;

sigma = param(1,1);
gamma = param(2,1);
phi = param(3,1);
delta = param(4,1);
sigmar = param(5,1);
mu = param(6,1);
theta = param(7,1);

rfee = inp.rfee;
m = inp.m;
R = inp.R;

% 
vL = 0;

% L-1 period - possilbe case = the number of grid (=m)

vL_1 = max(0,s+vL-rfee(end,1));
end





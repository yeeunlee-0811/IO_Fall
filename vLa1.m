function vL_a1 = vLa1(s,a,inp)


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
S = inp.S;
L = inp.L;

ca1 = rfee(end-(a),1);


% L-1 period - possilbe case = the number of grid (=m)
% Need to do the integrate out
% Vl-2 = max(0,rl-cl+Er_(l-1)|r_(l-2)[V_(l-1)])
% Expectation part:
% integral V(rl-1,z|rl-2)dF(rl-1,z|rl-2)
% f(rl-1,z|rl-2) = f(rl-1|z,rl-2)g(z|rl-2)
% integral V(rl-1,z|rl-2)f(rl-1|z,rl-2)g(z|rl-2)
% S draws from g(z|rl-2) and do the integration out  --> Whole integration
% part is solved : (1/S)*sum(V(rl-1,z|rl-2)f(rl-1|z,rl-2))
% z = x-gamma where x follows exponential distn(mu = 1/sigmaa)

sigmaa = phi^(L-(a+1)-1)*sigma;

mu = 1/sigmaa;

xdraws = exprnd(mu,S,1);
zdraws = xdraws - gamma*ones(S,1);

maxsz0 = zeros(S,2);
maxsz0(:,1) = zdraws;
maxsz0(:,2) = delta*s;

maxsz = max(maxsz0,[],2);

ssr = inp.ssr;
y = inp.y;


Va0 = interp1(ssr,y,0);

Vamaxsz = zeros(S,1);
for i = 1:S
    sz = maxsz(i,1);
    vamaxsz = interp1(ssr,y,sz);
    Vamaxsz(i,1) = vamaxsz ;
end


Era = exp(-theta*s)*Va0+(1/S)*sum(Vamaxsz);

vL_a1 = max(0,s-ca1+Era);
end
function [ u ] = D( f, p, N, k )
%D Calculate the preview term.
%  Do not use this directly, run ZMPIPController2012 instead.
u = 0;
for j=1:N,
    u = u + f(j) * p(k+j);
end
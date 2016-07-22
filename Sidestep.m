function [ Ge ] = Sidestep( s, struct )
%SIDESTEP Calculates gains the perform sidesteps.
%  Do not run this directly, use writeParam2012 instead.

   Ge = (struct.c0 *struct.b0 * sum(struct.Gd(s:struct.N)))^-1 ...
        * struct.c0 * (struct.A0 + eye(3) ...
        -struct.b0 * struct.Gi * struct.c0 ...
        -struct.b0 * struct.Gx);
end


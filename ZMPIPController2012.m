function [ out ] = ZMPIPController2012(pRef, i, ZMP_err, CoM_err, s, p, ...
                                       params, pRefModifier)
%ZMPIPController2012 Executes the controller/observer.
%[ out ] = ZMPIPController2012(pRef, i, ZMP_err, CoM_err, s, p, params, pRefModifier)
%   executes a loop until i of the controller/observer. The desired ZMP
%   is given by pRef, errors of CoM and ZMP by CoM_err and ZMP_err
%   respectively and must have the same length as pRef.
%   The frame numbers for sidesteps are defined in s. It
%   is a vector of dimension n. The planned sidesteps can be weighted by p
%   while p has the dimension n-1. The parameters of the robot are given by
%   params. The function calculating the gain matrix Ge is given by
%   pRefModifier.
%
%   Example usage:
%
%   load('zmp.mat');
%   com_err(177:177)=0.01;
%   zmp_err(177)=-0.05;
%   out = ZMPIPController2012(zmp_ref, 400, zmp_err, com_err, ...
%                             [190,200], [0.2], Nao2012(''), @Sidestep);
%   t = 100:300;
%   plot(t, out.pRef(t), t, out.obs(t,1), t, out.obs(t,3));

obs=[0;0;0];
v=0;
struct=writeParam2012(params, pRefModifier);
out.struct=struct;
offset = 0;
zmperr = 0;
out.mod = zeros(i);
    
for k=1:i,
    out.obs(k, :)=obs(:);
    out.v(k)=v;
    
    Ym(1,k)=CoM_err(k)+obs(1);
    Ym(2,k)=ZMP_err(k)+obs(3);

    % error for calculating sidestepp
    err = struct.L * (Ym(:,k)-[obs(1);obs(3)]);

    d = D(struct.Gd, pRef, struct.N, k);   
    cont =  (-struct.Gi * v - struct.Gx * obs - d);
    obs = struct.A0 * obs + err + struct.b0 * cont;
    v = v + struct.c0 * obs - pRef(k+1);  
   
    balanced = 0;
    for si = 1:size(s,2);
        if (s(si)-k < 100 && s(si)-k > 3)
            if (si == size(s,2))
                p(si) = 1 - balanced;
            end;
            pRef(s(si):s(si)+struct.N) = ...
                pRef(s(si):s(si)+struct.N) + ...
                struct.Ge(s(si)-k-1,1:3) * p(si) * err;
            balanced = balanced + p(si);
            out.mod(s(si)) = out.mod(s(si))+ struct.Ge(s(si)-k-1,1:3) * p(si) * err;
        end;
    end;
end
out.pRef = pRef;



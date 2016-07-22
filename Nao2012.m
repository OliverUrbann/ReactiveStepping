function [ params ] = Nao2012(name)
% Nao2012: Hand optimized gains to calculate the controller gains.
%          Do not run directly. Use writeParam2012 instead.

% Controller parameters
params.g = 9.8;         % Gravity
params.z_h = 0.26;      % Height of CoM     
params.dt = 0.01;		% Length of a frame
params.R = 1*10^-10;    % Controller-Parameter R [1]
params.N = 100;         % Duration of the preview phase
params.Qx = 10^-10;     % Controller-Parameter Qx [1]
params.Qe = 10;         % Controller-Parameter Qe [1]


params.Ql = [ 1, 0, 0 ; % Gain for calculating L [1]
              0, 1, 0 ;
              0, 0, 1 ];
         
params.RO = [1,  0;     % Gain for calculating L [1]
             0,  1]; 

if isempty(name)
    params.path='';
else
    params.path=['../../Config/Robots/', name, '/ZMPIPController2012.dat'];
end

%[1] Czarnetzki, S., Kerner, S., Urbann, O.: Observer-based dynamic walking
%    control for biped robots. Robotics and Autonomous Systems 57 (2009) 
%    839-845

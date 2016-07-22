function [  ] = run(  )
%RUN Executes the controller with some example disturbances to compare
%    the closed-loop case without sidestep with the close-loop case
%    with sidesteps.

figure('Position',[0 0 400 500]);
scale=[150/100,250/100,-0.17,0.1];
load('zmp.mat');
com_err(170)=-0.005;
com_err(200)=0.003;
com_err(205)=-0.003;
out = ZMPIPController2012(zmp_ref, 400, zmp_err, com_err, [195,230],[0.8], Nao2012(''), @NoModifier);
t = 100:250;
subplot(2,1,1);
h=plot(t/100, out.pRef(t), t/100, out.obs(t,1), t/100, out.obs(t,3));
set(h(1),'LineWidth',2);
set(h(2),'LineWidth',2);
set(h(3),'LineWidth',1);
set(h(1),'LineStyle','--');
axis(scale);
legend('Location', 'SouthEast', 'Reference', 'CoM', 'ZMP');
xlabel('Time [s]');
ylabel('Position y [m]');

out = ZMPIPController2012(zmp_ref, 400, zmp_err, com_err, [195,230],[0.8], Nao2012(''), @Sidestep);
t = 100:250;
subplot(2,1,2);
h=plot(t/100, out.pRef(t), t/100, out.obs(t,1), t/100, out.obs(t,3));
set(h(1),'LineWidth',2);
set(h(2),'LineWidth',2);
set(h(3),'LineWidth',1);
set(h(1),'LineStyle','--');
axis(scale)
legend('Location', 'SouthWest', 'Reference', 'CoM', 'ZMP');
xlabel('Time [s]');
ylabel('Position y [m]');

end


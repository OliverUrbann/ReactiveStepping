function [  ] = run(  )
%RUN Executes the controller with some example disturbances to compare
%    the closed-loop case without sidestep with the close-loop case
%    with sidesteps.

load('zmp.mat');

figure('Position',[0 0 400 200]);
scale=[150/100,250/100,-0.17,0.1];
load('zmp.mat');
noerr = ZMPIPController2012(zmp_ref, 400, zmp_err, com_err, [230],[], Nao2012(''), @NoModifier);
com_err(170)=-0.005;
com_err(200)=0.003;
com_err(205)=-0.003;
out = ZMPIPController2012(zmp_ref, 400, zmp_err, com_err, [230],[], Nao2012(''), @NoModifier);
t = 100:250;

h=plot(t/100, out.pRef(t), t/100, out.obs(t,1), t/100, out.obs(t,3));
set(h(1),'LineWidth',2);
set(h(2),'LineWidth',2);
set(h(3),'LineWidth',1);
set(h(1),'LineStyle','--');
axis(scale);
lh=legend('Location', 'SouthEast', '$p^{ref}$', '$\hat{\textbf{c}}_x$', '$p$');
set(lh,'Interpreter','latex')
xlabel('Time [s]');
ylabel('Position y [m]');

figure('Position',[0 0 400 200]);

out2 = ZMPIPController2012(zmp_ref, 400, zmp_err, com_err, [195,230],[1], Nao2012(''), @Lunge);
t = 100:250;
h=plot(t/100, out2.pRef(t), t/100, out2.obs(t,1), t/100, out2.obs(t,3));
set(h(1),'LineWidth',2);
set(h(2),'LineWidth',2);
set(h(3),'LineWidth',1);
set(h(1),'LineStyle','--');
axis(scale)
lh=legend('Location', 'SouthWest',  '$p^{ref}$', '$\hat{\textbf{c}}_x$', '$\hat{p}$');
set(lh,'Interpreter','latex')
xlabel('Time [s]');
ylabel('Position y [m]');

end


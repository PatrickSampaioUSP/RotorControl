function [t,y]=hrkdif(y,dt,t,nsis)
global i_error
global error

%% Primeira Parte Range Kutta
newdt=1;
[dy,y]=eqsim(y,t,newdt);
h=dt/2;
sy = y(1:nsis);
y0 = dy(1:nsis);
sy_error = i_error;
error0 = error;
y(1:nsis) = h*dy' + sy;
i_error = h*error0 + sy_error;
t=t+h;

%% Range Kutta Segunda parte
newdt=0;
[dy,y]=eqsim(y,t,newdt);
y1(1:nsis) = dy(1:nsis);
y(1:nsis) = sy(1:nsis) + h*dy(1:nsis)';
error_1 = error;
i_error = h*error+ sy_error;

%% Range Kutta Terceira parte
[dy,y]=eqsim(y,t,newdt);
y2(1:nsis) = dy(1:nsis);
y(1:nsis) = sy(1:nsis) + dt*dy(1:nsis)';
error_2 = error;
i_error = dt*error + sy_error;
t=t+h;

%% Range Kutta Quarta parte
[dy,y]=eqsim(y,t,newdt);
h=h/3;
prt1 = 2*(y1(1:nsis)+y2(1:nsis));
prt2 = y0(1:nsis) + dy(1:nsis);
y(1:nsis) = sy(1:nsis) + h*prt1 + h*prt2';

e_prt1 = 2*(error_1 + error_2);
e_prt2 = error0 + error;
i_error = sy_error + h*e_prt1(1) + h*e_prt2(1);
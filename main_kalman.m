%clear all
close all

%IMPLEMENTACAO DO NOVO MODELO
% Q: Matriz Q deve ser adaptada

global g0 A B C D Ad Bd Cd Dd xk uk Pk Q GQ R H I ntamos tamos ct xest dt t  Gama Gamad Gamad0 r0 k l m g T F T0 
global derivative g_two i_error counter u control_dt control_time u_ref u_0
    
tf_l=30;            %tempo final da simulação
dt=.1;              %intervalo de integração   
control_dt=.2;      %intervalo de controle
control_time=2;     %tempo da ultima execucao do controle
u_ref = pi/2;       %Posição angular de referencia
nsis=2;             %n de dy em equisim
naux=2;             %n de  y em equisim
t=0;
nf=tf_l/dt;
counter = 0;
u = 0;

m = 2;                %%%%%%%%%% MASSA KG
M = 20;               %%%%%%%%%% MASSA KG
g = 10;               %%%%%%%%%% CTE DA GRAVIDADE
R = 0.4;              %%%%%%%%%%
l = 0.4;              %%%%%%%%%% COMRPIMENTO BARRA (M)
T0 = 10;              %%%%%%%%%% FORÇA ROTOR (N)
k = 0.1;              %%%%%%%%%% CTE REATIVA ROTOR(N)
q = 1;                %%%%%%%%%%
derivative = 0;
i_error = 0;

%u_func=@(t) sin(2*pi/10*t)+ 1*sin(2*pi/5*t);
%u=sin(2*pi/50*t)+ 1*sin(2*pi/25*t);
T = @(x) T0 - k*x;
F = @(x) -q*x;

ntamos=1; %
tamos=.1; %intervalo de aquisição dos sinais
ii=0;
ct=0;
ctmax=10;

alpha_3 = ((4*m*l^2)/3 + M*R^2);
alpha_2 = 1;
alpha_1 = 3*l*m*g/2;
g_two = tf([1], [alpha_3 alpha_2 -alpha_1]);

% aplica-se a linearização em torno de u_ref
A=[0 1; alpha_1*(cos(u_ref))/alpha_3 -alpha_2/alpha_3];
B=[0;1/alpha_3];

u_0 = alpha_1*(sin(u_ref));

%A = [A 0; 0 0 1];
%B = [B 0];

C=[1 0];
D=0;
Gama= [0;1];

%C = [C 0];
%Gama = [Gama 0];

g0=10; %variancia do ruído do processo
r0=.04; %variância do ruído de medida

%obtençao dos valores para o modelo discretizado
% Kalman Filter
Ak= [A zeros(2,2); zeros(2,2) A];
Bk= [B ; zeros(2,1)];
Ck = [C zeros(1,2)];
Dk=[0];
[Ad,Bd,Cd,Dd]=c2dm(Ak,Bk,Ck,Dk,control_dt);
%Ad = Ak;
%Bd = Bk;
%Cd = Ck;
%Dd = Dk;
%H=Cd;
H=[1 0 0 1];
%H=[1 0 0 0];
Gamak= [0 0 ;1 0; 0 0; 0 1];
[Ad,Gamad0]=c2d(Ak,Gamak,control_dt);
%Ad = Ak;
%Gamad0 = Gamak;

Pk=10000*eye(4);
Q=[0 0 0 0; 0 5 0 0; 0 0 0 0; 0 0 0 32];
R=g0*eye(1);
%Gamad=[zeros(4,2) Gamad0];
Gamad=[0 Gamad0(1,1) zeros(1,2); 0 Gamad0(2,1) zeros(1,2); zeros(1,3) Gamad0(3,2); zeros(1,3) Gamad0(4,2)];  
GQ=Gamad*Q*Gamad';
I=eye(4);

y(1)=pi/2; %condições iniciais
y(2)=0; %condições iniciais
y(3)=0; %condições iniciais
y(4)=0;


xest(1,1:4)=0;
xk(1,1:4)=0;
xk(2,1:4)=0;
xk=xk';
uk=0; 

for i=1:nf
    ii=i;
    [t,y]=hrkdif(y,dt,t,nsis);
   for i1=1:nsis+naux
      ys(i,i1)=y(i1);
   end
   ts(i)=t;
end
 
kalman_plot






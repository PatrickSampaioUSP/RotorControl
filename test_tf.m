m = 2;                %%%%%%%%%% MASSA KG
M = 20;               %%%%%%%%%% MASSA KG
g = 10;               %%%%%%%%%% CTE DA GRAVIDADE
R = 0.4;              %%%%%%%%%%
l = 0.4;              %%%%%%%%%% COMRPIMENTO BARRA (M)
T0 = 10;              %%%%%%%%%% FORÇA ROTOR (N)
k = 0.1;              %%%%%%%%%% CTE REATIVA ROTOR(N)
q = 1;                %%%%%%%%%%
derivative = 0;

alpha_3 = ((4*m*l^2)/3 + M*R^2);
alpha_2 = 1;
alpha_1 = 3*l*m*g/2;

kp = 13.574;
td = 0.4519;
g_one = tf([td 1], [1]);
g_two = tf([1], [alpha_3 alpha_2 -alpha_1]);
g_r = tf(g_two*g_one);

rlocus(g_r)
[K,POLES] = rlocfind(g_r);
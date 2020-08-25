function [u]=u_func(y)

global l m g T0 T F k

if y(2) <= T0/k
    torque = T(y(2));
else
    torque = 0;
end

u = (3/2)*l*m*g*sin(y(1)) + torque + F(y(2));

end
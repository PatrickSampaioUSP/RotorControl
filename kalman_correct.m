
function [Pk,Kk,xk]=kalman_correct_helio(Pkm,H,R,Q,xkm,I,zk)

Kk=Pkm*H'*inv(H*Pkm*H'+R);
xk=xkm+Kk*(zk-H*xkm);
Pk=(I-Kk*H)*Pkm;

 
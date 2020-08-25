function [xkm,Pkm]=kalman_predict(A,B,Pk,GQ,xk,uk)

xkm=A*xk+B*uk;
%Pkm=Ae*Pk*Ae' + W*Q*W';
Pkm=A*Pk*A' + GQ;
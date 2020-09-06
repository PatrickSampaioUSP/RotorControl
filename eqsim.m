function [dy,y]=eqsim(y,t,newdt)
global g0 A B C Ad Bd xk uk Pk Q GQ R H I ntamos xest t  r0 
global derivative g_two error
global u control_dt control_time u_ref u_0 error_list

kp = 22.367279999999997;
td = 0.47786767099084015;
ti = 8.914619681665144;

g_one = tf([td 1]);
g_r = tf(g_two*g_one);

w=sqrt(g0)*randn(1,1);
r=sqrt(r0)*randn(1,1);

error = u_ref - y(1);
disp(error)

if control_time < t
   error_list = [error_list, error];
   pos = length(error_list);
   current_error = error_list(pos);
   derivative_error = (error_list(pos)-error_list(pos-1))/control_dt;
   
   integral_term = 0;
   for i = 1:pos
       integral_term = integral_term + error_list(i);
   end
   integral_term = integral_term*control_dt;
   
   u = kp*(current_error + td*derivative_error + (1/ti)*integral_term) + u_0; 
   if u > 20
    u = 20;
    end
    if u < -20
        u = -20;
    end
    control_time = control_time + control_dt;
end
    
dy=A*[sin(y(1)) y(2)]'+B*u;
derivative = -dy(1);

z=C*y(1:2)';
y(3)=z;
y(4)=u;

if(newdt==1)
    
        zk=z;
        uk=u;

         %xk=y(1:2)';
        if ntamos==1 
            xk=xest(ntamos,1:4)';
        else
            xk=xest(ntamos-1,1:4)';
        end
        [xkm,Pkm]=kalman_predict(Ad,Bd,Pk,GQ,xk,uk);
        [Pk,Kk,xk]=kalman_correct(Pkm,H,R,Q,xkm,I,zk);
        xest(ntamos,:)=xk';
        ntamos=ntamos+1;
    
end    

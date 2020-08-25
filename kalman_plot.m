

figure(1)
plot(ts(1:ctmax:nf-1),ys(1:ctmax:nf-1,3), 'LineWidth',2.0)
xlabel('tempo')
ylabel('posição angular medida')
legend('posição angular medida')
title('posição angular')

figure(2)
plot(ts(1:ctmax:nf-1),ys(1:ctmax:nf-1,2), 'LineWidth',2.0)
xlabel('tempo')
ylabel('velocidade angular real')
legend('velocidade angular real')
title('velocidade angular')

figure(3)
plot(ts(1:ctmax:nf-1),ys(1:ctmax:nf-1,4), 'LineWidth',2.0)
xlabel('tempo')
ylabel('u')
title('lei de controle')

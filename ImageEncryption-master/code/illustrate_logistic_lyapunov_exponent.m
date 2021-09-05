function illustrate_logistic_lyapunov_exponent()
clear all;
hold on
alpha0=3:0.001:4;
N=1000;
for j=1:length(alpha0)
    alpha=alpha0(j);
    x0=0.1;%初始值
    s=0;
    for ii=1:N
        df=alpha-2*alpha*x0;
        s=s+log(abs(df));%lambda叠加
        x0=alpha*x0*(1-x0);%x迭代
    end
    Lm(j)=s/N;% 指数
end
plot(alpha0,Lm, 'black')
title('lyapunov exponent of logistic mapping')
end
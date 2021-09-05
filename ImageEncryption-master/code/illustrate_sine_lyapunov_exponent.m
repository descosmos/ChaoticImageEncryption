function illustrate_sine_lyapunov_exponent()
    function newx=sine_f(x)
    newx(1,1)=x(2)*sin(pi*x(1))/4;
    newx(2,1)=x(2);
    end

%run sine
d0=1e-8;
Z=[]; 
r=rand();
for u=linspace(0,4,500)
    le=0;
    lsum=0;
    x=[r;u];
    x1=[r+d0;u];
    for k=1:800
        x=sine_f(x);
        x1=sine_f(x1);
        d1=sqrt((x(1)-x1(1))^2);%1·¶Êý
        x1=x+(d0/d1)*(x1-x);
        if k>100
            lsum=lsum+log(d1/d0);
        end
    end
    le=lsum/(k-100);
    Z=[Z,u+le*1i]; 
end
plot(Z,'-') 
xlabel('k','fontsize',16,'FontAngle','italic');
ylabel('Lyapunov exponent','fontsize',16,'FontAngle','italic');
grid on;

end
function c=encrypt_rgb_image(x,m,n)
%{
    encrypt_rgb_image(): Encrypt a rgb coding image with key, obtaing an encrypted
    iamge.
%}

%x表示函数初值
%m,n分别表示矩阵的长与宽
r=zeros(m,n);
r(1)=x+0.000000001;
for i=2:m*n
    r(i)=1-2*r(i-1)*r(i-1);
end
for i=1:n*m
    r(i)=mod(round(r(i)*98273917129),256);
end

g=zeros(m,n);
g(1)=x;
for i=2:m*n
    g(i)=1-2*g(i-1)*g(i-1);
end
for i=1:n*m
    g(i)=mod(round(g(i)*98273917129),256);
end
b=zeros(m,n);
b(1)=x-0.000000001;
for i=2:m*n
    b(i)=1-2*b(i-1)*b(i-1);
end
for i=1:n*m
    b(i)=mod(round(b(i)*98273917129),256);
end
c=zeros(m,n,3);
c=cat(3,r,g,b);
c=uint8(c);
imshow(uint8(c));
end

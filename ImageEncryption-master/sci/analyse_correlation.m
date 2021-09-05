function r = analyse_correlation(img, n)
%{
    ===============================================
                    analyse_correlation
    ===============================================
    Definition:
    Any natural and plain image has strongly correlated pixels. Actually,
    this strong correlation among the pixels causes the image to have a
    sense. Any two neighboring pixels are called adjacent pixels. These two
    neighboring pixels may be oriented in horizontal, vertical or diagonal
    directions. No doubt, the main duty of any image cipher is to dismantle
    this strong correlation due to which the image becomes totally blurred
    and noisy. In an ideal ciphered image, the correlation becomes zero
    which usually does not happen.
    
    Application:
    The function analyse_correlation is used to detect the correlation of
    one image, and show that.
%}

    img = double(img);
    [M,N] = size(img);
    r = zeros(1, 3);
    
    x1 = mod(floor(rand(1,n)*10^10),M-1)+1;
    x2=mod(floor(rand(1,n)*10^10),M)+1;
    x3=mod(floor(rand(1,n)*10^10),M-1)+2;
    y1=mod(floor(rand(1,n)*10^10),N-1)+1;
    y2=mod(floor(rand(1,n)*10^10),N)+1;
    u1=zeros(1,n);u2=zeros(1,n);u3=zeros(1,n);u4=zeros(1,n);
    v1=zeros(1,n);v2=zeros(1,n);v3=zeros(1,n);v4=zeros(1,n);
    
    for i=1:n
    u1(i)=img(x1(i),y2(i));v1(i)=img(x1(i)+1,y2(i));
    u2(i)=img(x2(i),y1(i));v2(i)=img(x2(i),y1(i)+1);
    u3(i)=img(x1(i),y1(i));v3(i)=img(x1(i)+1,y1(i)+1);
    end
    
    r(1)=mean((u1-mean(u1)).*(v1-mean(v1)))/(std(u1,1)*std(v1,1));
    r(2)=mean((u2-mean(u2)).*(v2-mean(v2)))/(std(u2,1)*std(v2,1));
    r(3)=mean((u3-mean(u3)).*(v3-mean(v3)))/(std(u3,1)*std(v3,1));
    
    figure(101);
    plot(u1,v1,'b.','linewidth',3,'markersize',3);
    axis([0 300 0 300]);
    set(gca,'XTick',0:50:300,'YTick',0:50:300,'fontsize',12,'fontname','times new roman');
    set(gca,'XTickLabel',{'0','50','100','150','200','250','300'});
    set(gca,'YTickLabel',{'0','50','100','150','200','250','300'});
    %saveas(gcf, 'correlation_h.jpg')
    %xlabel('Pixel gray value on location(\itx\rm,\ity\rm)');
    %ylabel('Pixel gray value on location(\itx\rm+1,\ity\rm)');
    
    figure(102);
    plot(u2,v2,'b.','linewidth',3,'markersize',3);
    axis([0 300 0 300]);
    set(gca,'XTick',0:50:300,'YTick',0:50:300,'fontsize',12,'fontname','times new roman');
    set(gca,'XTickLabel',{'0','50','100','150','200','250','300'});
    set(gca,'YTickLabel',{'0','50','100','150','200','250','300'});
    %saveas(gcf, 'correlation_v.jpg')
    %xlabel('Pixel gray value on location(\itx\rm,\ity\rm)');
    %ylabel('Pixel gray value on location(\itx\rm,\ity\rm+1)');
    
    figure(103);
    plot(u3,v3,'b.','linewidth',3,'markersize',3);
    axis([0 300 0 300]);
    set(gca,'XTick',0:50:300,'YTick',0:50:300,'fontsize',12,'fontname','times new roman');
    set(gca,'XTickLabel',{'0','50','100','150','200','250','300'});
    set(gca,'YTickLabel',{'0','50','100','150','200','250','300'});
    %saveas(gcf, 'correlation_d.jpg')
    %xlabel('Pixel gray value on location(\itx\rm,\ity\rm)');
    %ylabel('Pixel gray value on location(\itx\rm+1,\ity\rm+1)');
end
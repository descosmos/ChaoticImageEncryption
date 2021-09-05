function bar_statis = generate_statistic_bar(img)
[m,n] = size(img);
bar_statis = zeros(0,256);
for i=1:256
    bar_statis(i) = length(find(img==(i-1)));
    %bar_statis(i) = mod(length(find(img==(i-1))), 30);
end
end
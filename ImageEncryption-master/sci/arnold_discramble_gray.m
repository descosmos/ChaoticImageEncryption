function img = arnold_discramble_gray(scrambled_img)

    a = 3; b = 5;
    counts = 10;
    [rows,columns] = size(scrambled_img);
    N = columns;
    img = zeros(rows, columns);
    
    for n = 1: counts
        for y = 1: rows
            for x = 1: columns
                pre_x = mod((a*b+1)*(x-1)-b*(y-1), N) + 1;
                pre_y = mod(-a*(x-1)+(y-1), N) + 1;
                img(pre_y, pre_x) = scrambled_img(y,x);
            end
        end
        scrambled_img = img;
    end

end
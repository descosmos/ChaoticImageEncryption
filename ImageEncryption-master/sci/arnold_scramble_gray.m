function img_scrambled = arnold_scramble_gray(img)
    img = rgb2gray(img);
    [rows,columns] = size(img);
    N = columns;
    a = 3; b = 5;
    counts = 10;

    img_scrambled = zeros(rows, columns);
    for n = 1: counts
        for y = 1:rows
            for x = 1:columns
                pre_x = mod((x-1)+b*(y-1), N) + 1;
                pre_y = mod((a*(x-1)+(a*b+1)*(y-1)), N) + 1;
                img_scrambled(pre_y, pre_x) = img(y,x);
            end
        end
        img = img_scrambled;
    end

end
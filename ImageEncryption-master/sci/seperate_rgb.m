function [red, green, blue] = seperate_rgb(img)
    [M,N,dimension] = size(img);
    red = uint8(zeros(M,N));
    green = uint8(zeros(M,N));
    blue = uint8(zeros(M,N));

    for i = 1: M
        for j = 1: N
            red(i,j) = img(i,j,1);
            green(i,j) = img(i,j,2);
            blue(i,j) = img(i,j,3);
        end
    end
end
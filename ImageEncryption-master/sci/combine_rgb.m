function img = combine_rgb(red, green, blue)
    [M, N] = size(red);
    img = uint8(zeros(M,N,3));

    for i = 1: M
        for j = 1: N
            img(i,j,1) = red(i,j);
            img(i,j,2) = green(i,j);
            img(i,j,3) = blue(i,j);
        end
    end

end
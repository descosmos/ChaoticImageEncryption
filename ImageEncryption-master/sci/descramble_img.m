function descrambled_img = descramble_img(scrambled_img, key_stream_scrambling)
    [M,N,dimension] = size(scrambled_img);
    n = M*N;
    descrambled_img = scrambled_img;
    
    red_stream_scrambling = mod(floor(key_stream_scrambling(1:n)), n)+1;
    green_stream_scrambling = mod(floor(key_stream_scrambling(n+1:2*n)), n)+1;
    blue_stream_scrambling = mod(floor(key_stream_scrambling(2*n+1:3*n)), n)+1;
    
    red_img = descrambled_img(:,:,1);
    green_img = descrambled_img(:,:,2);
    blue_img = descrambled_img(:,:,3);
    
    for i = n:-1:1
        t = red_img(i);
        red_img(i) = red_img(red_stream_scrambling(i));
        red_img(red_stream_scrambling(i)) = t;
        
        t = green_img(i);
        green_img(i) = green_img(green_stream_scrambling(i));
        green_img(green_stream_scrambling(i)) = t;
        
        t = blue_img(i);
        blue_img(i) = blue_img(blue_stream_scrambling(i));
        blue_img(blue_stream_scrambling(i)) = t;
    end
    
    descrambled_img(:,:,1) = red_img;
    descrambled_img(:,:,2) = green_img;
    descrambled_img(:,:,3) = blue_img;
end
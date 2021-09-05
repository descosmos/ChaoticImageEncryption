 function scrambled_img = scramble_img(original_img, key_stream_scrambling)
    [M,N,dimension] = size(original_img);
    n = M*N;
    scrambled_img = original_img;
    
    red_stream_scrambling = mod(floor(key_stream_scrambling(1:n)), n)+1;
    green_stream_scrambling = mod(floor(key_stream_scrambling(n+1:2*n)), n)+1;
    blue_stream_scrambling = mod(floor(key_stream_scrambling(2*n+1:3*n)), n)+1;
    
    red_img = original_img(:,:,1);
    green_img = original_img(:,:,2);
    blue_img = original_img(:,:,3);
    
    for i=1:M*N
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
    
    scrambled_img(:,:,1) = red_img;
    scrambled_img(:,:,2) = green_img;
    scrambled_img(:,:,3) = blue_img;
    
end
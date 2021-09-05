function diffused_img = diffuse_img(original_img ,key_stream_diffusion)
    [M, N, dimension] = size(original_img);
    n = M*N;

    diffused_img = uint8(original_img); diffused_img = diffused_img.*0;
    
    red_stream_diffusion = uint8(mod(key_stream_diffusion(1: n), 255)+1);
    green_stream_diffusion = uint8(mod(key_stream_diffusion(n+1: 2*n),255)+1);
    blue_stream_diffusion = uint8(mod(key_stream_diffusion(2*n+1: 3*n),255)+1);
    
    red_image = original_img(:,:,1);
    green_image = original_img(:,:,2);
    blue_image = original_img(:,:,3);
    
    for i = 1: n
        red_image(i) = bitxor(red_image(i), red_stream_diffusion(i));
        green_image(i) = bitxor(green_image(i), green_stream_diffusion(i));
        blue_image(i) = bitxor(blue_image(i), blue_stream_diffusion(i));
    end
    
    diffused_img(:,:,1) = red_image;
    diffused_img(:,:,2) = green_image;
    diffused_img(:,:,3) = blue_image;
end
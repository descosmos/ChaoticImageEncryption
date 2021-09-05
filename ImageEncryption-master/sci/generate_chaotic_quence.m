function [key_stream_diffusion,key_stream_scrambling] = generate_chaotic_quence(img)
    function [key_stream_diffusion,key_stream_scrambling] = generate_sixD_quence(img)
        a = 10; b = 8/3; c = 28; d = 2; h = 8.8; k1 = 1; k2 = 0.9;
        x10 = 4; x20 = 4; x30 = 3; x40 = 4; x50 = 5; x60 = -2;
        threshold = 700;
        disturbance = 0.02;
        primer_number = 982451653;
        
        [M, N, dimension] = size(img);
        n = M*N;
        
        key_stream_scrambling = zeros(1, 3*n);
        red_stream_scrambling = zeros(1, n);
        green_stream_scrambling = zeros(1, n);
        blue_stream_scrambling = zeros(1, n);
        
        key_stream_diffusion = zeros(1, 3*n);
        red_stream_diffusion = zeros(1, n);
        green_stream_diffusion = zeros(1, n);
        blue_stream_diffusion = zeros(1, n);
        
        for i =1: n+threshold
            x1 = a * (x20 - x10) + x40;
            x2 = c*x10 - x10*x30 + x50 - x20;
            x3 = x10*x20 - b*x30;
            x4 = d*x40 - x10*x30;
            x5 = -h*x20 + x60;
            x6 = -k1*x1 + k2*x2;
    
            x10 = x1; x20 = x2; x30 = x3; x40 = x4; x50 = x5; x60 = x6;
            
            if i > threshold
                if mod((i-threshold), 3541) ==0
                    x10 = x10 + disturbance*sin(x10);
                end
            end
            
            x10 = mod(x10, primer_number); x20 = mod(x20, primer_number); x30 = mod(x30, primer_number);
            x40 = mod(x40, primer_number); x50 = mod(x50, primer_number); x60 = mod(x60, primer_number);
            
            red_stream_diffusion(mod(i, n)+1) = x1;
            green_stream_diffusion(mod(i, n)+1) = x2;
            blue_stream_diffusion(mod(i, n)+1) = x3;
            
            red_stream_scrambling(mod(i, n)+1) = x4;
            green_stream_scrambling(mod(i, n)+1) = x5;
            blue_stream_scrambling(mod(i, n)+1) = x6;
            
        end
        
        key_stream_diffusion(1:n) = red_stream_diffusion;
        key_stream_diffusion(n+1: 2*n) = green_stream_diffusion;
        key_stream_diffusion(2*n+1: 3*n) = blue_stream_diffusion;
        
        key_stream_scrambling(1:n) = red_stream_scrambling;
        key_stream_scrambling(n+1: 2*n) = green_stream_scrambling;
        key_stream_scrambling(2*n+1: 3*n) = blue_stream_scrambling;
    end

    [key_stream_diffusion,key_stream_scrambling] = generate_sixD_quence(img);
end
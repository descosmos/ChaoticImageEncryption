function decoded_img = decode_img(original_img, complementary_principle)
%{
    ===============================================
                    decode_image
    ===============================================
    Application:
    The function decoding_dna is implemented to transform the type of image
    from binary to DNA based on the principle "complementary base pairing
    rule".

    Obviously, the function is the complementary to the function
    encode_image.

    Principle:
    1. Complementary is a one dimensional array, according to the rule of
    matlab, the first index of array is 1. 
    
    2. Based on principle 1 and DNA complementary rules, we order the first
    element of array complementary_principle is the complementary of the
    last. Obviously, the rule is 0-3 and 1-2, which is translated to binary
    is 00-11 and 01-10. Obviously, there is no array with the commence 0 in
    matlab, for which we have to establish an mapping to transform the
    origianl position and transformed position. The Conversion rule is 0-1,
    1-2, 2-3, 3-4.

    3. 
%}
    decoded_img = original_img;

    function decoded_one_img = decode_one_img(image, complementary_principle)
        [M,N] = size(image);
        encoded_dna_quence = uint8(zeros(M, N*4));
        decoded_one_img = uint8(zeros(M,N));
        
        % Generate the dna quence by using complementary rule and original
        % image.
        for i=1:M
            for j=1:N
                for index=1:4
                    % transform every binary pixel to dna pixel.
                    dna_pixel = 4*j-index+1;
                    two_bit_of_pixel = 0;
                    two_bit_of_pixel = bitset(two_bit_of_pixel, 1, bitget(image(i,j), 2*index-1));
                    two_bit_of_pixel = bitset(two_bit_of_pixel, 2, bitget(image(i,j), 2*index));
                    
                    % 5-(two_bit_of_pixel+1), which including the
                    % complementary operation and conversion operation.
                    % A-T, C-G conversion 
                    % encoded_dna_quence(i,dna_pixel) = complementary_principle(two_bit_of_pixel+1);
                    encoded_dna_quence(i,dna_pixel) = complementary_principle(5-(two_bit_of_pixel+1));
                end
            end
        end
    
        % Generate the encoded image by using complementary rule and dna
        % quence.
        complementary_dna_quence = zeros(M, N);
        for i=1:M
            for j=1:N
                pixel = 0;
                pixel = uint8(pixel);
                for index=1:4
                    dna_pixel = 4*j-index+1;
                    complementary_dna_quence(i,dna_pixel) = complementary_principle(find(complementary_principle==encoded_dna_quence(i,dna_pixel)));
                    tmp = find(complementary_principle==complementary_dna_quence(i,dna_pixel)) - 1;
                    pixel = bitset(pixel, 2*index-1, bitget(tmp, 1));
                    pixel = bitset(pixel, 2*index, bitget(tmp, 2));
                end
                decoded_one_img(i,j) = pixel;
            end
        end
    end
    
    red_encoded_img = decode_one_img(original_img(:,:,1), complementary_principle(1, :));
    green_encoded_img = decode_one_img(original_img(:,:,2), complementary_principle(1, :));
    blue_encoded_img = decode_one_img(original_img(:,:,3), complementary_principle(1, :));
    
    decoded_img(:,:,1) = red_encoded_img;
    decoded_img(:,:,2) = green_encoded_img;
    decoded_img(:,:,3) = blue_encoded_img;
    
end
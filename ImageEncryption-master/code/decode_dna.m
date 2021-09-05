function img = decode_dna(dna, principle_of_dna)
%{
    decode_dna(): Transform the encoded-format of every pixel from DNA
    to binary.
%}

[M, N] = size(dna);
columns = N/4;
img = uint8(zeros(M,columns));
decoded_dna = zeros(M, N);
% principle_of_dna = [65,67,71,84];   % ascii 'A','C','G','T'

for i=1:M
    for j=1:columns
        pixel = 0;
        pixel = uint8(pixel);
        for index=1:4
            dna_pixel = 4*j-index+1;
            %find(principle_of_dna==dna(i,dna_pixel))
            decoded_dna(i,dna_pixel) = principle_of_dna(5-find(principle_of_dna==dna(i,dna_pixel)));
            tmp = find(principle_of_dna==decoded_dna(i,dna_pixel)) - 1;
;            pixel = bitset(pixel, 2*index-1, bitget(tmp, 1));
            pixel = bitset(pixel, 2*index, bitget(tmp, 2));
        end
        img(i,j) = pixel;
    end
end

end
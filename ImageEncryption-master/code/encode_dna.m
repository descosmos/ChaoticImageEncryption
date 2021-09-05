function dna = encode_dna(img, principle_of_dna)
%{
    encode_dna(): Transform the encoded-format of every pixel from binary
    to DNA, afterwards, convert the original dna sequence into new mode
    with DNA base complementary pairing principle, finally, 
%}
[M,N] = size(img);
%principle_of_dna = [65,67,71,84];   % ascii 'A','C','G','T'
dna = uint8(zeros(M, N*4));
matrix = img;

for i=1:M
    for j=1:N
        for index=1:4
            % 
            dna_pixel = 4*j-index+1;
            two_bit_of_pixel = 0;
            two_bit_of_pixel = bitset(two_bit_of_pixel, 1, bitget(matrix(i,j), 2*index-1));
            two_bit_of_pixel = bitset(two_bit_of_pixel, 2, bitget(matrix(i,j), 2*index));
            dna(i,dna_pixel) = principle_of_dna(5-(two_bit_of_pixel+1));  % A-T, C-G conversion
        end
    end
end

end
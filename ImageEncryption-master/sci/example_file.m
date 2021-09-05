close all, clear all, clc

% Import the image.
%original_image = imread('photos\lena.jpg');
original_image = imread('photos\lena.png');
subplot(2,4,1); imshow(original_image);title('original image')

% The complementary principle of DNA.
dna_complementary_principle = [
        65 67 71 84;
        65 71 67 84;
        67 65 84 71;
        67 84 65 71;
        71 65 84 67;
        71 84 65 67;
        84 67 71 65;
        84 71 67 65;
    ];
dna_complementary_principle = uint8(dna_complementary_principle);


%{
    ===============================================
                Encryption procedure
    ===============================================
%}
% Generate two persudo-random quences key_stream_diffusion and
% key_stream_scrambling, which are used to scramble the original image and 
% diffuse the scrambled image respectively.
[key_stream_diffusion, key_stream_scrambling] = generate_chaotic_quence(original_image);

% Scramble the original image
scrambled_image = scramble_img(original_image, key_stream_scrambling);
subplot(2,4,2); imshow(scrambled_image);title('scrambled image')

% Diffuse the scrambled image
diffused_image = diffuse_img(scrambled_image, key_stream_diffusion);
%diffused_image = cut_and_paste_attack(diffused_image);
%diffused_image = noisy_attack(diffused_image);
subplot(2,4,3); imshow(diffused_image);title('diffused image')

% Convert the diffused image with DNA computing
encoded_image = encode_img(diffused_image, dna_complementary_principle);
subplot(2,4,4); imshow(encoded_image);title('encoded image')

%{
    ===============================================
                Decryption procedure
    ===============================================
%}
% Decode the encoded image
decoded_image = decode_img(encoded_image, dna_complementary_principle);

% Dediffuse the diffused image
dediffused_image = dediffuse_img(diffused_image, key_stream_diffusion);
subplot(2,4,6); imshow(dediffused_image);title('dediffused image')

% Descramble the dediffused image.
% Descrambled image is the decrypted image, which is the copy of original
% image.
descrambled_image = descramble_img(dediffused_image, key_stream_scrambling);
subplot(2,4,7); imshow(descrambled_image);title('descrambled image')


%{
    ===============================================
                Analysis procedure
    ===============================================
%}

% Histogram analysis
% figure;
% analyse_histogram(encoded_image);

% Entropy analysis
% figure;
% entropy_arr = analyse_entropy(encoded_image);

% Correlation analysis
% figure;
% red_correlation = analyse_correlation(encoded_image(:,:,1), 5000);
% green_correlation = analyse_correlation(encoded_image(:,:,2), 5000);
% blue_correlation = analyse_correlation(encoded_image(:,:,3), 5000);

% NPRC analysis
% NPRC = analyse_NPRC(original_image, encoded_image);

% UACI analysis
% UACI = analyse_UACI(original_image, encoded_image);

% 
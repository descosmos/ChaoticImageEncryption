close all, clear all, clc;

principle_of_dna = [65,67,71,84];
original_img = imread('lena.jpg');
original_img = rgb2gray(original_img);
subplot(2,2,1), imshow(original_img, []), title('orginal image');

private_key = generate_key(original_img);
subplot(2,2,2), imshow(private_key, []), title('private_key');

encrypted_img = encrypt_gray_image(original_img, private_key, principle_of_dna);
subplot(2,2,3), imshow(encrypted_img, []), title('encrypted_image');

decrypted_img = decrypt_gray_image(encrypted_img, private_key, principle_of_dna);
subplot(2,2,4) ,imshow(decrypted_img,[]), title('decrypted_image');
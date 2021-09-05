close all, clear all, clc;

principle_of_dna = [65,67,71,84];
img = imread('lena.jpg');
bar_ = generate_statistic_bar(img);
subplot(2,2,1), bar(bar_), title('original image')

private_key = generate_key(img);
bar_ = generate_statistic_bar(private_key);
subplot(2,2,2), bar(bar_), title('private key')

encrypted_image = encrypt_gray_image(img, private_key, principle_of_dna);
bar_ = generate_statistic_bar(encrypted_image);
subplot(2,2,3), bar(bar_), title('encrypted iamge')

decryped_image = decrypt_gray_image(encrypted_image, private_key, principle_of_dna)
function noisy_img = noisy_attack(img)
    %img_gaussian = imnoise(img, 'gaussian', 0, 0.1);
    %imshow(img_gaussian); figure(11)
    
    noisy_img = imnoise(img, 'salt & pepper', 0.3);
end
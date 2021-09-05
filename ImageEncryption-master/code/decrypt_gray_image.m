function decrypted_img = decrypt_gray_image(encrypted_img, private_key, principle_of_dna)
%{
    decrypt_gray_image(): Decrypt image with key, obtaing the original
    image.
    There are two vital procedures in decrypt_gray_image:
    1. Decrypt encrypted_img by using private_key, after that, the
    encrypted_img is transformed into dna sequence.
    2. Transform dna to original image.
%}

dna = bitxor(private_key, encrypted_img);
decrypted_img = decode_dna(dna, principle_of_dna);

end
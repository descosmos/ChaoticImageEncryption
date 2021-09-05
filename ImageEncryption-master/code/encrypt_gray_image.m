function encrypted_image = encrypt_gray_image(img, private_key, principle_of_dna)
%{
    encrypt_gray_image(): Encrypt a gray encoing image with key, obtaing an encrypted
    iamge.
    1. Encrypt gray image by using private_key, afterwards, obtaning the
    encrypted image.
    2. Recode encrypted iamge to the type of dna.
%}

dna = encode_dna(img, principle_of_dna);
encrypted_image = bitxor(private_key,dna);
end
function PSNR = analyse_PSNR(original_img, encrypted_img)
%{
    ===============================================
                    analyse_PSNR
    ===============================================
    Definition:
    To gauge the encryption quality.
    As the given plain image is encrypted, it undergoes a sea change,
    in its pixels. To measure this change, PSNR is employed. 

    Application:
    The function analyse_PSNR is used to caculate the PSNR of an encryption
    algorithm.
%}

    PSNR = psnr(original_img, encrypted_img);
end
function SSIM = analyse_SSIM(original_img, encrypted_img)
%{
    ===============================================
                    analyse_SSIM
    ===============================================
    Definition:
    To gauge the encryption quality.
    As the given plain image is encrypted, it undergoes a sea change,
    in its pixels. To measure this change, SSIM is employed.
    
    Application:
    The function analyse_SSIM is used to caculate the SSIM of an encryption
    algorithm.
%}

    SSIM = ssim(original_img, encrypted_img);
end
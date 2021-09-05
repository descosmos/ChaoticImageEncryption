function MSE = analyse_MSE(original_img, encrypted_img)
%{
    ===============================================
                    analyse_MSE
    ===============================================
    Definition:
    To gauge the encryption quality.
    As the given plain image is encrypted, it undergoes a sea change,
    in its pixels. To measure this change, MSE is employed. Relatively
    higher value of MSE is always desired by the cryptographers.
    
    Application:
    The function analyse_MSE is used to caculate the MSE of an encryption
    algorithm.
%}
    MSE = immse(original_img, encrypted_img);
end
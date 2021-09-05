function NPRC = analyse_NPRC(original_img, encrypted_img)
%{
    ===============================================
                    analyse_NPRC
    ===============================================
    Definition:
    The robustness of this attack is judged through the two security
    parameters.The NPRC is number of pixels change rate , 
    which security parameters test the influence of
    changing a single pixel on the encrypted image.
    
    Application:
    The function analyse_correlation is used to illustrates the difference
    rate between the original image and the encrypted.
%}

    [M, N] = size(original_img);
    num = 0;
    n = M*N;
    
    for i = 1:n
        if original_img(i) ~= encrypted_img(i)
            num = num+1;
        end
    end
    
    NPRC = num/n;
end
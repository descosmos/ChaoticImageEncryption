function UACI = analyse_UACI(original_img, encrypted_img)
%{
    ===============================================
                    analyse_UACI
    ===============================================
    Definition:
    The robustness of this attack is judged through the two security
    parameters.The UACI is unified average changing intensity, 
    which security parameters test the influence of
    changing a single pixel on the encrypted image.
    
    Application:
    The function analyse_correlation is used to illustrates the averaged 
    difference between the two cipher images.
%}

    [M, N] = size(original_img);
    n = M*N;
    accumulate = 0;
    accumulate = double(accumulate);
    
    for i=1:M
        for j=1:N
            accumulate = accumulate + double(abs(original_img(i,j)-encrypted_img(i,j)))/255.0;
        end
    end
    
    
    
    UACI = accumulate / n;
    UACI = sum( abs( original_img(:) - encrypted_img(:) ) ) / M*N / 255; 
end
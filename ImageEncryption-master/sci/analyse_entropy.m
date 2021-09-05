function entropy_arr = analyse_entropy(img)
%{
    ===============================================
                    analyse_entropy
    ===============================================
    Definition:
    Entropy in information theory is directly analogous to the entropy 
    in statistical thermodynamics. The analogy results when the values of 
    the random variable designate energies of microstates, 
    so Gibbs formula for the entropy is formally identical to Shannon's formula.
    
    Application:
    The function analyse_entropy is used to caculate the entropy of one
    photo, the variable indicates the encryption algorithm is good or bad.
%}
    entropy_arr = zeros(1,3);

    function entropy = analyse_one_entropy(one_img)
        one_img = double(one_img);
        [M,N] = size(one_img);
        one_img = transpose(one_img(:));
        T = zeros(1, 256);
    
        for i = 1: 256
            T(i) = sum(one_img == (i-1));
            T(i) = T(i)/(M*N);
        end
    
        entropy = -T(T>0)*transpose(log2(T(T>0)));
    end

    entropy_arr(1) = analyse_one_entropy(img(:,:,1));
    entropy_arr(2) = analyse_one_entropy(img(:,:,2));
    entropy_arr(3) = analyse_one_entropy(img(:,:,3));
end
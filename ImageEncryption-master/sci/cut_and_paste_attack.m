function result_image = cut_and_paste_attack(original_img)
%{
    ===============================================
                    cut-and-paste attack
    ===============================================
    Definition: 
    A cut-and-paste attack is an assault on the integrity of a security system 
    in which the attacker substitutes a section of ciphertext (encrypted text) 
    with a different section that looks like (but is not the same as) the one removed.
    
    Application:
    The function cut_and_paste_attack is used to cut a part of original
    image, and return the cut image.
%}
    red_img = original_img(:,:,1);
    green_img = original_img(:,:,2);
    blue_img = original_img(:,:,3);
    
    red_img(15:40, :) = 0;
    green_img(15:40, :) = 0;
    blue_img(15:40, :) = 0;
    
    original_img(:,:,1) = red_img;
    original_img(:,:,2) = green_img;
    original_img(:,:,3) = blue_img;
    result_image = original_img;
end
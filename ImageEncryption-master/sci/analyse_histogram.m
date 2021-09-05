function analyse_histogram(img)
%{
    ===============================================
                    analyse_histogram
    ===============================================
    Definition:
    An image histogram illustrates the indensity distribution 
    of indexd or gray scale images. The histogram of a well encrypted
    image should be as uniform as can be.
    
    Application:
    The function analyse_histogram is used to show the pixel's distribution 
    of image.
%}
    
    imhist(img(:,:,1)); title('red part distribution'); figure;
    imhist(img(:,:,2)); title('green part distribution'); figure;
    imhist(img(:,:,3)); title('blue part distribution');
end
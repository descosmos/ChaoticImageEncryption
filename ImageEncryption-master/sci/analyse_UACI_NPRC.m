function results = analyse_uaci_nprc( img_a, img_b, need_display, largest_allowed_val )
% =========================================================================
% FUNCTION: 
%        gives NPCR & UACI quantitative and qualitative scores for
%        the strength against possible differential attacks of image
%        ciphers
% =========================================================================
% INPUT:
%        img_a, img_b: two encrypted images of same size and type
%        need_display: on/off option to show outputs (default: on)
%        largest_allowed_val: is the value of the largest theoretical 
%                      allowed value in encrypted image. If it is not
%                      provided, algorithm will automatically choose one.
% =========================================================================
% OUTPUT:
%        results.npcr_score: quantitative NPCR score (larger is better)
%        results.npcr_pVal : qualitative NPCR score  (larger is better)
%        results.npcr_dist : theoretical NPCR normal dist. (mean +\- var)
%        results.uaci_score: quantitative UACI score (larger is NOT better)
%        results.uaci_pVal : qualitative UACI score  (larger is better)
%        results.uaci_dist : theoretical UACI normal dist. (mean +\- var)
% =========================================================================
% DEMO:  
%        % Demo 1: simple use
%        % generate two 256x256 8-bit random-imges
%        img_a = randi(256,256,256) - 1; 
%        img_b = randi(256,256,256) - 1; 
%        % get NPCR and UACI scores
%        results = NPCR_and_UACI( img_a, img_b, 1, 255 );
% 
%        %% Demo 2: why we need qualitative pVals besides quantitative scores
%        img_a = imread('cameraman.tif');
%        img_b = uint8( randi(256,256,256)-1 );
%        tmp = NPCR_and_UACI( img_a, flipud( fliplr (img_a) ) );
%        score.camman = [ tmp.npcr_score, tmp.uaci_score ]; pVals.camman = [ tmp.npcr_pVal, tmp.uaci_pVal ]; 
%        tmp = NPCR_and_UACI( img_b, flipud( fliplr (img_b) ) );
%        score.rand = [ tmp.npcr_score, tmp.uaci_score ]; pVals.rand = [ tmp.npcr_pVal, tmp.uaci_pVal ]; 
%        tmp = NPCR_and_UACI( img_a, img_b );
%        score.cam_and_rand = [ tmp.npcr_score, tmp.uaci_score ]; pVals.cam_and_rand = [ tmp.npcr_pVal, tmp.uaci_pVal ]; 
%        display( ['Can you easily figure out random-like image pairs from their scores?']), display(score)
%        display( ['These scores are often less imformative than you thought, arnt they?'])
%        display( ['--------------------------------------------------------------------'])
%        display( ['Can you easily figure out random-like images from pure pVals (the smaller a pVal is, the less likely a test image is random-like)?']), display(pVals)
%        display( 'Do you see that UACI pVals for the camman image pair and the camman and rand image pair are extremely small?')
%        display( 'These pVals indicating that these two pairs are distinguishable from truely random ones.')
%        display( ['--------------------------------------------------------------------'])
%        %% Demo 3: NPCR and UACI distributions for random images
%        nsample = 10000;
%        npcr_score = zeros(1,nsample); npcr_pVal = zeros(1,nsample);
%        uaci_score = zeros(1,nsample); uaci_pVal = zeros(1,nsample);
%        for i = 1:nsample
%             img_a = randi(256,256,256) - 1;
%             img_b = randi(256,256,256) - 1;
%             this_result = NPCR_and_UACI( img_a, img_b, 0 , 255);
%             npcr_score(i) = this_result.npcr_score;
%             uaci_score(i) = this_result.uaci_score;
%             npcr_pVal(i) = this_result.npcr_pVal;
%             uaci_pVal(i) = this_result.uaci_pVal;
%        end
%        % npcr pdf distribution
%        [ hist_npcr, val_npcr ] = hist( npcr_score, [0:(1/65536):1] );
%        figure,subplot(221),bar( val_npcr, hist_npcr / sum(hist_npcr) ), title( 'NCPR pdf' );
%        theoretical_hist_npcr = normcdf( val_npcr, this_result.npcr_dist(1), sqrt( this_result.npcr_dist(2) ) ) ...
%               - normcdf( [0,val_npcr(1:end-1)], this_result.npcr_dist(1), sqrt( this_result.npcr_dist(2) ) );
%        hold on, plot( val_npcr, theoretical_hist_npcr, 'r--','LineWidth', 2 ), xlim( [ this_result.npcr_dist(1)+4*sqrt( this_result.npcr_dist(2) )*[-1,1] ])
%        legend( 'sample distribution', 'theoretical distribution', 4); axis square;
%        % npcr cdf distribution
%        subplot(223),bar( val_npcr, cumsum(hist_npcr / sum(hist_npcr)) ), title( 'NCPR cdf' );
%        hold on, plot( val_npcr, cumsum(theoretical_hist_npcr), 'g--','LineWidth', 2 ), xlim( [ this_result.npcr_dist(1)+4*sqrt( this_result.npcr_dist(2) )*[-1,1] ])
%        legend( 'sample distribution', 'theoretical distribution', 4); axis square;
%        % uaci pdf distribution
%        [ hist_uaci, val_uaci ] = hist( uaci_score, [0:(1/65536):1] );
%        subplot(222),bar( val_uaci, hist_uaci / sum(hist_uaci) ), title( 'UACI pdf' );
%        theoretical_hist_uaci = normcdf( val_uaci, this_result.uaci_dist(1), sqrt( this_result.uaci_dist(2) ) ) ...
%               - normcdf( [0,val_uaci(1:end-1)], this_result.uaci_dist(1), sqrt( this_result.uaci_dist(2) ) );
%        hold on, plot( val_uaci, theoretical_hist_uaci, 'r--','LineWidth', 2 ), xlim( [ this_result.uaci_dist(1)+4*sqrt( this_result.uaci_dist(2) )*[-1,1] ])
%        legend( 'sample distribution', 'theoretical distribution', 4 ); axis square;
%        % uaci cdf distribution
%        subplot(224),bar( val_uaci, cumsum(hist_uaci / sum(hist_uaci)) ), title( 'UACI cdf' );
%        hold on, plot( val_uaci, cumsum(theoretical_hist_uaci), 'g--','LineWidth', 2 ),  xlim( [ this_result.uaci_dist(1)+4*sqrt( this_result.uaci_dist(2) )*[-1,1] ])
%        legend( 'sample distribution', 'theoretical distribution', 4 ); axis square;
% =========================================================================
% SCORE INTERPRETATION:        
%        if your cipher is abled to encrypted images that indistinguishable
%        from random images under the NPCR and UACI measures, pVals simply 
%        represent the possibility that your tested images are indeed random
%        -like, and thus a larger pVal is preferred. On the other hand, 
%        pVals are random variables, and could be very small (say 0.0001)
%        even though test images are truely random-like. Therefore, it is
%        meaningless to make any conclusive claim for a small test data set.
%        However, if you observe that out of 100 tested image pairs, 5 of
%        them fail to achieve pVals greater than 0.01 (or 1%), then this is
%        a clear indicator that this image cipher fail to generated
%        random-like outputs, because if we use 100 truely random-like
%        image pairs, we will only observe 1 out 100 with pVal less than
%        0.01 in theory.
% =========================================================================
% NOTE:
%        1. This code is only free-of-use for research and acadmic use.
%        2. Whenever the proposed code is used in scitific research,
%           please kindly cite the related article(s). 
%        3. Achieving a good randomness P-vals does not guarantee a
%           cipher is secure. The only thing that is safe to claim is that
%           "a cipher is able to generate random-like data indistinguishable
%           from those truely random-like under XXX measure"
%        4. One may find UACI and NPCR are defined differently in
%           literature. This implementation adopts the definitions given in 
%           the paper below.
% =========================================================================
% PAPER INFORMATION:
%       Wu, Y., Noonan, J. P., & Agaian, S.  
%       NPCR and UACI randomness tests for image encryption. 
%       on Journal of Selected Areas in Telecommunications (JSAT), 31-38. 
%       2011. (http://www.cyberjournals.com/Papers/Apr2011/05.pdf)
% =========================================================================
% CONTACT:
%        Name: Dr. Yue Wu 
%       Email: ywu03@ece.tufts.edu.
% =========================================================================
%% 1. input_check 
[ height_a, width_a, depth_a ] = size( img_a );
[ height_b, width_b, depth_b ] = size( img_b );
if ( ( height_a ~= height_b ) ...
  || (  width_a ~=  width_b ) ...
  || (  depth_a ~=  depth_b ) )
    error( 'input images have to be of same dimensions' );
end
class_a = class( img_a );
class_b = class( img_b );
if ( ~strcmp( class_a, class_b) )
    error( 'input images have to be of same data type'); 
end
%% 2. measure preparations
if ( ~exist( 'largest_allowed_val', 'var') )
    switch  class_a 
        case 'uint16'
            largest_allowed_val = 65535;
        case 'uint8'
            largest_allowed_val = 255;
        case 'logical'
            largest_allowed_val = 2;
        otherwise
            largest_allowed_val = max ( max( img_a(:), img_b(:) ) );
    end
end
if ( ~exist( 'need_display', 'var' ) ) 
    need_display = 1;
end
img_a = double( img_a );
img_b = double( img_b );
num_of_pix = numel( img_a );
%% 3. NCPR score and p_value
results.npcr_score = sum( double( img_a(:) ~= img_b(:) ) ) / num_of_pix;
npcr_mu  = ( largest_allowed_val ) / ( largest_allowed_val+ 1 );
npcr_var =  ( ( largest_allowed_val) / ( largest_allowed_val+ 1 )^2 ) / num_of_pix;
results.npcr_pVal = normcdf( results.npcr_score, npcr_mu, sqrt( npcr_var ) );
results.npcr_dist = [ npcr_mu, npcr_var ];
%% 4. UACI score and p_value 
results.uaci_score = sum( abs( img_a(:) - img_b(:) ) ) / num_of_pix / largest_allowed_val; 
uaci_mu  = ( largest_allowed_val+2 ) / ( largest_allowed_val*3+3 );
uaci_var = ( ( largest_allowed_val+2 ) * ( largest_allowed_val^2 + 2*largest_allowed_val+ 3 ) /18 / ( largest_allowed_val+ 1 )^2 / largest_allowed_val) / num_of_pix;
p_vals = normcdf( results.uaci_score, uaci_mu, sqrt( uaci_var ) );
p_vals( p_vals > 0.5 ) = 1 - p_vals( p_vals > 0.5 );
results.uaci_pVal = 2 * p_vals;
results.uaci_dist = [ uaci_mu, uaci_var ];
%% 5. optional output
if ( need_display ) 
   format long;
   display( results ); 
end
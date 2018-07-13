function [peaksnr,mse] =  psnr_mse(ref,img)  
    if size( ref, 3 ) == 3 
        ref = rgb2gray( ref );
    end
    
%     if ~isa(ref, 'double')
%         ref = double(ref);
%     end
    
    if size( img, 3 ) == 3 
        img = rgb2gray( img );
    end
%     if ~isa(img, 'double')
%         img = double(img);
%     end
    
    peaksnr = psnr(img,ref);

    mse = immse(img, ref);


clc;close all; clear;
img1 = imread('image/i05.bmp');

img2 = imread('image/i02.bmp');

% tid2013_dir ='/home/student/Downloads/papers/image_quality_assessment/dataset/tid2013';
% img1 = imread([tid2013_dir '/reference_images/i24.bmp']);
% img2 = imread([tid2013_dir '/distorted_images/i24_01_5.bmp']);
% img3 = imread([tid2013_dir '/distorted_images/i24_08_4.bmp']);
% img4 = imread([tid2013_dir '/distorted_images/i24_10_5.bmp']);
% img5 = imread([tid2013_dir '/distorted_images/i24_11_4.bmp']);

 if size( img1, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
        img1 = rgb2gray( img1 );
 end
 if size( img2, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
        img2 = rgb2gray( img2 );
 end

 [c,r] = size(img2);
 c= c-2;
 r= r-2;
 R =1;
 [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img1 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img1,jnd_map, R );


figure(1);bar(var_jndvp_cnt_one_hist./(c*r));
xlabel('Bins','FontSize',12);ylabel('Energy','FontSize',12);


 [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img2 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img2,jnd_map, R );

figure(2);bar(var_jndvp_cnt_one_hist./(c*r));
xlabel('Bins','FontSize',12);ylabel('Energy','FontSize',12);





















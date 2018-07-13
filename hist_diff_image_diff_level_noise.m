clc;close all; clear;
img1 = imread('image/i05.bmp');
img1_awgn_1 = imread('image/i05_01_3.bmp');%4.84615 i05_01_3.bmp
img1_awgn_2 = imread('image/i05_01_4.bmp'); %4.05128 i05_01_4.bmp
img1_awgn_3 = imread('image/i05_01_5.bmp');% 3.56098 i05_01_5.bmp

img2 = imread('image/i02.bmp');
img2_awgn_1 = imread('image/i02_01_3.bmp');%5.22222 i02_01_3.bmp
img2_awgn_2 = imread('image/i02_01_4.bmp');% 4.19444 i02_01_4.bmp
img2_awgn_3 = imread('image/i02_01_5.bmp');%3.97297 i02_01_5.bmp


[p1,m1] = psnr_mse(img1,img1_awgn_1)

[p2,m2] = psnr_mse(img1,img1_awgn_2)

[p3,m3] = psnr_mse(img1,img1_awgn_3)


[p1,m1] = psnr_mse(img2,img2_awgn_1)

[p2,m2] = psnr_mse(img2,img2_awgn_2)

[p3,m3] = psnr_mse(img2,img2_awgn_3)




% tid2013_dir ='/home/student/Downloads/papers/image_quality_assessment/dataset/tid2013';
% img1 = imread([tid2013_dir '/reference_images/i24.bmp']);
% img2 = imread([tid2013_dir '/distorted_images/i24_01_5.bmp']);
% img3 = imread([tid2013_dir '/distorted_images/i24_08_4.bmp']);
% img4 = imread([tid2013_dir '/distorted_images/i24_10_5.bmp']);
% img5 = imread([tid2013_dir '/distorted_images/i24_11_4.bmp']);

 if size( img1, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
        img1 = rgb2gray( img1 );
        img1_awgn_1 = rgb2gray( img1_awgn_1 );
        img1_awgn_2 = rgb2gray( img1_awgn_2 );
        img1_awgn_3 = rgb2gray( img1_awgn_3 );
 end
 if size( img2, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
        img2 = rgb2gray( img2 );
        img2_awgn_1 = rgb2gray( img2_awgn_1 );
        img2_awgn_2 = rgb2gray( img2_awgn_2 );
        img2_awgn_3 = rgb2gray( img2_awgn_3 );
 end
%   if size( img3, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
%         img3 = rgb2gray( img3 );
%   end  
 [c,r] = size(img1);
 c= c-2;
 r= r-2;
 R =1;
 [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img1 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img1,jnd_map, R );
  bar_data1(:,1) = var_jndvp_cnt_one_hist./(c*r);
                                  
  [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img1_awgn_1 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img1_awgn_1,jnd_map, R );                 
   bar_data1(:,2) = var_jndvp_cnt_one_hist./(c*r);                
      
   
   
   [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img1_awgn_2 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img1_awgn_2,jnd_map, R );                 
   bar_data1(:,3) = var_jndvp_cnt_one_hist./(c*r);   
   
   
   [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img1_awgn_3 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img1_awgn_3,jnd_map, R );                 
   bar_data1(:,4) = var_jndvp_cnt_one_hist./(c*r);   
   
   h1 = figure(1)
b = bar( bar_data1, 1 ,'grouped','FaceColor','flat');
leg = legend( 'org', 'awgn\_L1', 'awgn\_L2', 'awgn\_L3','Location', 'best' );
xlab = xlabel( 'Bins' , 'FontSize',12);
ylab = ylabel( 'Energy' , 'FontSize',12);

 
[ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img2 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img2,jnd_map, R );
 bar_data2(:,1) = var_jndvp_cnt_one_hist./(c*r);
                                  
  [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img2_awgn_1 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img2_awgn_1,jnd_map, R );                 
   bar_data2(:,2) = var_jndvp_cnt_one_hist./(c*r);                
      
   
   
   [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img2_awgn_2 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img2_awgn_2,jnd_map, R );                 
   bar_data2(:,3) = var_jndvp_cnt_one_hist./(c*r);   
   
   
   [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img2_awgn_3 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img2_awgn_3,jnd_map, R );                 
   bar_data2(:,4) = var_jndvp_cnt_one_hist./(c*r);  



   h1 = figure(2)
b2 = bar( bar_data2, 1 ,'grouped','FaceColor','flat');
leg = legend( 'org', 'awgn\_L1', 'awgn\_L2', 'awgn\_L3','Location', 'best' );
xlab = xlabel( 'Bins' , 'FontSize',12);
ylab = ylabel( 'Energy' , 'FontSize',12);

close all;
clear;clc
tid2013_dir ='/home/student/Downloads/papers/image_quality_assessment/dataset/tid2013';



ref = imread([tid2013_dir '/reference_images/i05.bmp']);
img1 = imread([tid2013_dir '/distorted_images/i05_01_5.bmp']); % mos  3.56098 i05_01_5.bmp
img2 = imread([tid2013_dir '/distorted_images/i05_08_4.bmp']); % 2.78049 i05_08_4.bmp   1.25000 i05_08_5.bmp
img3 = imread([tid2013_dir '/distorted_images/i05_10_5.bmp']);% 3.43902 i05_10_4.bmp  1.87805 i05_10_5.bmp
img4 = imread([tid2013_dir '/distorted_images/i05_11_5.bmp']);% 3.66667 i05_11_4.bmp   2.25000 i05_11_5.bmp

[p1,m1] = psnr_mse(ref,img1)

[p2,m2] = psnr_mse(ref,img2)

[p3,m3] = psnr_mse(ref,img3)


[p4,m4] = psnr_mse(ref,img4)


% ref = imread([tid2013_dir '/reference_images/i24.bmp']);
% img1 = imread([tid2013_dir '/distorted_images/i24_01_5.bmp']);
% img2 = imread([tid2013_dir '/distorted_images/i24_08_4.bmp']);
% img3 = imread([tid2013_dir '/distorted_images/i24_10_5.bmp']);
% img4 = imread([tid2013_dir '/distorted_images/i24_11_4.bmp']);


 if size( ref, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
        ref = rgb2gray( ref );
 end

 if size( img1, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
        img1 = rgb2gray( img1 );
 end
 if size( img2, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
        img2 = rgb2gray( img2 );
 end
  if size( img3, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
        img3 = rgb2gray( img3 );
  end  
  if size( img4, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
        img4 = rgb2gray( img4 );
  end  
  [c,r] = size(img3);
  c=c-2
  r=r-2
  R =1;
[ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( ref );
  

[jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( ref,jnd_map, R );

bar_data(:,1) = var_jndvp_cnt_one_hist./(c*r);

[ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img1 );
[jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img1,jnd_map, R );
 
 bar_data(:,2) = var_jndvp_cnt_one_hist./(c*r);                  
 
 [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img2 );
[jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img2,jnd_map, R );               
                   
 bar_data(:,3) = var_jndvp_cnt_one_hist./(c*r);                  
   
 [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img3 );
[jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img3,jnd_map, R );               
                   
 bar_data(:,4) = var_jndvp_cnt_one_hist./(c*r);   
 
%  [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img4 );
%  [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
%              jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
%                        var_jndvp_like_wu_hist ] = jndvp_var_jndmap( img4,jnd_map, R );               
%                    
%  bar_data(:,5) = sqrt(jndvp_cnt_one_hist./(c*r));  
 
 
                   
h = figure(1)
b = bar( bar_data, 1 ,'grouped','FaceColor','flat');
% for k = 1:size(bar_data,2)
%     if k == 1 b(k).FaceColor = 'k';end 
%     if k == 2 b(k).FaceColor = 'r';end 
%     if k == 3 b(k).FaceColor = 'g';end 
%     if k == 4 b(k).FaceColor = 'b';end 
%     if k == 5 b(k).FaceColor = 'c';end 
% end
% axis( [0 11 0 0.31] );
leg = legend( 'org', 'awgn', 'gblur', 'jpeg', 'Location', 'best' );
xlab = xlabel( 'Bins' , 'FontSize',12);
ylab = ylabel( 'Energy' , 'FontSize',12);

saveas(h, 'jndvp_hist_awgn_blur_jp_j2k.png','png') 
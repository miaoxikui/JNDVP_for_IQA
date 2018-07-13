close all;clear;clc
tid2013_dir ='/home/student/Downloads/papers/image_quality_assessment/dataset/tid2013';

 ref = imread([tid2013_dir '/reference_images/i24.bmp']);
 img1 = imread([tid2013_dir '/distorted_images/i24_01_5.bmp']);
 img2 = imread([tid2013_dir '/distorted_images/i24_08_4.bmp']);
 img3 = imread([tid2013_dir '/distorted_images/i24_10_5.bmp']);
 img4 = imread([tid2013_dir '/distorted_images/i24_11_4.bmp']);


[p1,m1] = psnr_mse(ref,img1)

[p2,m2] = psnr_mse(ref,img2)

[p3,m3] = psnr_mse(ref,img3)

[p4,m4] = psnr_mse(ref,img4)


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
  [c,r] = size(img3)
  R =1;
  
[ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( ref );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( ref,jnd_map, R );
h1 = figure(1);imagesc( jnd_cnt_one_map);colorbar('FontSize',12);axis off;
saveas(h1, 'i24_cnt_one_9type_map_ref.png','png')
  
 [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img1 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img1,jnd_map, R );
h2 = figure(2);imagesc( jnd_cnt_one_map);colorbar('FontSize',12);axis off;
saveas(h2, 'i24_cnt_one_9type_map_awgn.png','png')

[ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img2 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img2,jnd_map, R );
h3 = figure(3);imagesc(jnd_cnt_one_map);colorbar('FontSize',12);axis off;
saveas(h3, 'i24_cnt_one_9type_map_gblur.png','png');



[ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img3 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img3,jnd_map, R );

h4= figure(4);imagesc(jnd_cnt_one_map);colorbar('FontSize',12);axis off;
saveas(h4, 'i24_cnt_one_9type_map_jpeg.png','png');


[ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img4 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img3,jnd_map, R );

h5= figure(5);imagesc(jnd_cnt_one_map);colorbar('FontSize',12);axis off;
saveas(h5, 'i24_cnt_one_9type_map_jp2k.png','png');

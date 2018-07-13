clc;close all; clear;
img1 = imread('image/i13.bmp');
img2 = imread('image/i21.bmp');
img3 = imread('image/i22.bmp');


 if size( img1, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
        img1 = rgb2gray( img1 );
 end
 if size( img2, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
        img2 = rgb2gray( img2 );
 end
  if size( img3, 3 ) == 3 % for gray image; operating it on the three channel seperatively for colorful result 
        img3 = rgb2gray( img3 );
  end  
 [c,r] = size(img3)
  R =1;
 [ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img1 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img1,jnd_map, R );
h1 = figure(1);imagesc( jnd_cnt_one_map);colorbar('FontSize',12);axis off;
saveas(h1, 'i13_cnt_one_9type_map.png','png')

 h4 = figure(4);imshow( jndvp_code,[]);axis off;
saveas(h4, 'i19_jndvp_code.png','png')

[ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img2 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img2,jnd_map, R );
h2 = figure(2);imagesc(jnd_cnt_one_map);colorbar('FontSize',12);axis off;
saveas(h2, 'i21_cnt_one_9type_map.png','png');

h5 = figure(5);imshow( jndvp_code,[]);axis off;
saveas(h5, 'i21_jndvp_code.png','png')

[ img_jnd, jnd_map, jnd_LA, jnd_VM, complexity_map ] = func_JND_modeling_pattern_complexity( img3 );
    
 [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
             jndvp_cnt_one_hist, jndvp_like_wu_hist ,var_jndvp_lbp_hist, var_jndvp_cnt_one_hist,...
                       var_jndvp_like_wu_hist ] = jndvp_grad_jndmap( img3,jnd_map, R );

h3= figure(3);imagesc(jnd_cnt_one_map);colorbar('FontSize',12);axis off;
saveas(h3, 'i22_cnt_one_9type_map.png','png');

h6 = figure(6);imshow( jndvp_code,[]);axis off;
saveas(h6, 'i22_jndvp_code.png','png')


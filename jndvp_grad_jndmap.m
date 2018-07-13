function [jndvp_code,jndv_lbp_map,jnd_cnt_one_map,jnd_like_wu_map, jndvp_lbp_hist, ...
   jndvp_cnt_one_hist, jndvp_like_wu_hist ,grad_jndvp_lbp_hist, grad_jndvp_cnt_one_hist,...
   grad_jndvp_like_wu_hist ] = jndvp_var_jndmap( img,jndmap, R )

if (nargin < 1 || nargin >3)
    error('Input wrong data!');
end
if (nargin == 2)
    R = 1;
end

% clear;close all;
% R =1;
% img = imread( 'lena.png' ); % 0_5_5785.jpg, lighthouse.bmp, lena.png   monument.png


if size( img, 3 ) == 3
    img = rgb2gray( img );
end

if ~isa(img, 'double')
    img = double(img);
end

jnd_map = jndmap;

nb = 8 * R ;% neighbor number
sps=zeros(nb,2); % Angle step.
as = 2*pi/nb;
for i = 1:nb
    sps(i,1) = -R*sin((i-1)*as);
    sps(i,2) = R*cos((i-1)*as);
end


P = 8;
lbp_type = { 'ri' 'u2' 'riu2' };
y = 3;
mtype = lbp_type{y};
MAPPING = getmapping( P, mtype );

% imgd = padarray( img, [R R], 'symmetric' ); %imshow(imgd,[])
imgd = img;

[ row, col ] = size( imgd );

img = img( R+1:row-R,R+1:col-R );
jnd_map = jnd_map( R+1:row-R,R+1:col-R );


% dx = [1 0 -1; 1 0 -1; 1 0 -1]/3;
% dy = dx';
% IxY1 = conv2(imgd, dx, 'same');
% IyY1 = conv2(imgd, dy, 'same');
% gradientMap = sqrt(IxY1.^2 + IyY1.^2);  

ky = [ -1 0 1; -1 0 1; -1 0 1 ]/3; % filter alone y
kx = ky'; % filter alone x
Gx = imfilter( imgd, kx );
Gy = imfilter( imgd, ky );
img_grad = sqrt( Gx.^2 + Gy.^2 );
img_grad = img_grad( R+1:row-R,R+1:col-R );

Cvimg = zeros( row,col );
Cvimg( img_grad>=10 ) = 1; % valid pixels (filter out the plain region)



jndvp_code = zeros( row-2*R, col-2*R );

jndv_lbp_map = zeros( row-2*R, col-2*R );
jnd_cnt_one_map  = zeros( row-2*R, col-2*R );
jnd_like_wu_map = zeros( row-2*R, col-2*R );

jndvp_lbp_hist  = zeros(1,MAPPING.num);
jndvp_cnt_one_hist = zeros(1,nb +1);
jndvp_like_wu_hist = zeros(1,nb);


for i = 1:nb
  dx = round( R+sps(i,1) );
  dy = round( R+sps(i,2) );
  imgd_temp = imgd( dx+1:row-2*R+dx, dy+1:col-2*R+dy );
  
  jnd_bit =  abs( imgd_temp - img )  ;
  
  last_state = zeros( row-2*R, col-2*R );
  
  last_state( jnd_bit > jnd_map ) = 1; 
  
  p = 2^(i-1);
  jndvp_code = jndvp_code + p*last_state;
  
  jnd_cnt_one_map = jnd_cnt_one_map + last_state;
end


jndv_lbp_map = MAPPING.table(jndvp_code+1);

jndvp_lbp_hist = hist( jndv_lbp_map(:), 0:MAPPING.num - 1 );
% jndvp_lbp_hist=jndvp_lbp_hist/sum(jndvp_lbp_hist(:));
%figure(1) ; bar( jndvp_lbp_hist);

grad_jndvp_lbp_hist = zeros( 1,MAPPING.num );
for i = 1 : MAPPING.num
    grad_jndvp_lbp_hist(i) = sum( sum( img_grad( jndv_lbp_map == i-1) ) ); % account the energy of each bin
end
%figure(2);bar(grad_jndvp_lbp_hist)



jndvp_cnt_one_hist = hist( jnd_cnt_one_map(:), 0:nb );
% jndvp_cnt_one_hist=jndvp_cnt_one_hist/sum(jndvp_cnt_one_hist(:));
%figure(3) ; bar( jndvp_cnt_one_hist);

grad_jndvp_cnt_one_hist = zeros( 1, nb+1 );
for i = 1 : nb+1
    grad_jndvp_cnt_one_hist(i) = sum( sum( img_grad( jnd_cnt_one_map == i-1) ) ); % account the energy of each bin
end
%figure(4);bar(grad_jndvp_cnt_one_hist)



mapping_vect = func_mapping( nb ); % mapping vector for pattern
jnd_like_wu_map = mapping_vect(jndvp_code+1); % combination of pattern
% mapping 
bin_num = max(mapping_vect)+1;
jndvp_like_wu_hist = hist(jnd_like_wu_map(:),0:nb-1);
%jndvp_like_wu_hist = jndvp_like_wu_hist./sum(jndvp_like_wu_hist(:));
%figure(5) ; bar(jndvp_like_wu_hist );

grad_jndvp_like_wu_hist = zeros( 1,bin_num );
for i = 1 : bin_num
    grad_jndvp_like_wu_hist(i) = sum( sum( img_grad( jnd_like_wu_map == i-1) ) ); % account the energy of each bin
end
%figure(6);bar(grad_jndvp_like_wu_hist)


 end

function mapping_vect = func_mapping( P )
% combination of orientation selectivity based pattern based on the
% exicited subfield
newMax  = 0;
mapping0 = 0:2^P-1;
tmpMap = zeros(2^P,1) - 1;
valMap = zeros(2^P,1) - 1;
for i = 0:2^P-1
    rm = i;
    r  = i;
    for j = 1:P-1
        test1 = bitshift(r,1,'uint8');
        test2 = bitget(r,P);
        r = bitset( test1, 1, test2 );
        if r < rm
          rm = r;
        end
    end
    if tmpMap(rm+1) < 0
      tmpMap(rm+1) = newMax;
      valMap(newMax+1) = i;
      newMax = newMax + 1;
    end
    mapping0(i+1) = tmpMap(rm+1);
end
mapping_vect = 0:2^P-1;
for x = 0 : newMax-1
  x0 = 0;
  x1 = 0;
  xv = valMap(x+1);
  for y = P-1:-1:1
      bit1 = bitget( xv, y );
      if bit1 == 1
          x1 = y;
          break;
      end
  end
  mapping_vect( mapping0==x ) = x1-x0;
end

return;
end



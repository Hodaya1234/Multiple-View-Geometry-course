load('data.mat')
x={K\x{1},K\x{1}};
load('compex2data.mat');
%%
im1=imread('kronan1.JPG');
im2=imread('kronan2.JPG');
%%
d = linspace(5 ,11 ,200);
% rescales the images to incease speed .
sc = 0.25;
% Compute normalized corss correlations for all the depths
[ncc , outside_image ] = compute_ncc(d,im2 ,K*P{2} , im1 , segm_kronan1 ,K*P{1} ,3 , sc );
% Select the best depth for each pixel
[maxval , maxpos ] = max(ncc ,[] ,3);
% Print the result
disp_result(im2 ,K*P{2} , segm_kronan2 ,d( maxpos ) ,0.25 , sc)
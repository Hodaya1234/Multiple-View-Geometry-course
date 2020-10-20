A=imread('a.jpg');
B=imread('b.jpg');
%%
[fA dA] = vl_sift(single(rgb2gray(A)));
[fB dB] = vl_sift(single(rgb2gray(B)));
matches = vl_ubcmatch(dA ,dB);
xA = fA(1:2, matches (1 ,:));
xB = fB(1:2, matches (2 ,:));
%%
n=size(xA,2);
x1=[xA; ones(1,n)];
x2=[xB; ones(1,n)];
%%
[H, agreement]=ransac_h(x1,x2);
H=H./H(3,3);
round(H,4)
%%
tform = maketform ('projective',H');
% Creates a transfomation that matlab can use for images
% Note : imtransform uses the transposed homography
transfbounds = findbounds (tform ,[1 1; size(A,2) size(A,1)]);
% Finds the bounds of the transformed image
xdata = [min([ transfbounds(: ,1); 1]) max([ transfbounds(: ,1); size(B ,2)])];
ydata = [min([ transfbounds(: ,2); 1]) max([ transfbounds(: ,2); size(B ,1)])];
% Computes bounds of a new image such that both the old ones will fit.
[ newA ] = imtransform(A,tform ,'xdata',xdata ,'ydata',ydata );
% Transform the image using bestH
tform2 = maketform ('projective',eye(3));
[ newB ] = imtransform(B,tform2 ,'xdata',xdata ,'ydata',ydata ,'size',size(newA));
% Creates a larger version of B
newAB = newB ;
newAB( newB < newA ) = newA( newB < newA );
% Writes both images in the new image . %(A somewhat hacky solution is needed
% since pixels outside the valid image area are not allways zero ...)
%%
imshow(newAB)
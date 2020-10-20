im1 = imread('cube1.JPG');
im2 = imread('cube2.JPG');
[f1 d1] = vl_sift(single(rgb2gray(im1)), 'PeakThresh', 1);
[f2 d2] = vl_sift(single(rgb2gray(im2)), 'PeakThresh', 1);
% vl_plotframe(f1);
% vl_plotframe(f2);
%%
[matches, scores] = vl_ubcmatch(d1,d2);
x1 = [f1(1,matches(1,:)); f1(2,matches(1 ,:))];
x2 = [f2(1,matches(2,:)); f2(2,matches(2 ,:))];
%%
n=(size(matches ,2));
perm = randperm(n);
figure;
imagesc ([ im1 im2 ]);
hold on;
plot([ x1(1, perm (1:10)); x2(1, perm (1:10))+ size(im1 ,2)] , ...
[x1(2, perm (1:10)); x2(2, perm (1:10))] , '-');
hold off;
%%
load('P_matrices.mat');
%%
X=zeros(4,n);
for i=1:n
    M=zeros(6,6);
    M(1:3,1:4)=Ps{1};
    M(4:6,1:4)=Ps{2};
    M(1:2,5)=x1(:,i);
    M(3,5)=1;
    M(4:5,6)=x2(:,i);
    M(6,6) = 1;
    [U,S,V]=svd(M);
    v=V(:,end);
    X(:,i) = pflat(v(1:4,:));
end
xproj1 = pflat(Ps{1}*X);
xproj2 = pflat(Ps{2}*X);
%%
good_points = (sqrt(sum((x1 - xproj1(1:2,:)).^2)) < 3 & ...
sqrt(sum((x2 - xproj2(1:2 ,:)).^2)) < 3);
xproj1 = xproj1(:,good_points);
xproj2 = xproj2(:,good_points);
%%
[~,idx] = sort(xproj1(1,:));
xproj1 = xproj1(:,idx);
xproj2 = xproj2(:,idx);
%%
c = linspace(1,length(idx)/64,length(idx));
subplot(1,2,1)
image(im1)
hold on
scatter(xproj1(1,:),xproj1(2,:),[],c,'.')
colormap('jet')
subplot(1,2,2)
image(im2)
hold on
scatter(xproj2(1,:),xproj2(2,:),[],c,'.')
colormap('jet')
%%
[K1, ~] = qr(Ps{1});
[K2, ~] = qr(Ps{2});
% K1 = K1./K1(3,3);
% K2 = K2./K2(3,3);
%%
good_3d = pflat(X(:,good_points));
figure;
scatter3(good_3d(1,:),good_3d(2,:),good_3d(3,:),[],c,'.')
hold on
plot3 ([ Xmodel(1, startind ); Xmodel(1, endind )] ,...
[ Xmodel(2, startind ); Xmodel(2, endind )] ,...
[ Xmodel(3, startind ); Xmodel(3, endind )], 'b-');
for i =1:2
   center=pflat(null(Ps{i}));
   paxis = pflat(Ps{i}(3,1:3));
   quiver3(center(1),center(2),center(3), paxis(1),paxis(2),paxis(3),5)
end
axis equal
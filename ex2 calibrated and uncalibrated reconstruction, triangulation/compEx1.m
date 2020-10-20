load compEx1data.mat
figure(1)
scatter3(X(1 ,:) ,X(2 ,:) ,X(3 ,:) , '.');
hold on
plotcams(P);
axis equal
%%
p1 = P{1};
x1 = x{1};
im1 = imread(imfiles{1});
proj_x1 = pflat(p1*X);
figure(2)
image(im1);
hold on
scatter(x1(1,:),x1(2,:),'r')
scatter(proj_x1(1,:),proj_x1(2,:),'.','b')
legend({'Given Points','Projected Points'})
axis equal
%%
T1 = [1,0,0,0; 0,4,0,0; 0,0,1,0;0.1,0.1,0,1];
T2 = [1,0,0,0; 0,1,0,0; 0,0,1,0; 1/16,1/16,0,1];
new_X_t1 = pflat(T1*X);
new_X_t2 = pflat(T2*X);
new_P_t1 = cell([1,length(P)]);
new_P_t2 = cell([1,length(P)]);
for i = 1:length(P)
    new_P_t1(i) = {P{i}*inv(T1)};
    new_P_t2(i) = {P{i}*inv(T2)};
end
%%
figure(3)
subplot(1,2,1)
scatter3(new_X_t1(1 ,:) ,new_X_t1(2 ,:) ,new_X_t1(3 ,:) , '.');
hold on
plotcams(new_P_t1);
axis equal
subplot(1,2,2)
scatter3(new_X_t2(1 ,:) ,new_X_t2(2 ,:) ,new_X_t2(3 ,:) , '.');
hold on
plotcams(new_P_t2);
axis equal
%%
im1 = imread(imfiles{1});
x1 = x{1};
projected1 = pflat(new_P_t1{1}*new_X_t1);
projected2 = pflat(new_P_t2{1}*new_X_t2);
figure(4)
image(im1);
hold on
scatter(x1(1,:),x1(2,:),'.','r')
scatter(projected1(1,:),projected1(2,:),'>','b')
scatter(projected2(1,:),projected2(2,:),'<','g')
axis equal
%%
K=[1000,0,500;0,1000,500;0,0,1];
P=[1000, -250, 250*sqrt(3), 500; 0, 500*(sqrt(3)-0.5), 500*(1+sqrt(3)/2),500; 0, -0.5, sqrt(3)/2, 1];
norm_k=K\P;
%%
i=1;
original_P=P{i};
P1=original_P/T1;
P2=original_P/T2;
[K,Rt]=rq(original_P);
% K = K./K(3,3);
[K1,Rt1]=rq(P1);
% K1 = K1./K1(3,3);
[K2,Rt2]=rq(P2);
% K2 = K2./K2(3,3);

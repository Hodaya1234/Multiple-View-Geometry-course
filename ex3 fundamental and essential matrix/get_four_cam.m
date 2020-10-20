function [ cams ] = get_four_cam( E,U,V )
%GET_FOUR_CAM Summary of this function goes here
%   Detailed explanation goes here
cams = cell(1,4);

W=[0,-1,0;1,0,0;0,0,1];
u3=U(:,3);
cams{1}=[U*W*V', u3];
cams{2}=[U*W*V', -u3];
cams{3}=[U*W'*V', u3];
cams{4}=[U*W'*V', -u3];

end


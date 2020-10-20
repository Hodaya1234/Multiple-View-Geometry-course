function [ center, normal ] = find_center_axis( P )
%FIND_CENTER_AXIS Summary of this function goes here
%   Detailed explanation goes here

normal=P(3,1:3);
center = pflat(null(P));
end


function [imageOut] = imageNorm(imageIn)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

imageIn=double(imageIn); %read image in

imageOut=imageIn/255.0 -.5; %divide all values by 255 and subtract .5 
end

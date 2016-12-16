function [imageOut] = ReLU(imageIn)

imageIn=double(imageIn); %read in image
[M,N,D]=size(imageIn); %find size of image

imageIn(imageIn<0)=0; %finds negative values and sets them to 0
imageOut=imageIn; %sets output image to be input image with 0 for negative
end

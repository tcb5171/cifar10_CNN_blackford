function [imageOut] = fullConnect(imageIn) %need layer passed also
layer=17; %hardcoded since fullConnect is going to always be the 17th layer for us
imageIn=double(imageIn); %read in image
[M,N,D]=size(imageIn); %find size of image
load('CNNparameters.mat'); %load in parameters 
imageTemp=ones(4,4,10,10);

filter=filterbanks{1,layer}; %pull out filters from the filter bank depending on what layer we are in (passed to function)
bias=biasvectors{1,layer}; %pull out biases also
[q,w,e,r]=size(filter); %to find length of D2

for D2=1:r
     imageTemp(:,:,:,D2)=imageIn(:,:,:).*(filter(:,:,:,D2));
     imageOut(1,1,D2)=sum(sum(sum(imageTemp(:,:,:,D2),1),2),3)+bias(D2);
end

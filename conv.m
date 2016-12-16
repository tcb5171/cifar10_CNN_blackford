function [imageOut] = conv(imageIn,layer) %need layer passed also

[M,N,D]=size(imageIn); %find size of image
imageIn=padarray(imageIn,[1 1]); %pad array with 1 row of zeros all the way around
load('CNNparameters.mat'); %load in parameters 

filter=filterbanks{1,layer}; %pull out filters from the filter bank depending on what layer we are in (passed to function)
bias=biasvectors{1,layer}; %pull out biases also
[~,~,~,r]=size(filter); %to find length of D2

%% this is the problem
% for D2=1:r
%     imageTemp(:,:,:,D2)=imfilter(imageIn,filter(:,:,:,D2),'conv','same'); %gets temp image from convolution of image and filter
% end

for D2=1:r
      imageTemp(:,:,D2)=conv2(imageIn(:,:,1),filter(:,:,1,D2),'same')+conv2(imageIn(:,:,2),filter(:,:,2,D2),'same')+conv2(imageIn(:,:,3),filter(:,:,3,D2),'same')+conv2(imageIn(:,:,4),filter(:,:,4,D2),'same')+conv2(imageIn(:,:,5),filter(:,:,5,D2),'same')+conv2(imageIn(:,:,6),filter(:,:,6,D2),'same')+conv2(imageIn(:,:,7),filter(:,:,7,D2),'same')+conv2(imageIn(:,:,8),filter(:,:,8,D2),'same')+conv2(imageIn(:,:,9),filter(:,:,9,D2),'same')+conv2(imageIn(:,:,10),filter(:,:,10,D2),'same')+bias(D2);
end         


imageOut=imageTemp((2:M+1),(2:N+1),:,:); %remove zero padded numbers

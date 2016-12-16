function [imageOut] = softMax(imageIn)


imageIn=double(imageIn); %read in image
[M,N,D]=size(imageIn); %find the size of the image
neum=double(zeros(M,N,D)); %creat new output image of zeros for faster processing
imageOut=double(zeros(M,N,D)); %creat new output image of zeros for faster processing

a=max(imageIn); %finds the max value of the image for the opperator

% we could hardwire this to be 1x1x10 but leave it open incase we deal with
% other vaireties in the future : imageOut=(exp(imageIn)-a)

for i=1:M
    for j=1:N
        for k=1:D
            neum(i,j,k)=exp(imageIn(i,j,k)-a); %does the neumerator opperation 
        end
    end
end

denom=sum(neum(i,j,:)); %finds the sum of all the values of neum for the denominator
imageOut=neum./denom; %divides the neumerator of fuction by denominator


end

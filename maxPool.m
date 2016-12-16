function [imageOut] = maxPool(imageIn)

imageIn=double(imageIn); %read in image
[M,N,D]=size(imageIn); %find size of image
imageOut=double(zeros(M/2,N/2,D)); %create output image of zeros for faster processing

%iterate through values at a 2 step in order to process on a 2x2 square at
%a time
for i=1:2:M
    for j=1:2:N
        for k=1:D
            imageOut((i+1)/2,(j+1)/2,k)=max(imageIn(i,j,k),imageIn(i+1,j,k)); %finds the max value of the top two values in the block
            imageOut((i+1)/2,(j+1)/2,k)=max(imageOut((i+1)/2,(j+1)/2,k),imageIn(i,j+1,k)); %checks the previous maximum value aginst the bottom left value
            imageOut((i+1)/2,(j+1)/2,k)=max(imageOut((i+1)/2,(j+1)/2,k),imageIn(i+1,j+1,k)); %checks the previous maximum value aginst the bottom right value
        end %this leaves us with the maximum value of that 2x2 block
    end %store values at ((i+1)/2,(j+1)/2,k) which decrease spatial resolution and stores correctly
end

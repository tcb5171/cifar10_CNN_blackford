clear all;clc;close all

%loading this file defines imageset, trueclass, and classlabels
load('cifar10testdata.mat')
%loading this file defines filterbanks and biasvectors
load('CNNparameters.mat')
%loading this file defines imrgb and layerResults
load('debuggingTest.mat')
zActual=zeros(1,10000);
zProb=zeros(1,10000);
zRecog=zeros(1,10000);

imageRun = 10; % this is the number of images you want to test the calssifier on

for i=1:imageRun
    imageIn=imageset(:,:,:,i);


im1=imageNorm(imageIn);
im2=conv1(im1,2);
im3=ReLU(im2);
im4=conv(im3,4);
im5=ReLU(im4); 
im6=maxPool(im5);
im7=conv(im6,7);
im8=ReLU(im7); 
im9=conv(im8,9);
im10=ReLU(im9);
im11=maxPool(im10);
im12=conv(im11,12);
im13=ReLU(im12);
im14=conv(im13,14);
im15=ReLU(im14);
im16=maxPool(im15);
im17=fullConnect(im16);
im18=softMax(im17);

%create a test output matrix to test against the debuggingTest.mat
tester={im1,im2,im3,im4,im5,im6,im7,im8,im9,im10,im11,im12,im13,im14,im15,im16,im17,im18};

%find most probable class
    classprobvec = squeeze(im18);
    [maxprob,maxclass] = max(classprobvec);
%note, classlabels is defined in ’cifar10testdata.mat’
    fprintf('estimated class is %s with probability %.4f\n',...;
    classlabels{maxclass},maxprob);

    i %just to see how far along you are
    
zActual(i)=trueclass(i); %finds actual class label for test images
zRecog(i)=maxclass; %find predicted class label for test image
zProb(i)=maxprob; %finds how sure the cnn is 
end

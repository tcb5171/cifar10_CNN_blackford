# cifar10_CNN_blackford
EE 454 Project 1: Convolutional Neural Networks 














CMPEN/EE 454 Project 1
Convolutional Neural Networks


Team:
Taylor Blackford






















Overview:
The project introduced us to Convolutional Neural Networks and their use in object recognition. A long chain of simple operations leads to truly revolutionary results. We worked on creating those simple functions for the different layers of the CNN in Matlab. We made functions for Normalization, Convolution, Rectified Linear Unit, Maxpool, Full Connect, and Softmax. From a 32x32x3 image of an airplane, we get a 1x1x10 array with probabilities for each of the 10 categories for the image classification. Below you can see our test image on the left, and the output probabilities on the right. We successfully recognized the airplane as an airplane with 52.52303% certainty. We then ran all 10,000 images through the CNN to study its correctness. 












Procedure:
The first thing to do in every program is to import any preliminary files such as our “cifar10testdata.mat” and “CNNparameters.mat” and “debuggingTest.mat”. This will give us all of the core data we will need which we can wrap our code around to get the functionality we need. Below is a list of all the things stored in those files.
Biasvectors is a 1x18 cell in which each cell corresponds to the num biases of each layer. These biases are only used in convolve and full connect layers. Each has 10 numbers in the active cells.
Classlabels is a 1x10 cell which has the label for each class for which a picture can be classified. They ten classes are: airplane, automobile, bird, cat, deer, dog, frog, horse, ship, and truck.
Filberbanks is a 1x18 cell which has arrays of the filter banks that are used in the convolution and full connect layers. 
Imageset is a 4D array that includes all the images from the 60,000 image bank. There are 50,000 training images and 10,000 test images
Imrgb is a 32x32x3 test image to make sure the code is working correctly. It is a airplane in unit8.
layerResults is a 1x18 cell of what each layer should output. We can use this to help debug our program at each layer.
Trueclass is a 1x10000 array of what each test picture should be classified as. We can use this later to test how accurate the our CNN is.

We read in the test image using imread for which we will use the CNN to categorize. Later we can customize this to read in sets of images when we test the full CIFAR-10 dataset.

norm.m
The first function we use is the normalization function. Since the image comes in as a unit8, we know that the greyscale ranges from 0 to 255. So in order to normalize the image we divide each pixel color value by 255 to make all values range from 0 to 1. We then subtract by .5 so the mean of the image is 0, ranging from -.5 to .5. There was no need to use loops since we could do the entire function at once. This function is only implemented in the first layer of the CNN.


conv.m (conv1.m)
The second function used is convolution function. Instead of the traditional 1D or 2D convolution, we use multidimensional convolution of our image. The filters we use to filter the image are stored in the filterbank we are given in the CNNparameters.m file.  After we convolve the images we also need to add on a bias value which is also found in the CNNparameters.m file. The filters are going to be D1 layers deep, which matches the depth of the input image. There are going to be D2 of these filters, and just as many bias values. D2 will also be the depth of the output image channels which has the same NxM dimensions. 

NOTICE: My code for this block would not work correctly moving from the first to the second convolution block so I had to hardwire in the summing component of the function into two different parts. The first one is just for the first convolution function which has to sum three convolutions. The second set is for the next five convolutions which require summing ten convolutions each. The code works correctly but could should be able to combine into one function in the future.
ReLU.m
The third function used is the Rectified Linear Output function. The only thing this function does is sets the negative values of the function to 0. This function was very easy to implement. Instead of going pixel by pixel and taking the max of that pixel and zero, we found all values in the input image that were less than 0 (negative) in the image and set them to 0. This turns multiple lines of code into one. The transform graph can be seen below. You cannot see the difference in the image since matlab does not display pixel values less than 0, but you can see it in the array values. 
 












maxPool.m
The fourth function we use is Maxpools. The goal of this function is to decrease the spatial resolution of the image by half in the first two dimensions. The main computation is to find the the maximum pixel value in a block of four pixels. Since we cannot use the max operator on all four at once, we have to check the top 2 pixels and see which one is larger. We then take the result from that and check it from the bottom left pixel. Lastly we check the results from that with the bottom right pixel which finally gives us the largest value from that block of four. We store this new value into our output array. We then take double step over in order to make sure we do not overlap. Using those indexers we have to store the new values in i+1/2 to get the correct location in the output array. From these results we get a new array with half the spatial resolution as the input array. 

One interesting thing I found is that maxpool only works well after normalizing the image. If you try and maxpool the input image the output is full white, because when you take the maximum of a regular image most of those number will be close to 255. Once we normalize the image all the values get a lot closer.

Before MaxPool
After MaxPool


fullConnect.m
The fifth function is fullconnect, which take a matched filter size to image size. They do not need to be convolved, just multiplied together using scalar multiplication. This leads leads to an output image of 1x1xX after the summing is done. The number of filters gives us the depth of the output layers which in our case is 10.




softMax.m
The last function we use is softmax. Softmax turns the values from the previous array into probabilities which run from 0 to 1 and sum to 1. It is computed as seen below. We can now get actual values for the probabilities that our test image belongs to each class. For the code we just iterate through all the values of the input image and calculate the numerator of the function first. Then we can use the sum of the numerator values to find the value of the denominator so we can divide all values and be left with the correct probabilities. 




Together using the above 6 functions over 18 layers we have created a fully connected neural network that takes a 32x32x3 image and give us 10 probabilities based on predefined classes. Below you can see the full layers of the network. 


Observations:
In the beginning all of the code was running on nested for loops and took forever to run. It actually had clocked over 15 minutes and we knew something had to change. We looked back and realized most of the functions could do the process all at once and so we ditched most of the for loops for vectorized processes. This got the run time to less than a second for our test image. 

Below are the outputs of each of our layers of the CNN. The output of the first layer in the normalized image which can still be displayed at full size. The next output is a 32x32x10 array from the first convolution block. Instead of viewing it as a 3D array, it is easier to display as 10 32x32 images. This will continue until the output of block 16. 

One thing you can see is that most of the middle blocks look quite alike up close. The output of blocks 2 and 3, 4 and 5, 7 and 8, 9 and 10, 12 and 13, and 14 and 15 all look exactly the same when viewed as grayscale images because Matlab does not display negative values in images, so the ReLU function makes no change visually. But all negative values become zeros when viewed in array form.

Another minute detail that is hard to see in icon images is the changing spatial resolution. From blocks 6 to 7, 11 to 12, and 15 to 16, the spatial resolution decrease by 2 and only the maximum values survive. This is only visibly evident in the 15 to 16 outputs as the image becomes very blurry and brighter in the white regions. When viewing the icons at full size it is very evident as the pixels of the image seem to get larger, meaning there is less spatial information contained in them, 

Using fullConnect, we convert the outputs of stage 16 from an image to a single values. The values range from positives to negative. softMax takes those and converts them into percentages of the total possibilities. Negative values in stage 17 lead to lower percentages, while positive values are given a much larger share. These final percentages are then easily interpreted as how likely it is to classify the image in each class.













Output of Stage 1: Normalize
Output of Stage 2
Output of Stage 3
Output of Stage 4
Output of Stage 5
Output of Stage 6
Output of Stage 7
Output of Stage 8
Output of Stage 9
Output of Stage 10
Output of Stage 11
Output of Stage 12
Output of Stage 13
Output of Stage 14
Output of Stage 15
Output of Stage 16
Output of Stage 17: Full Connect










Output of Stage 18: Class Probabilities

Performance Evaluation: 
Now that we know the code is working correctly and somewhat efficiently, we can now classify all 10,000 images in the CIFAR-10 image set. Below is a small snippet of what the image set looks like. There are 10 classes, each with 1,000 images. A simple loop ran through all the images, and output the true image class, recognized image class, and percent confidence in the recognition into an array. More detailed values can be found in the appendix.


Confusion Matrix
From the array we can then go through and build out confusion matrix. The confusion matrix finds all the times that a certain class is classified both correctly and incorrectly. A simple matlab statement with relational operators and a length statement finds the number of times class 1 is classified as class 1, 2,3... and so on. This 10x10 matrix can show how the CNN can get confused between certain classes. The diagonal is where the CNN has correctly guessed the image class. I also made an array of Zscore for all the values, but it looks exactly like the data due to the Law of Large Number so I have decided not to include it. 
Classification Rate
The classification rate is the accuracy to which the CNN classifies each class correctly. It is calculated by taking the total number of times a class is correctly recognized divided by the total number of times that class is incorrectly recognized and something is wrongly recognized as that class. For instance you take all the times airplane was classified as airplane, divided by all the time an airplane was wrongly classified and all the time something was wrongly classified as an airplane. You can see the results below in the bar graph. From this we can see automobile is classified most accurately; while cat, deer, and dog are the most mistaken. This could be do to the like nature of the animals features. 


Top-K Classification Plot
The top-k classification plot is somewhat of a integration of the accuracy. It took a little bit of matrix manipulation, but it was easy to calculate from the confusion matrix. From it you can see if an object is mistaken often for something else, which would result in a steeper growth from k=1 to k=2. The k=1 value is the accuracy we calculated earlier. 

Test Images:
I pulled a couple images off the internet to test the CNN. The first is a 1968 mustang fastback, which I hope is categorized as a car. The second is a beach ball, as I would like to see what it get classified as. The last picture is me so we can see what the CNN thinks I belong as. 










We found that it worked great for the car, being 62.47% confident that it was a car. For the beach ball it a toss up between a truck and automobile. But the one thing it did was rule out the bird, cat, deer, dog, frog, and horse. It knew that it wasn't an animal but could place it in the other categories.The CNN thought I was a mix between a bird, dog, and cat, but hey at least it didn't think I was a automobile, ship or truck. 

To deal with images that are not pre-classified in one of the ten classes we will need to look at the output probabilities. The average certainty was 44.25% over the 10,000 test images.
We should assume that if the image cannot be classified that all ten classes should have an equal probability. We believe that if the maximum probability is not at least twice as much as the second largest value found in the classes. This guarantees that there is a lack of certainty by the CNN in its decision. 

Work Split:
At the time I turn this in I have done all of the work. I wrote all the code and the entire report.

Code:
The code is attached. Run  ee454_project1.m to actually run the CNN. This actually tests all 10,000 images but I have commented out the loop so it doesn't run the whole amount of times. To run the statistics on the output arrays use the analysisFile.m to find the statistics. 





















Appendix:

Confusion Matrix: 



Classification Rate:



Top-K table:





Top-K Graph










































Classification Accuracy


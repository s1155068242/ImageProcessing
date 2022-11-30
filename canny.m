function [c] = canny(I,thresholdhigh,thresholdlow)
%gaussian filtering
I = rgb2gray(I);
Itemp=im2double(I);
h = fspecial('gaussian',5, 1);
GFI = imfilter(Itemp, h, 'replicate');
%Sobel and Prewitt Operators to 
%move horizontial direction
SobelXedge=[-1 0 1;-2 0 2;-1 0 1];
%move verticall direction
SobelYedge=[-1 -2 -1;0 0 0; 1 2 1]; 
[x,y] = size(GFI);
V = reshape(SobelXedge,3,3);
Y = reshape(SobelYedge,3,3);
B = reshape(GFI,x,y);
%'valid' — Return only parts of the convolution that are computed without zero-padded edges.
%Since we need to reject the boundary line at the edge of picture
Gx = conv2(B,V,'valid');
Gy = conv2(B,Y,'valid');
%Magnitude of gradients
%gradients vector angle
%call function angle to find the edge direction
[Inten_grad,edgeangle] =  find_grad_and_angle(Gx,Gy);
subplot(1,5,2);
imshow(Inten_grad);
[temp] = nonmaxsup(Inten_grad,edgeangle);

[image] = checkthreshold(temp,thresholdhigh,thresholdlow);
c =image;
subplot(1,5,4);
imshow(c);
subplot(1,5,3);

end










# Image Processing
I = imread('C:\Users\s1155068242\Desktop\1.png');
subplot(1,5,1);
imshow(I);
canny(I,0.3*255,0.2*255);

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
 
%%angle function%%
function [Inten_grad,edgeangle] =  find_grad_and_angle(Gx,Gy)
[x,y] = size(Gx);
realangle = zeros([x y]);
 
Inten_grad = (Gx.^2+Gy.^2).^0.5;
 
%calculate the gradient angle
for i=1:x
      for j=1:y
            if(Gx(i,j)==0)
              realangle(i,j)= 90 ;
            else
                realangle(i,j)= atan(Gy(i,j)/Gx(i,j))*(180/3.14);
            end
      end
end
%calculate the edge angle
  edgeangle = zeros([x y]);
 for i=1:x
      for j=1:y
         if(realangle(i,j)>= 0)
                  edgeangle(i,j)=abs(realangle(i,j));
            elseif (realangle(i,j) < 0)
               edgeangle(i,j)= realangle(i,j)-90;
 
         end
     end
 end 
end


%%nonmaxsup%%

function [temp] = nonmaxsup(GFI,edgeangle)
%Adding  0 on the boundary for comparison
GFI = padarray(GFI, [1 1],0,'both');
 [x,y] = size(edgeangle);
 
 for i=2:x-1
    for j=2:y-1
           if (112.5<edgeangle(i,j))&&(edgeangle(i,j)<157.5)
                 if ((GFI(i-1,j+1)>GFI(i,j))||(GFI(i+1,j-1)>GFI(i,j)))
                      GFI(i,j)=0;
                  end
           elseif (22.5<edgeangle(i,j))&&(edgeangle(i,j)<67.5)   
                  if ((GFI(i+1,j+1)>GFI(i,j))||(GFI(i-1,j-1)>GFI(i,j)))
                       GFI(i,j)=0;
                  end
           elseif (67.5<edgeangle(i,j))&&(edgeangle(i,j)<112.5)   
                  if ((GFI(i,j+1)>GFI(i,j))||(GFI(i,j-1)>GFI(i,j)))
                      GFI(i,j)=0;
                  end
           elseif ((0<edgeangle(i,j))&&(edgeangle(i,j)<22.5))||((157.5<edgeangle(i,j))&&(edgeangle(i,j)<181))   
                  if ((GFI(i+1,j)>GFI(i,j))||(GFI(i-1,j)>GFI(i,j)))
                     GFI(i,j)=0;
                  end
           end
    end
 end
 
 temp = GFI;
 
end
 
%%checkthreshold%%

function [image] =  checkthreshold(temp,thresholdhigh,thresholdlow)
 
temp1 = im2uint8(temp);
[a,b]=size(temp1);
for x = 1:a
    for y = 1:b
        if(temp1(x,y)<thresholdlow)
         temp1(x,y) = 0;
          elseif(temp1(x,y)>= thresholdhigh)
            temp1(x,y) = 255;
          elseif(temp1(x,y)< thresholdhigh) && (temp1(x,y)>= thresholdlow)
              if( temp1(x+1,y)>thresholdhigh || temp1(x-1,y)>thresholdhigh || temp1(x,y+1)>thresholdhigh || temp1(x,y-1)>thresholdhigh || temp1(x-1,y-1)>thresholdhigh || temp1(x-1,y+1)>thresholdhigh || temp1(x+1,y-1)>thresholdhigh|| temp1(x+1,y+1)>thresholdhigh )
             temp1(x,y) = 255;
              else
                  temp1(x,y) = 0 ;
              end
        end       
    end
end    
   
image = temp1;
 
end







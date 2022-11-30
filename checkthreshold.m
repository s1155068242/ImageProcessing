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

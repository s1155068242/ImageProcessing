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


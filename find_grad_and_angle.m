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

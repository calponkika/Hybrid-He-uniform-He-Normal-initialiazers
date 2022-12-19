 function [Opt_Vect] =Optimal_WB(b1u,b1z,IWu,IWz,LWu,LWz,b2u,b2z,imax,jmax,kmax,lmax)  %%it will select the optimal based on 8 componentent ,enter layrs, 

% b1u=[3; 4];
% b1z=[5; 8];
% IWu=[9 10 11;12 13 17];
% IWz=[12 13 14;21 31 41];
% LWu=[20 30; 40 50];
% LWz=[15 25 ;35 45];
% b2u=[30 ;40];
% b2z=[50; 80];
% imax=1;
% jmax=2;
% kmax=1;
% lmax=2;

if imax==1  
    V1=b1u';
else  %% This is the same as imax==2
    V1=b1z';
end
if jmax==1
    V2=reshape(IWu,1,[]);
else
    V2=reshape(IWz,1,[]); %%Birasaba kurambura matrix muri vector
end
if kmax==1
    V3=reshape(LWu,1,[]);
else
    V3=reshape(LWz,1,[]); %%Birasaba kurambura matrix muri vector
end

if lmax==1
    V4=b2u';
else 
    V4=b2z';
end
% end
% end
% end
Opt_Vect=[V1 V2 V3 V4]; %%Transpose kuko zari veritical, ,V2 na V3 zabaye reshape  kuri one row
  save Opt_Vect   
 end
  

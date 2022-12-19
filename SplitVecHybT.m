function [Opt_Acc_WB] =SplitVecHybT(Wb_un,Wb_Z, X,Y)  %%Calcul

OptVec=SplitFunc(Wb_un,Wb_Z, X,Y);
% WbS=OptVectTRe{3};
OptVectT=OptVec{9};
Opt_Acc=OptVec{10};
MaxOk2=OptVec{11};
[b1,b1n,IW1,IW1n, LW1, LW1n,b2, b2n]=deal(OptVec{1},OptVec{2},OptVec{3},OptVec{4},OptVec{5},OptVec{6},OptVec{7},OptVec{8});
[imax,jmax,kmax,lmax]=deal(OptVectT(1),OptVectT(2),OptVectT(3),OptVectT(4)); %%deal may be used to assign multiple values , other wise , = sign can nor be applies//Unfolding in matlab
% % =============================================
% %  decude the results of normalized and not normalised
Uniform_DistT=Opt_Acc(1,1,1,1);
Gaussian_DistT =Opt_Acc(2,2,2,2);

 fprintf('The Value 1== Not Normalized, 2==Normalised, b1=input bias,IW=inputs weights,LW=layer Weights, b2=Output bias]\n')
 fprintf('------------------------------------------------------------------\n')
 
  fprintf('The Accuracy of  traditional Uniform distribution  is [%3.2f%%] \n',Uniform_DistT)
  fprintf('The Accuracy of traditional Gaussian  distribution  is [%3.2f%%] \n',Gaussian_DistT)
%   fprintf('The Accuracy by using backpropagation  is [%3.2f%%] \n',BackPropagation);
  fprintf('The Accuracy resulted from Hybrid of traditional Methods is [%3.2f%%] \n',MaxOk2);
   fprintf('The idx of max value is at [b1=%2d,IW=%d,LW=%d,b2=%d]\n',imax,jmax,kmax,lmax);
  %%Print the optimal weights vector 
  OptWBTrad=Optimal_WB(b1,b1n,IW1,IW1n, LW1, LW1n,b2, b2n,imax,jmax,kmax,lmax);
  Opt_Acc_WB={OptWBTrad Opt_Acc};
 %%NetOpt= How to get optimal neural net
  save OptWB
end 


    

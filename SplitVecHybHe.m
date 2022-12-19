function [Opt_Acc_WB] =SplitVecHybHe(Wb_unHe,Wb_ZHe, X,Y)  %%Calcul
OptVec=SplitFunc(Wb_unHe,Wb_ZHe, X,Y);
OptVectT=OptVec{9};
Opt_Acc=OptVec{10};
MaxOk2=OptVec{11};
[b1,b1n,IW1,IW1n, LW1, LW1n,b2, b2n]=deal(OptVec{1},OptVec{2},OptVec{3},OptVec{4},OptVec{5},OptVec{6},OptVec{7},OptVec{8});

[imax,jmax,kmax,lmax]=deal(OptVectT(1),OptVectT(2),OptVectT(3),OptVectT(4)); %%deal may be used to assign multiple values , other wise , = sign can nor be applies//Unfolding in matlab

% % =============================================
% %  decude the results of normalized and not normalised
Uniform_DistHe=Opt_Acc(1,1,1,1);
Gaussian_DistHe =Opt_Acc(2,2,2,2);
%%==By using BackPropagation)
% T= Targets;
BackPropagation=NNW_Alg(X,Y);

% %  VECTOR YABAYE SELECTED TWAYIFATA GUTE 
  fprintf('The Accuracy of Uniform He et al.initializer is [%3.2f%%] \n',Uniform_DistHe)
  fprintf('The Accuracy of Gaussian  He et al. initializer is [%3.2f%%] \n',Gaussian_DistHe)
  fprintf('The Accuracy by using backpropagation  is [%3.2f%%] \n',BackPropagation);
  fprintf('The Accuracy resulted from Hybrid of two He et al. initializer is [%3.2f%%] \n',MaxOk2);
  % %  fprintf('The results from resulted from [%d%d%d%d] \n', i1,i2,i3,i4)
 fprintf('The idx of max value is at [ b1=%2d,IW=%d,LW=%d,b2=%d]\n',imax,jmax,kmax,lmax)
 fprintf('Whereby  Value 1== Not Normalized, 2==Normalised, b1=input bias,IW=inputs weights,LW=layer Weights, b2=Output bias]\n')
 fprintf('------------------------------------------------------------------\n')
  Opt_WBHe=Optimal_WB(b1,b1n,IW1,IW1n, LW1, LW1n,b2, b2n,imax,jmax,kmax,lmax);
  Opt_Acc_WB={Opt_WBHe Opt_Acc};
  save Opt_WBHe

end


    

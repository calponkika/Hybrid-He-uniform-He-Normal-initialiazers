function [Opt_Acc_WB] =SplitVecHybGlorotX(Wb_unGlX,Wb_ZGlX, X,Y)  %%Calcul

OptVec=SplitFunc(Wb_unGlX,Wb_ZGlX, X,Y);
OptVectT=OptVec{9};
Opt_Acc=OptVec{10};
MaxOk2=OptVec{11};
[b1,b1n,IW1,IW1n, LW1, LW1n,b2, b2n]=deal(OptVec{1},OptVec{2},OptVec{3},OptVec{4},OptVec{5},OptVec{6},OptVec{7},OptVec{8});
[imax,jmax,kmax,lmax]=deal(OptVectT(1),OptVectT(2),OptVectT(3),OptVectT(4));


% % =============================================
% %  decude the results of normalized and not normalised
Uniform_DistGlorotX=Opt_Acc(1,1,1,1);
Gaussian_DistGlorotX =Opt_Acc(2,2,2,2);
%%==By using BackPropagation)
% T= Targets;
BackPropagation=NNW_Alg(X,Y);

  fprintf('The Accuracy of Glorot Uniform initializer is [%3.2f%%] \n',Uniform_DistGlorotX)
  fprintf('The Accuracy of Glorot Normal  initializer is [%3.2f%%] \n',Gaussian_DistGlorotX)
  fprintf('The Accuracy by using backpropagation  is [%3.2f%%] \n',BackPropagation);
  fprintf('The Accuracy resulted from Hybrid of two Glorot,Uniform and Normal, initializers is [%3.2f%%] \n',MaxOk2);
  fprintf('The idx of max value is at [ b1=%2d,IW=%d,LW=%d,b2=%d]\n',imax,jmax,kmax,lmax)
 fprintf('Wherby Glorot,  Value 1== Not Normalized, 2==Normalised, b1=input bias,IW=inputs weights,LW=layer Weights, b2=Output bias]\n')
 fprintf('------------------------------------------------------------------\n')
  Opt_WBGlo=Optimal_WB(b1,b1n,IW1,IW1n, LW1, LW1n,b2, b2n,imax,jmax,kmax,lmax);
  Opt_Acc_WB={Opt_WBGlo Opt_Acc};
  save Opt_WBGlotX

end

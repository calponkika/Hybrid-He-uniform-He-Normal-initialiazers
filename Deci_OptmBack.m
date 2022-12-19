function [Q,IdxFitModel2] =Deci_OptmBack(Acc_Prec_Fpr)
%decison based on 3 metrics 
%%%%%%%%%SPLIT THE ACCURACIES NO Feature selection Acc_0:Initial accuracy
[r,~]=size(Acc_Prec_Fpr);
  Acc_0=Acc_Prec_Fpr(:,1);
  Precision=Acc_Prec_Fpr(:,2);
  FPR=Acc_Prec_Fpr(:,3);
  Q=[Acc_0 Precision FPR];
fprintf('The accuracies are %3.3f%% and %3.3f%% \n',Acc_0(1),Acc_0(2))
fprintf('The precisions are %3.3f%% and %3.3f%%\n', Precision(1), Precision(2))
fprintf('The FPR are %3.3f%% and %3.3f%% \n',FPR(1),FPR(2))
% 
IdxFitModel2=find((Acc_0>Precision));
for t=1:length(IdxFitModel2)
 fprintf('%d |%3.3f%% |%3.3f%% \n',t,Acc_0(IdxFitModel2(t)),Precision(IdxFitModel2(t)))
end
end
function [Q1]=Optmal_Back(~)
%%WB means that we initialize with WB
addpath('C:\Users\CARPE\Documents\JKUAT_ThesisOk\Update_codes_Seminars\2.1 Feature_Selection_IG',...
    'C:\Users\CARPE\Documents\JKUAT_ThesisOk\Update_codes_Seminars\1.1 ZOD-FS_CODES2p5_3p5_bin2_And_VIF',...
    'C:\Users\CARPE\Documents\JKUAT_ThesisOk\Update_Codes\4.GA_Vector')
load Optimal_Feature_Inputs.mat
load InpAcc
% % Kugereanya agaciro ka backpropagation na hybrid
Inp{1}=B{1};
Inp{2}=B{15};
L=length(Inp);
 B=cell(1,L);
for i=1:L;
        K=Inp{i}';
    B{i}=K;
    Acc_Prec_Fpr=zeros(L,3);%%3 represents the number of metrics
end
for j=1:length(B)
    InpSeq=B{j};%inputs sequences 2 for ezperiment by using few nubur of inputs

  T= Targets;
  FitModel=NNW_Alg3Metr(InpSeq',T);
  Acc_Prec_Fpr(j,1:3)=FitModel;
end
Q1=Deci_OptmBack(Acc_Prec_Fpr);
save ModelFinalBackp
end
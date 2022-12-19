function [T]=Optmal_Acc_WB(~)
%%This methods create randomly weights, 
% addpath('C:\Users\CARPE\Documents\JKUAT_ThesisOk\Update_Codes\3.Feature_Selection',...
%     'C:\Users\CARPE\Documents\JKUAT_ThesisOk\Update_Codes\4.GA_Vector')
% load Optimal_Feature_Inputs.mat

addpath('C:\Users\CARPE\Documents\JKUAT_ThesisOk\Update_codes_Seminars\1.1 ZOD-FS_CODES2p5_3p5_bin2_And_VIF',...%% this will help to import optimal sample ,
    'C:\Users\CARPE\Documents\JKUAT_ThesisOk\Update_codes_Seminars\2.1 Feature_Selection_IG')
    load  Acc_IGVIF1  %%You import this help to get Targets 
     load  Optimal_SetOfAll   %%You import this help to get optimal inputs 
%     W=OptSample; 
  Inp= OptFinal_Input';
%  load Optimal_Feature_Inputs.mat
% load InpAcc//kumenya uko wahitamo data uwakoresha uereye kuri selected
%  Inp=B{15};%%39x178888)

fprintf('Wait while the system is compiling the information\n')
%   [Inp,~]=DataMorph_NNW(FeatJoined); %%Sepate into iNputs and Targets
    X=Inp;
    Y=Targets;
   Inputs=X; %%The inputs size is 34 ,,which must be respected 
%    Targets=Y;
    [~,n]=size(X');%%KUBERAKO X ,dukuba 2/3 ,iyo iiri transpose
    [~,O]=size(Y');
    nh=round(2/3*n+O);
    wb_size=n*nh+nh*O+nh+O;
    rng('shuffle');
    Wb=rand(wb_size,1);
    %%========================================    
    %%========================================    
    %%Tradition random initlizer (T) 
    %%Gaussian N(0,1) Normalization 
     WbZT=zscore(Wb);%%Existing (0,1) Tmeans traditional
     %%Uniform distribution r=-1/n,1/n]  by Lecun??check
     a1=-0.05  ;%-1/n;
     b0=0.05 ;%1/n;
     Wb_unT = a1 + (b0-a1).*rand(wb_size,1);
   %%========================================  
   %%========================================    
    %%He initilaizer %%Xavier (Glorot) initialization
     WbZGloX=GlorotXavier(Wb,n,O);%%Normlization N(0,sdt) where std=sqrt(2/(n_in+n_out)
      %%a=r=sqrt(2/(n_in+n_out)==s
       a=-(sqrt(2)*sqrt(6/(n+O))); % Se Relu
       b=sqrt(2)*sqrt(6/(n+O));
       Wb_unGloX = a + (b-a).*rand(wb_size,1);%%Uniform distribution where r=a=b=sqrt(2/(n_in+n_out)
%===========================================================
%%He initilaizer %%He initialization
     WbZHe=Hescale(Wb,n);%%Normlization N(0,sdt) where std=sqrt(2/(n_in)
      %%a=r=sqrt(2/(n_in+n_out)==s
       a=-(sqrt(2)*sqrt(6/(n))); % Se Relu
       b=sqrt(2)*sqrt(6/(n));
      Wb_unHe = a + (b-a).*rand(wb_size,1);%%Uniform distribution where r=a=b=sqrt(2/(n_in+n_out)
%%========================================    
% FitModel2=SplitVecHyb(WbZ,Inputs,Targets);%%OK normaliza random only 
%    FitModel=SplitVecHyb(Wb_un,Inputs,Targets);%%OK Uniform random only 
%  FitModel3M= SpltVecHyb3Met(Wb,Inputs,Targets); %%Dealing with
% data''Partitonal 
   fprintf('\n')
  fprintf('TRADITIONAL UNIFORM AND GAUSSIAN INITIALIZER\n')
  fprintf('=============================================\n')
  FitModelT= SplitVecHybT(Wb_unT,WbZT, Inputs,Targets); %%Display from Traditonal initializer 
  fprintf('=============================================\n')
  fprintf('GLOROT AND XAVIER UNIFORM AND GAUSSIAN INITIALIZER \n')
  fprintf('=============================================\n')
  FitModelGloX= SplitVecHybGlorotX(Wb_unGloX,WbZGloX,Inputs,Targets); %%Display from Glorot initializer
  fprintf('=============================================\n')
  fprintf('He et al. UNIFORM AND GAUSSIAN INITIALIZER \n')
  fprintf('=============================================\n')
   FitModelHe= SplitVecHybHe(Wb_unHe,WbZHe,Inputs,Targets); %%Display from He initializer
  fprintf('=============================================\n')
 T=[FitModelT, FitModelHe, FitModelGloX];
%    FitModel2= SplitVecHyb2(Wb_un,Wb,Inputs,Targets); %random uniform+randomy,,no limit
  save ModelFinal_WB
end

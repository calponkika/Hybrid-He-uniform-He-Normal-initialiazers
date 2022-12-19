
function [Metrics] =SpltVecHyb3Met(Wb, X,Y)  %%Calcul
  [~,nI]=size(X');
%   fprintf('The  numer of selected inputs is %d\n',objP.nI);
[~,nO]=size(Y');
%  fprintf('The number Of ouput if %d\n',objP.nO);
nH=round(((2/3)*nI)+nO);
% % % decremental from 29 row to 34*28 plus the used line one b1
Wb_z=zscore(Wb);
b1=Wb(1:nH);
b1n=Wb_z(1:nH);
Split2=Wb(nH+1:nH+nI*nH);
Split2z=Wb_z(nH+1:nH+nI*nH);
% % % % Split the portion or split2 and then split en matrix of 28 rows,the % column is automated
 IW1=reshape(Split2,nH,[]);
 IW1n=reshape(Split2z,nH,[]);
b2=Wb(nH+nI*nH+1:nH+nI*nH+nO);
b2n=Wb_z(nH+nI*nH+1:nH+nI*nH+nO);
% select the portion of vector that follows B2
Split3=Wb(nH+nI*nH+nO+1:nO+nH+nI*nH+nH*nO);
Split3z=Wb_z(nH+nI*nH+nO+1:nO+nH+nI*nH+nH*nO);
% convert the split portion of column into matrix 
LW1=reshape(Split3,nO,[]);
LW1n=reshape(Split3z,nO,[]);
% Create a Pattern Recognition Network 
net = patternnet(nH);
net=configure(net,X,Y);
     % Create the hybrid
 B1={b1 b1n};
 IW={IW1 IW1n};
 B2={b2 b2n};
 LW={LW1 LW1n};
 
for i1=1:length(B1)
  for i2=1:length(IW)
   for i3=1:length(LW)
    for i4=1:length(B2)
        net.b{1}=B1{i1};
        net.IW{1,1}=IW{i2};
        net.LW{2,1}=LW{i3};
        net.b{2}=B2{i4};
        
  Acc_Size=length(B1)*length(IW)*length(B2)*length(LW);
% Loop a set by iteration to find out the best solution
% there is an error ,IW  used is not normalised
     % Setup Division of Data for Training, Validation, Testing
 net.divideParam.trainRatio = 70/100;
 net.divideParam.valRatio = 15/100;
 net.divideParam.testRatio = 15/100;
 net.performFcn = 'crossentropy';
  net.trainFcn = 'trainscg';
% % Train the Network
 [net,~] = train(net,X,Y );
% % ,'useParallel','yes','useGPU','yes'
%  outputs = net(Y);
% % ,'useParallel','yes','useGPU','yes'
outputs = net(X);
Y_Out=outputs;
%   T= Targets;
[~,cm]=confusion(Y,Y_Out);
% [~,cm]=confusion(T,Y);
 [r,c]=size(cm);
  Wpre =zeros(1,c);
  CsVec=zeros(1,c);
  FP_i=zeros(1,c);
  STR=zeros(1,c);
for i=1:c
Cs=sum(cm(:,i));
prec_i=cm(i,i)/Cs;
Wpre(i)=prec_i;
CsVec(i)=Cs;
CsVec1=sum(CsVec);
PrecisonOk(i1,i2,i3,i4)=mean(Wpre)*100;%%well classified wrt to target value
% % calculate FPR   
Cs=sum(cm(i+1:r,i));
FP_i(i)=sum(Cs);
FP=sum(FP_i);
ST=sum(cm(i,i));
STR(i)=ST;
Tot=sum(STR);
TN=Tot-cm(1,1); %%Because the Q(1,1) represents normal traffic 
FPR(i1,i2,i3,i4)=FP/Tot;
%%Accuracy Calculation  ///Acc=Well Classified wrt to output value
Acc(i1,i2,i3,i4)=(Tot/CsVec1)*100;
end
Metrics=[Acc,PrecisonOk,FPR];

end
 end
 end
end    
end
 


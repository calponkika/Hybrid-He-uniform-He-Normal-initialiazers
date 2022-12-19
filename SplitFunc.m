function [TradUniNorm] =SplitFunc(Wb_un,Wb_Z, X,Y)  %%Calcul
% Zscore yakoze normalaziation ya entire vector , not in partition 
  [~,nI]=size(X');
%   fprintf('The  numer of selected inputs is %d\n',objP.nI);
[~,nO]=size(Y');
%  fprintf('The number Of ouput if %d\n',objP.nO);
nH=round(((2/3)*nI)+nO);
% % % decremental from 29 row to 34*28 plus the used line one b1

% ========== Split vwctor for He initialization 
% ================================================
b1=Wb_un(1:nH);
% b1n=MinMaxScaling(b1);
b1n=Wb_Z(1:nH);
Split2=Wb_un(nH+1:nH+nI*nH);
% % % % Split the portion or split2 and then split en matrix of 28 rows,the % column is automated
Split2Z=Wb_Z(nH+1:nH+nI*nH);
 IW1=reshape(Split2,nH,[]);
 IW1n=reshape(Split2Z,nH,[]);
b2=Wb_un(nH+nI*nH+1:nH+nI*nH+nO);
b2n=Wb_Z(nH+nI*nH+1:nH+nI*nH+nO);
% select the portion of vector that follows B2
Split3=Wb_un(nH+nI*nH+nO+1:nO+nH+nI*nH+nH*nO);
Split3Z=Wb_Z(nH+nI*nH+nO+1:nO+nH+nI*nH+nH*nO);
% convert the split portion of column into matrix 
LW1=reshape(Split3,nO,[]);
LW1n=reshape(Split3Z,nO,[]);
% Create a Pattern Recognition Network 
% net = patternnet([nH,nH]);when we are dealing with more thatn 2 hidden
% layers
net = patternnet(nH);
net=configure(net,X,Y);

 net.divideParam.trainRatio = 70/100;
 net.divideParam.valRatio = 15/100;
 net.divideParam.testRatio = 15/100;
 net.performFcn = 'crossentropy'; 
%  net.layers{1:2}.transferFcn = 'poslin';
%  net.layers{3}.transferFcn = 'softmax';
%    net.layers{1}.transferFcn='logsig';
% ================================
%        net.layers{1}.transferFcn = 'poslin'; %%This is like Relu//positive line function
%        net.layers{2}.transferFcn = 'softmax';
% ================================
% % net.layers{2}.transferFcn=' tansig ';
% TFi -- Transfer function of ith layer, default = 'tansig'
%  net.layers{2}.transferFcn='purelin';
%   net.trainFcn = 'trainscg';
%   net.trainFcn = 'learngdm';
net.trainParam.show=50;  %# of ephocs in display
net.trainParam.lr=10/100;  %learning rate
net.trainParam.epochs=100;  %max epochs
net.trainParam.goal=0.05^2;  %training goal
     % Create the hybrid
 B1={b1 b1n};
 IW={IW1 IW1n};
 B2={b2 b2n};
 LW={LW1 LW1n};
 
 for i1=1:length(B1)
      net.b{1}=B1{i1};

  for i2=1:length(IW)
      net.IW{1,1}=IW{i2};
 
   for i3=1:length(LW)
       net.LW{2,1}=LW{i3};
  
    for i4=1:length(B2)
         net.b{2}=B2{i4};

 [net,~] = train(net,X,Y );
% % ,'useParallel','yes','useGPU','yes'
%  outputs = net(Y);
% % ,'useParallel','yes','useGPU','yes'

 outputs = net(X);
 Y_Out=outputs;
 
%   end
%       
%  end
%    end
%     end
%   T= Targets;
[~,cm]=confusion(Y,Y_Out);

[rcm,~]=size(cm);
C2=zeros (1,rcm);
D5=zeros (1,rcm);
% Opt_Acc=zeros(1,Acc_Size);
 for j2=1:rcm
diag=cm(j2,j2);
C2(j2)=diag ;      
Num=sum(C2(1,:));
d3=cm(:,j2) ;      
Sum_col=sum(d3);    
D5(j2)=Sum_col ;        %
De1=sum(D5(1,:));
Opt_Acc(i1,i2,i3,i4)=(Num/De1)*100;


end
   end
    end
    end      
 end
%  view(net)
%  [r,c]=size(Opt_Acc);
 MaxValue=max(max(Opt_Acc)); %%This gives the maximum value in 4 block 
 MaxOk=max(MaxValue);%%This gives the maximum value in 2 block
 MaxOk2=max(MaxOk); %%This gives the maximum for all block
% % =============================================
Dimension=[2 2 2 2];
Indx=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
LinearIdx=find(Opt_Acc==MaxOk2);%%Turabona index ihwanye na max, kubona Max twabikoze gatatu ??Why 
[imax,jmax,kmax,lmax]=ind2sub(Dimension,LinearIdx);
VecMax=[imax,jmax,kmax,lmax];
% WbComp={b1,b1n,IW1,IW1n, LW1, LW1n,b2, b2n};
TradUniNorm={b1,b1n,IW1,IW1n, LW1, LW1n,b2, b2n,VecMax, Opt_Acc,MaxOk2};
end

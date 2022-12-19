function [Opt_Acc] =SplitVecHyb(Wb_un, X,Y)  %%Calcul
% Because we wish to get uniform distribution Wb_un,,if you want random
% distributionuse Wb
  [~,nI]=size(X');
%   fprintf('The  numer of selected inputs is %d\n',objP.nI);
[~,nO]=size(Y');
%  fprintf('The number Of ouput if %d\n',objP.nO);
nH=round(((2/3)*nI)+nO);
% % % decremental from 29 row to 34*28 plus the used line one b1

b1=Wb_un(1:nH);
% b1n=MinMaxScaling(b1);
b1n=zscore(b1);
Split2=Wb_un(nH+1:nH+nI*nH);
% % % % Split the portion or split2 and then split en matrix of 28 rows,the % column is automated
 IW1=reshape(Split2,nH,[]);
%  IW1n=MinMaxScaling(IW1);
 IW1n=zscore(IW1);
b2=Wb_un(nH+nI*nH+1:nH+nI*nH+nO);
% b2n=MinMaxScaling(b2);
b2n=zscore(b2);
% select the portion of vector that follows B2
Split3=Wb_un(nH+nI*nH+nO+1:nO+nH+nI*nH+nH*nO);
% convert the split portion of column into matrix 
LW1=reshape(Split3,nO,[]);
% LW1n=MinMaxScaling(LW1);
LW1n=zscore(LW1);
% Create a Pattern Recognition Network 
net = patternnet(nH);
net=configure(net,X,Y);

 net.divideParam.trainRatio = 70/100;
 net.divideParam.valRatio = 15/100;
 net.divideParam.testRatio = 15/100;
 net.performFcn = 'crossentropy';
  net.trainFcn = 'trainscg';
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
%     end
%       
%  end
%    end
%     end
%     end         
%   Acc_Size=length(B1)*length(IW)*length(B2)*length(LW);
% Loop a set by iteration to find out the best solution
% there is an error ,IW  used is not normalised
   % Setup Division of Data for Training, Validation, Testing

% % Train the Network
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
%  [r,c]=size(Opt_Acc);
 MaxValue=max(max(Opt_Acc));
 MaxOk=max(MaxValue);
 MaxOk2=max(MaxOk);
% %  =============================================
Dimension=[2 2 2 2];
Indx=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
LinearIdx=find(Opt_Acc==MaxOk2);%%Turabona index ihwanye na max, kubona Max twabikoze gatatu ??Why 
[imax,jmax,kmax,lmax]=ind2sub(Dimension,LinearIdx);

% % =============================================
% %  decude the results of normalized and not normalised
Uniform_Dist=Opt_Acc(1,1,1,1);
Gaussian_Dist =Opt_Acc(2,2,2,2);

 fprintf('The maximum value in 4 block is [%3.2f%%]\n',MaxValue)
  fprintf('The maximum value for 2 all is [%3.2f%%] \n',MaxOk)
    fprintf('The maximum value for all is [%3.2f%%] \n',MaxOk2)
% %  ikibazo gishoboka kuba kuri  uko wabihinduranya ubona igisubizo kimwe
 fprintf('------------------------------------------------------------------\n')
 fprintf('The results all components are [%3.2f%%] \n', Opt_Acc)
%  fprintf('The results from resulted from [%d%d%d%d] \n', i1,i2,i3,i4)
 fprintf('The idx of max value is at [ b1=%2d,IW=%d,LW=%d,b2=%d]\n',imax,jmax,kmax,lmax)
 fprintf('The Value 1== Not Normalized, 2==Normalised, b1=input bias,IW=inputs weights,LW=layer Weights, b2=Output bias]\n')
 fprintf('------------------------------------------------------------------\n')
 
  fprintf('The Accuracy of //Uniform distribution // normalized vector is [%3.2f%%] \n',Uniform_Dist)
  fprintf('The Accuracy of //Gaussian  distribution // normalized vector is [%3.2f%%] \n',Gaussian_Dist)
save Opt_Acc
end

% 

% cm=confusionchart(Ytest,YPred)
% cm.ColumnSummary = 'column-normalized';
% cm.RowSummary = 'row-normalized';
% cm.Title = ' Confusion Matrix';
% [m,order]=confusionmat(Ytest,YPred);
% Diagonal=diag(m);
% sum_rows=sum(m,2);
% Precision=Diagonal./sum_rows;
% Overall_Precision=mean(Precision)
% sum_col=sum(m,1);
% recall=Diagonal./sum_col';
% overall_recall=mean(recall)
% F1_Score=2*((Overall_Precision*overall_recall)/(Overall_Precision+overall_recall))


%  fprintf('------------------------------------------------------------------\n')
%  fprintf('The results all components are [%3.2f%%] \n', Opt_Acc)
%  fprintf('The results from resulted from [%d%d%d%d] \n', i1,i2,i3,i4)
% end

% cm=confusionchart(Ytest,YPred)
% cm.ColumnSummary = 'column-normalized';
% cm.RowSummary = 'row-normalized';
% cm.Title = ' Confusion Matrix';
% [m,order]=confusionmat(Ytest,YPred);
% Diagonal=diag(m);
% sum_rows=sum(m,2);
% Precision=Diagonal./sum_rows;
% Overall_Precision=mean(Precision)
% sum_col=sum(m,1);
% recall=Diagonal./sum_col';
% overall_recall=mean(recall)
% F1_Score=2*((Overall_Precision*overall_recall)/(Overall_Precision+overall_reca
function [Opt_Acc] =SplitVector(Wb, X,Y)  %%Calcul
  
% % Wb=MinMaxScaling(Wb1);
 [~,nI]=size(X');
%   fprintf('The  numer of selected inputs is %d\n',objP.nI);
[~,nO]=size(Y');
%  fprintf('The number Of ouput if %d\n',objP.nO);
nH=round(((2/3)*nI)+nO);
% % % decremental from 29 row to 34*28 plus the used line one b1
b1=Wb(1:nH);
b1n=MinMaxScaling(b1);
Split2=Wb(nH+1:nH+nI*nH);
% % % % Split the portion or split2 and then split en matrix of 28 rows,the % column is automated
 IW=reshape(Split2,nH,[]);
 IWn=MinMaxScaling(IW);
b2=Wb(nH+nI*nH+1:nH+nI*nH+nO);
b2n=MinMaxScaling(b2);
% select the portion of vector that follows B2
Split3=Wb(nH+nI*nH+nO+1:nO+nH+nI*nH+nH*nO);
% convert the split portion of column into matrix 
LW=reshape(Split3,nO,[]);
LWn=MinMaxScaling(LW);
% Create a Pattern Recognition Network 
net = patternnet(nH);
net=configure(net,X,Y);
% % LOOP 
IW1={IW IWn};
L=length(IW1);
% %   for  i=1:L
% %     net.IW{1,1}=IW1{i};
% end
     % INITIALIZATION NET WITH THE NEW WEIGHTS 
% Normalization steps
% COMPONENTS NOT NORMALIZE 59.8
   net.IW{1,1}=IW;
%   net.b{1}=b1;
%   net.LW{2,1}=LW;
%   net.b{2}=b2;

 %%%% Normalized components 59.3
%    net.IW{1,1}=IWn;
 net.b{1}=b1n;
   net.LW{2,1}=LWn;
  net.b{2}=b2n;
% % % % %   
% %   end 
  %%%FOR LOOP

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

[rcm,~]=size(cm);
B2=zeros (1,rcm);
D5=zeros (1,rcm);
Opt_Acc=zeros(1,L);
 for i2=1:rcm
diag=cm(i2,i2);
B2(i2)=diag ;      
Num=sum(B2(1,:));
d3=cm(:,i2) ;      
Sum_col=sum(d3);    
D5(i2)=Sum_col ;        %
De1=sum(D5(1,:));
Opt_Acc=(Num/De1)*100;
 end
%   end  %%The end for looping in component  must be here
 fprintf('------------------------------------------------------------------\n')
 fprintf('The results are [%3.2f%%] \n', Opt_Acc)
end

% % Normalise a full vector gives the less accuracy;;
% % Normalise the components of vector you get the upgrade accuracy 

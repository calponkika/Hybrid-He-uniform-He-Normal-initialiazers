classdef Optmized_NNW

properties
%         Wb %%%The optimal initial weights  was picked from GA
        nI  %%The number of neurons at Inputs Layer
        nH  %%The number of neurons at Hidden Layer
        nO  %%The number of neurons at ouputs  Layer
        trainRatio %%Training split
       valRatio   %%%Validation split
       testRatio   %%test split
       IW   %%Input weight matrix
       b1  %%Input bias weight
        LW   %%output weight matrix
       b2  %%%output bias weight
       Opt_Acc  %%The optimal accuracy resulted from the initial weigth that was set in model
       net   %%%Save the created net so that it could be used in testing phase
   
end


methods   %%%See constructor Car in Jkuat classes_Matlab
    function objP = Optmized_NNW(trainRatio,valRatio,testRatio)
        if nargin > 0    %%It must be a vector. If it is not empty
%             objP.Wb = Optmized_NNW;
            objP.trainRatio=trainRatio;
            objP.valRatio=valRatio;
             objP.testRatio=testRatio;
       end
    end
    
    function objP = fitOpt(objP,Wb, X,Y)  %%Calcul
  

 [~,objP.nI]=size(X');
%   fprintf('The  numer of selected inputs is %d\n',objP.nI);
[~,objP.nO]=size(Y');
%  fprintf('The number Of ouput if %d\n',objP.nO);
objP.nH=round(((2/3)*objP.nI)+objP.nO);
% % % decremental from 29 row to 34*28 plus the used line one b1
objP.b1=Wb(1:objP.nH);
Split2=Wb(objP.nH+1:objP.nH+objP.nI*objP.nH);
% % % % Split the portion or split2 and then split en matrix of 28 rows,the % column is automated
 objP.IW=reshape(Split2,objP.nH,[]);
objP.b2=Wb(objP.nH+objP.nI*objP.nH+1:objP.nH+objP.nI*objP.nH+objP.nO);
% select the portion of vector that follows B2
Split3=Wb(objP.nH+objP.nI*objP.nH+objP.nO+1:objP.nO+objP.nH+objP.nI*objP.nH+objP.nH*objP.nO);
% convert the split portion of column into matrix 
objP.LW=reshape(Split3,objP.nO,[]);
% Create a Pattern Recognition Network 

objP.net = patternnet(objP.nH);
objP.net=configure(objP.net,X,Y);
     % INITIALIZATION NET WITH THE NEW WEIGHTS 
% Normalization steps
% Loop a set by iteration to find out the best solution
objP.net.IW{1,1}=objP.IW;
% there is an error ,IW  used is not normalised
 objP.net.b{1}=objP.b1;
 objP.net.LW{2,1}=objP.LW;
 objP.net.b{2}=objP.b2;
   % Setup Division of Data for Training, Validation, Testing
 objP.net.divideParam.trainRatio = objP.trainRatio;
 objP.net.divideParam.valRatio = objP.valRatio;
 objP.net.divideParam.testRatio =objP.testRatio;
  objP.net.performFcn = 'crossentropy';
  objP.net.trainFcn = 'trainscg';
% % Train the Network
 [objP.net,tr] = train(objP.net,X,Y );
% % ,'useParallel','yes','useGPU','yes'
%  outputs = net(Y);
% % ,'useParallel','yes','useGPU','yes'
 outputs = objP.net(X);
 Y_Out=outputs;
%   T= Targets;
[~,cm]=confusion(Y,Y_Out);
[rcm,~]=size(cm);
B2=zeros (1,rcm);
D5=zeros (1,rcm);
 for i2=1:rcm
diag=cm(i2,i2);
B2(i2)=diag ;      
Num=sum(B2(1,:));
d3=cm(:,i2) ;      
Sum_col=sum(d3);    
D5(i2)=Sum_col ;        %
De1=sum(D5(1,:));
objP.Opt_Acc=(Num/De1)*100;
     
%  end
 end
 end
end
end

 function [Metrics]=Precision_FPR(~)
 % EXAMPLE OF HOW WE USE PRECISON AND False positive fomula in Matlab
Q=[9655 8 20 51 10;15 42254 1 4 0;17 1 4086 0 0;39 3 0 1067 8;2 0 0 4 34];
[r,c]=size(Q);
Wpre =zeros(1,c);
CsVec=zeros(1,c);
FP_i=zeros(1,c);
STR=zeros(1,c);
% % calculate Precision
for i=1:c
Cs=sum(Q(:,i));
prec_i=Q(i,i)/Cs;
Wpre(i)=prec_i;
CsVec(i)=Cs;
CsVec1=sum(CsVec);
PrecisonOk=mean(Wpre)*100;%%well classified wrt to target value
% % calculate FPR   Acc=Well Classified wrt to output value
Cs=sum(Q(i+1:r,i));
FP_i(i)=sum(Cs);
FP=sum(FP_i);
ST=sum(Q(i,i));
STR(i)=ST;
Tot=sum(STR);
TN=Tot-Q(1,1); %%Because the Q(1,1) represents normal traffic 
FPR=FP/Tot;
Acc=(Tot/CsVec1)*100;
end
Metrics=[Acc,PrecisonOk,FPR];
 end
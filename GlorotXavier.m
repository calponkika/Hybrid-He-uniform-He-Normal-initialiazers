function Z=GlorotXavier(W,nI,nO)
% He scare for normalization
%  W=rand(1000,1);
%  nI=20;
%  nO=3;
n=length(W);
Z=zeros(n,1);
for i=1:n
    W1=W(i,1);%%(Zi-0)/sdt
%      K=4*sqrt(2/(nI+nO)); %%Sigmoid 
    K=sqrt(2)*sqrt(2/(nI+nO)); %%Relu
    Z(i,1)=(W1-mean(W1))/K;
end
end
    
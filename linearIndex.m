% % USHAKA GUHINDURA ILINEAR INDEX MURI INDEX ZA MATRIX 
% % ====================================================
A=[1 4 7;2 5 8;3 6 9];

% Gushaka index zijyanye na position 2 6 9; muri Q :  LnearValue=[2 6 9]
%%Dimesion ya matrix is Dim=[3,3]
Dim=[3,3];
LnearValue=[2 6 9];
[r,~] = ind2sub(Dim,LnearValue);
%%Ans r=[2,3,3] 
   %   C=[1 2 3]   i.e 2 =A(2,1)  , 6=A(3,2)
   





% Example 2 — Three-Dimensional Matrices
% The mapping from linear indexes to subscript equivalents for a 2-by-2-by-2 array is
% A=[1 3;2 4]   AND B=[5 7;6 8]
% ufat index za A tukoneraho 1 na 2  |(1,1,1)|(1,2,1)|  kurundi ruhande |(1,1,2)|(1,2,2)|
%                                    |(2,1,1)|2,2,1 |                    ||(2,1,2)|2,2,2 |
% This code determines the subscript equivalents in a 2-by-2-by-2 array, of elements whose linear indices 3, 4, 5, 6 are specified in the IND matrix.
% 
IND = [1 4;5 6];%%Uramutse ufashe 3 4 kuruhande rumwe na 5,6 kurundi
IND2=6;
Dims = [2,2,2];
 [I,J,K] = ind2sub(Dims,IND);
 [I1,J1,K1] = ind2sub(Dims,IND2);%%UFASHE UMUBARE UMWE
% 
%  [INDEX ZIHARARIYE IMIBARE 4 NIYO MPAMVU IPANZE NKA MATRICE
% IZIBYARE  
%IND=    1     4
  %      5     6
% % ================== 1=IHUZA (i,j,k)=(1,1,1)=1 value1
%I=    1     2
%      1     2
% 
% J =
%      1     2
%      1     2
% 
% K =
%      1     1
%      2     2
% % Example 3 — Effects of Returning Fewer Outputs
% % When calling ind2sub for an N-dimensional matrix, you would typically supply N output arguments in the call: one for each dimension of the matrix. This example shows what happens when you return three, two, and one output when calling ind2sub on a 3-dimensional matrix.
% % 
% % The matrix is 2-by-2-by-2 and the linear indices are 1 through 8:
% 
% dims = [2 2 2];
% indices = [1 2 3 4 5 6 7 8];
% The 3-output call to ind2sub returns the expected subscripts for the 2-by-2-by-2 matrix:
% 
% [rowsub colsub pagsub] = ind2sub(dims, indices)
% rowsub =
%      1     2     1     2     1     2     1     2
% colsub =
%      1     1     2     2     1     1     2     2
% pagsub =
%      1     1     1     1     2     2     2     2
% %If you specify only two outputs (row and column), ind2sub still returns a subscript for each specified index, but drops the third dimension from the matrix, returning subscripts for a 2-dimensional, 2-by-4 matrix instead:
% 
% [rowsub colsub] = ind2sub(dims, indices)
% rowsub =
%      1     2     1     2     1     2     1     2
% colsub =
%      1     1     2     2     3     3     4     4
% %If you specify one output (row), ind2sub drops both the second and third dimensions from the matrix, and returns subscripts for a 1-dimensional, 1-by-8 matrix instead:
% 
% [rowsub] = ind2sub(dims, indices)
% rowsub =
%      1     2     3     4     5     6     7     8
% EXAMPLE OF RESEACRH 
Dimension=[2 2 2 2];
Indx=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
idx=11;%%Assume we pick 11
[a,b,c,d] = ind2sub(Dimension,idx);
%%Ans11=(1,2,1,2)==1==not normalize, n==normalize


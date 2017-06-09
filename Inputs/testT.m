%create a transition system

function T = testT()

T.Q=[1:5];   %states
T.Pi=[10:13]; %all subsets of atomic propositions
T.curr = 1;    %initial state

%adjacency matrix
T.adj=sparse(5,5);
T.adj(1,1)=1;
for i=2:5
    T.adj(i,i)=1;
    T.adj(i,i-1)=1;
end
T.adj(1,2)=1; %T.adj(from_state,to_state)=weight
T.adj(2,3)=1; % 1D robot
T.adj(3,4)=1;
T.adj(4,5)=1;
T.adj(5,1)=1;

%observation == labeling function
T.ser=[];
for i=1:5
    T.ser(i,1)=10;
end
T.ser(2,1)=11;
T.ser(3,1)=13;
T.ser(5,1)=12;

%notes for encoding subset of atomic propositions: let's say {a,b,c,d} is the set
%of atomic propostions. The set of all subsets has 16 elements,
%T.obs=[1:16]
%binary encoding of the obs exactly determines which atomic propositions
%are and are not in the set
%16=0000, none of them is
%1=0001, d is in the set, the rest is not
%2=0010, c is in the set, the rest is not
%3=0011, c and d are in the set....
%4=0100, b is...
% ...
%15=1111, all of them are.


%T.obs is equal to B.Sigma!!!
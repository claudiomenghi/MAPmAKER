%% INPUT
% spec: the specification of the automata
% dep: the automata in the dependency class
% h: the index upun which the automata must be explored
%% OUTPUT
function [P_old, B] = intersection(spec,dep, h)

clear succ;
clear P;
clear B;
clear Bnew;

M = length(dep);
%% computes the cartesian product, i.e., all the possible states of the intersection
P.Q=cartesian_product(spec(dep).Q, 1:h , 1:2*h); 
st_no=size(P.Q,1); 

if spec(dep(1)).step == 2
    foo = 2;
else
    foo = 1;
end

%% state space exploration
current = [spec(dep).curr 1 foo]; % initial location from which the state space exploration starts
for i=1:st_no % for every possible location
    P.V1{i} = P.Q(i,M+2); % saves the index 2*h in the V1 cell, i.e., saves how much progress can be made
    P.V2{i} = -1000;
    if isequal(P.Q(i,:),current)
        P.curr=i;
    end
end
P.V2{P.curr}=0;
P.V1{P.curr}=0; 

%% computes all the possible combinations of actions the robot can perform
P.Sigma = cartesian_product(spec(dep).Sigma);
act_no=size(P.Sigma,1);

%% computes the services associated to each combination of actions
P.lab{act_no}=[];
for t = 1:act_no %label for each sigma in Sigma
    P.lab{t}=[];
    for k = 1:M
        if P.Sigma(t,k)~=0
            P.lab{t} = unique([P.lab{t} spec(dep(k)).lab{P.Sigma(t,k)}]);
        end
    end
    for k = 1:M
        if length(intersect(P.lab{t},[dep(k)*10:dep(k)*10+9]))>1
            P.lab{t}=-1;
        end
        if length(intersect(P.lab{t},[dep(k)*10:dep(k)*10+9]))>=1 && P.Sigma(t,k)==0
            P.lab{t}=-1;
        end
    end
end

%% state space exploration
succ{M}=[];

P.trans = cell(st_no,act_no); 
% contains a matrix with size: possible states X possible actions
P.pred = cell(st_no);
% contains a matrix with size: possible states X possible states

now = [P.curr];
processed = [];
new = [];
iter = 1;

fprintf('Working on the intersection automaton for class');
fprintf(' %d', dep);
fprintf(' ...\n');
while ~isempty(now) && iter<=h %explore -- using the cut already
    fprintf('Level %d \n', iter);
    new=[];
    iter = iter+1;
    for i = now %do it from possible current states
        for t=1:act_no
            if ~isequal(P.lab{t},-1)
                % computes the successors of the now state
                % succ{i} contains for each machine the successor for the
                % given label
                for m = 1:M
                    if P.Sigma(t,m) == 0
                        succ{m} = P.Q(i,m);
                    else
                        succ{m} = spec(dep(m)).trans{P.Q(i,m),P.Sigma(t,m)};
                    end
                end
                %now, i need to give them the last two components
                if P.Q(i,M+1) > M
                    foo = mod(P.Q(i,M+1),M);
                    if foo == 0
                        foo = foo + M;
                    end
                else
                    foo= P.Q(i,M+1);
                end
                %foo is now the leading automaton
                
                P.trans{i,t} = [];
                
                newstates = cartesian_product(succ{:});
                
                for k=1:size(newstates)
                    
                    clearV2 = false;
                    
                    %determine the last components
                    if ismember(newstates(k,foo),spec(dep(foo)).F) && P.Sigma(t,foo)~=0
                        bar1 = P.Q(i,M+1)+1;
                        bar2 = P.Q(i,M+2)+1;
                        clearV2 = true;
                    else
                        bar1 = P.Q(i,M+1); %otherwise it is kept
                        bar2 = P.Q(i,M+2);
                    end
                    
                    if P.Sigma(t,foo)==0 %has not made a real transition
                        bar2 = 1;
                    end
                    
                    for j=1:st_no
                        found=true;
                        if P.Q(j,M+2)~=bar2
                            found=false; continue;
                        end
                        if P.Q(j,M+1)~=bar1
                            found=false; continue;
                        end
                        for m=1:M
                            if ~isequal(P.Q(j,m),newstates(k,m))
                                found=false;
                                break;
                            end
                        end
                        if found
                            P.pred{j} = unique([P.pred{j} i]);
                            P.trans{i,t} = unique([P.trans{i,t} j]);
                            if clearV2
                                P.V2{j} = 0;
                            end
                            new = unique([new j]);
                        end
                    end
                end
            end
        end
        processed = unique([processed i]);
    end
    now = setdiff(new,processed);
end

processed = [processed now];
   
%define Bnew.Q=1:length(processed)...na konci B=Bnew

propagate = [];
Bnew.Q = 1:length(processed);
for i=Bnew.Q
    Bnew.translate{i}=processed(i);
    P.untranslate{processed(i)}=i;
    Bnew.pred{i} = [];
    Bnew.V1{i} = P.V1{Bnew.translate{i}};    
    Bnew.V2{i} = P.V2{Bnew.translate{i}};
    if P.V2{Bnew.translate{i}}==0
        propagate = [propagate i];
    end
end

for i=Bnew.Q
    for j=1:act_no
        foo = P.trans{Bnew.translate{i},j};
        Bnew.trans{i,j} = [];
        for k=foo
            Bnew.trans{i,j}= [Bnew.trans{i,j} P.untranslate{k}];
            Bnew.pred{P.untranslate{k}} = unique([Bnew.pred{P.untranslate{k}} i]);
        end
    end
end

Bnew.Sigma=P.Sigma;
Bnew.lab=P.lab;
Bnew.curr=P.untranslate{P.curr};

while ~isempty(propagate)
    i = propagate(1);
    propagate = setdiff(propagate,i,'stable');
    for j= Bnew.pred{i}
        
        if Bnew.V1{i} == Bnew.V1{j}+1 && Bnew.V2{i} == 0
            if Bnew.V2{i}-1 > Bnew.V2{j}
                Bnew.V2{j} = Bnew.V2{i}-1;
                propagate = unique([propagate j],'stable');
            end
        end
        
        if Bnew.V1{i} == Bnew.V1{j}
            if Bnew.V2{i}-1 > Bnew.V2{j}
                Bnew.V2{j} = Bnew.V2{i}-1;
                propagate = unique([propagate j],'stable');
            end
        end
    end
end

P_old=P;

%remove redundant states
clear P;
P = Bnew;
for i=P.Q
    P.untranslate{i}=[];
end
processed = [];

for i=Bnew.Q
    %if %Bnew.V1{i} > 1 || 
     if  Bnew.V2{i} ~= -1000
        processed = [processed i];
    end    
end

B.Q = 1:length(processed);
for i=B.Q
    B.translate{i}=processed(i);
    B.ultimate_translate{i}=P.translate{processed(i)};
    P.untranslate{processed(i)}=i;
    B.pred{i} = [];
    B.V1{i} = P.V1{B.translate{i}};    
    B.V2{i} = P.V2{B.translate{i}};
end

for i=B.Q
    for j=1:act_no
        foo = intersect(P.trans{B.translate{i},j},processed);
        B.trans{i,j} = [];
        for k = foo
            if ~isempty(k)
            if ~isempty(P.untranslate{k})
                B.trans{i,j}= [B.trans{i,j} P.untranslate{k}];
                B.pred{P.untranslate{k}} = unique([B.pred{P.untranslate{k}} i]);
            end
            end
        end
    end
end

B.Sigma=P.Sigma;
B.lab=P.lab;
B.curr=P.untranslate{P.curr};



        
cd

clear P;
clear weight;
clear succ;

P.curr = [sys(dep).curr B.curr];

act_no=size(B.Sigma,1);
P.Sigma = [1:act_no];

Qnew = true;
P.Q = [P.curr];
%%%%%%%%%

%%%%%%%%%
st_no_new=0;

i=0;
maxV1=B.V1{B.curr};
maxV2=B.V2{B.curr};
P.max = [];
% maxV1
% maxV2

while i<H && Qnew
    fprintf('Level %d of the product \n', i);
    i=i+1;
    %P.Q = unique([P.Q; Qnew],'rows');
    Qnew = false;
    
    st_no_old=st_no_new+1;
    st_no_new=size(P.Q,1);
    
    for j=st_no_old:st_no_new %take a state
        
        for bar = 1:size(P.Q,1)
             P.weight{j,bar}=10000;
        end
        
        clear succ;
        P.succ{j} = [];
        for t=1:act_no %take an alphabet element
            
            P.trans{j,t} = [];      
    
            succ{M+1} = B.trans{P.Q(j,M+1),t};
            
            for m=1:M %explore all components of sys(1)...sys(M)
          
                if B.Sigma(t,m)==0
                    succ{m} = find(sys(dep(m)).adj(P.Q(j,m),:));
                   
                   
                    %%%%%%%%%%%
                   
                else
%                     if mod(intersect(spec(dep(m)).lab{B.Sigma(t,m)},[dep(m)*10:dep(m)*10+9]),10)==0
%                         succ{m} = P.Q(j,m);
%                     else
                        if ismember(intersect(spec(dep(m)).lab{B.Sigma(t,m)},[dep(m)*10:dep(m)*10+9]),sys(dep(m)).ser{P.Q(j,m)})
                            succ{m} = P.Q(j,m);
                        else
                            succ{m}=[];
                        end
                    %end
                end 
            end
            transition=1;
            for m=1:M+1
                if isempty(succ{m})               
                    transition=0;
                end
            end
            
            newstates = [];
            weight=[];
            if transition          
                newstates = cartesian_product(succ{:}); 
                 for foo=1:size(newstates,1)
                     if M==1 && B.Sigma(t,1)==0
                         weight(foo) = sys(dep(1)).adj(P.Q(j,1),newstates(foo,1));
                     end
                     if M==2 && B.Sigma(t,1)==0 && B.Sigma(t,2)==0
                         weight(foo) = sys(dep(1)).adj(P.Q(j,1),newstates(foo,1)) +  sys(dep(2)).adj(P.Q(j,2),newstates(foo,2));                             
                     end
                     if M==1 && B.Sigma(t,1)~=0
                         weight(foo) = 2;
                     end
                     if M==2 && B.Sigma(t,1)~=0 && B.Sigma(t,2)==0
                         weight(foo) = 2 +  sys(dep(2)).adj(P.Q(j,2),newstates(foo,2));                             
                     end
                     if M==2 && B.Sigma(t,1)==0 && B.Sigma(t,2)~=0
                         weight(foo) = 2 +  sys(dep(1)).adj(P.Q(j,1),newstates(foo,1));                             
                     end
                     if M==2 && B.Sigma(t,1)~=0 && B.Sigma(t,2)~=0
                         weight(foo) = 4;                             
                     end
                end           
            else
                newstates = [];
            end
            for foo = 1:size(newstates,1)
                notfound = 1;
                for bar = 1:size(P.Q,1)
                    if isequal(newstates(foo,:),P.Q(bar,:))
                        notfound = 0;
                        P.trans{j,t} = unique([bar P.trans{j,t}]); 
                        P.succ{j} = unique([bar P.succ{j}]);
                        if P.weight{j,bar} > weight(foo);
                            P.weight{j,bar} = weight(foo);
                            P.action{j,bar} = t;
                        end
                    end
                end
                if notfound
                    bar = size(P.Q,1)+1;
                    P.Q = [P.Q; newstates(foo,:)];
                    P.succ{bar}=[];
                    Qnew = true;
                    P.trans{j,t} = unique([bar P.trans{j,t}]);
                    P.succ{j} = unique([bar P.succ{j}]);
                    P.action{j,bar} = t;
                    P.weight{j,bar}= weight(foo);
                end
            end                  
        end
        
    end
end

%finding the maximum

P.States = 1:size(P.Q,1);
for i=P.States
    
    if B.V1{P.Q(i,M+1)} == maxV1 && B.V2{P.Q(i,M+1)} == maxV2
        P.max = [P.max i];
    end
    if B.V1{P.Q(i,M+1)} == maxV1 && B.V2{P.Q(i,M+1)} > maxV2
        maxV2=B.V2{P.Q(i,M+1)};
        P.max = [i];
    end
    if B.V1{P.Q(i,M+1)} > maxV1
        maxV1=B.V1{P.Q(i,M+1)};
        maxV2=B.V2{P.Q(i,M+1)};
        P.max = [i];
    end
    P.pred{i} = [];
end


% maxV1
% maxV2


if isempty(P.max)
    fprintf('H %d too small \n', H);
   if H<20 
         H=H+1;
       [P, sys, spec, path, actions] = product2(sys,spec,dep,M,B,Buchi,H);
   end
    return;
end
if ismember(1,P.max)
    fprintf('H %d too small \n', H);
   if H < 20
       H=H+1;
       [P, sys, spec, path, actions] = product2(sys,spec,dep,M,B,Buchi,H);
   end
    return;
end
%%%%%%%%%%%%%%%%%%

for i= 1:size(P.Q,1)
    P.d{i}= 1000000;
end


%%%%%%%%%%%%%%
%dijkstra
processed = [];
to_search = 1;
found = 0;
P.d{1}=0;
while ~isempty(to_search) && ~found
    
    %the one with maximum P.d
    i=to_search(1);
    for j = 1:length(to_search)
        if P.d{to_search(j)} < P.d{i}
            i=to_search(j);
        end
    end
    

    if ismember(i,P.max)
            P.final = i;
            found = 1;
            break;
    end
        
    to_search=setdiff(to_search,i);
    processed = unique([processed i]);
    for j=P.succ{i}
        
        if isempty(P.pred{j})
            P.pred{j} = i;
            P.pred_action{j} = P.action{i,j};
        end
        
        to_search = [to_search j];
   
        if P.d{j} > P.d{i} + P.weight{i,j}
            P.d{j} = P.d{i} + P.weight{i,j};
        
        end
    end
    to_search = setdiff(to_search, processed, 'stable');
    
end

%generating the path
i=P.final;
actions = [];
path = [i];
while i~=1
    actions = [P.pred_action{i} actions ];
    i=P.pred{i};
    path = [i path];
end

actions;
%%%%%%%%%%%%%%%%%%%%
% path
% actions
%%%%%%%%%%%%%%%%%%%%%%%%

%checking whether it's not just moving, if so, just replacing with idling
%instead

%printing



%if Buchi.Q(B.ultimate_translate{P.Q(path(i+1),M+1)},M+2) == 2
%    spec(dep(1)).step = 2; %what does this mean???
%end
  
fprintf('\n Size of the product: %d \n', length(P.Q));

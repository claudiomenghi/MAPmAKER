function [P, sys, spec] = product(sys,spec,dep,M,B,Buchi,H)

global possibleengineenabled;

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
                     %if newstates(foo,1) == 58 && newstates(foo,2) == 48 && P.Q(j,1) == 76 && P.Q(j,2)==48
                     %    B.Sigma(t,1)
                     %    B.Sigma(t,2)
                     %    weight(foo)
                     %end
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

res=0;
if isempty(P.max)
   fprintf('H %d too small for a definitive solution \n', H);
   
   if(possibleengineenabled==1)
       [P, sys,spec, res] = possibleproduct(sys,spec,dep,M,B,H);
       if(res==1)
            fprintf('H %d possible solution found \n', H);
            possibleSolutionSearchTriggered=1;
       else
           if ((H<20) && (res==0))
                 H=H+1;
               [P, sys, spec] = product(sys,spec,dep,M,B,Buchi,H);
               return;
           end
               
       end
   end
end
if (ismember(1,P.max))
   fprintf('H %d too small for a definitive solution \n', H);
   
   if(possibleengineenabled==1)
       [P1, sys,spec, res] = possibleproduct(sys,spec,dep,M,B,H);
       
       if(res==1)
            fprintf('H %d possible solution found \n', H);
            possibleSolutionSearchTriggered=1;
       else
           if ((H < 20)  && (res==0))
               H=H+1;
               [P, sys, spec] = product(sys,spec,dep,M,B,Buchi,H);
               return;
           end
       end
   end
end
%%%%%%%%%%%%%%%%%%

if(possibleengineenabled==1 && res==1)
    P=P1;
end
  
for i= 1:size(P.Q,1)
    P.d{i}= 1000000;
end


%%%%%%%%%%%%%%
%dijkstra
P=dijkstra(P);


%generating the path
i=P.final;
actions = [];
path = [i];
while i~=1
    actions = [P.pred_action{i} actions ];
    i=P.pred{i};
    path = [i path];
end

actions


%%%%%%%%%%%%%%%%%%%%
% path
% actions
%%%%%%%%%%%%%%%%%%%%%%%%

%checking whether it's not just moving, if so, just replacing with idling
%instead

%printing
fprintf('Printing  M %d \n', M);

for m=1:M
    fprintf('\n TS %d \n \n %d', sys(dep(m)).index, P.Q(1,m));
    for i=1:length(actions)
        
        action =  intersect(sys(dep(m)).Pi,B.lab{actions(i)});
        if isempty(action)
            action= 0;
        end
        
        if i==1 
            sys(dep(m)).lastaction=action;
        end
        fprintf('   --%d-->   %d',action, P.Q(path(i+1),m));
    end 
    
    %%%IMPORTANT
    sys(dep(m)).curr = P.Q(path(2),m);
    spec(dep(m)).curr = Buchi.Q(B.ultimate_translate{P.Q(path(2),M+1)},m);
    
end

%if Buchi.Q(B.ultimate_translate{P.Q(path(i+1),M+1)},M+2) == 2
%    spec(dep(1)).step = 2; %what does this mean???
%end
  
fprintf('\n Size of the product: %d \n', length(P.Q));

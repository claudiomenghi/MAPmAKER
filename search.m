function P = search(sys,spec,dep,M,B,H)

clear P;

P.curr = [sys(dep).curr B.curr];

act_no=size(B.Sigma,1);
P.Sigma = [1:act_no];

Qnew = true;
P.Q = [P.curr];
st_no_new=0;

i=0;

maxV1=B.V1{B.curr};
maxV2=B.V2{B.curr};
P.max = B.curr;

while i<H && Qnew
    i=i+1;
    %P.Q = unique([P.Q; Qnew],'rows');
    Qnew = false;
    
    st_no_old=st_no_new+1;
    st_no_new=size(P.Q,1);
    
    for j=st_no_old:st_no_new %take a state
        
        for t=1:act_no %take an alphabet element
            
            P.trans{j,t} = [];
            
            succ{M+1} = B.trans{P.Q(j,M+1),t};
            for m=1:M %explore all components of sys(1)...sys(M)                
                if B.Sigma(t,m)==0
                    succ{m} = find(sys(m).adj(P.Q(j,m),:));
                else
                    if mod(intersect(spec(m).lab{B.Sigma(t,m)},[m*10:m*10+9]),10)==0
                        succ{m} = P.Q(j,m);
                    else
                        if ismember(intersect(spec(m).lab{B.Sigma(t,m)},[m*10:m*10+9]),sys(m).ser{P.Q(j,m)})
                            succ{m} = P.Q(j,m);
                        else
                            succ{m}=[];
                        end
                    end
                end 
            end
            transition=1;
            for m=1:M
                if isempty(succ{m})
                    transition=0;
                end
            end
            if transition
                newstates = cartesian_product(succ{:});
            end
            
            for foo = 1:size(newstates,1)
                notfound = 1;
                for bar = 1:size(P.Q,1)
                    if isequal(newstates(foo,:),P.Q(bar,:))
                        notfound = 0;
                        P.trans{j,t} = [P.trans{j,t} bar];
                    end
                end
                if notfound
                    bar = size(P.Q(1)+1)+1;
                    P.Q = [P.Q; newstates(foo,:)];
                    Qnew = true;
                    P.trans{j,t} = [P.trans{j,t} bar];
                end
            end                  
        end
    end
end

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
    
end
% P.F = find(ismember(P.S(:,2)', B.F) & ismember(P.S(:,1)',T.F));
% P.S0=find(ismember(P.S(:,1)', T.q0) & ismember(P.S(:,2)', B.s0));
% 
% P.trans=sparse(st_no,st_no);
% P.weights=sparse(st_no,st_no);
% 
% for i=1:st_no 
%     i
%     tr_q=find(T.adj(P.S(i,1),:));
%     actions=find(~cellfun('isempty',B.trans(P.S(i,2),:)));
%     for k=1:length(actions)
%         if ismember(T.Obs(P.S(i,1),1), actions(k))  
%             tr_s = B.trans{P.S(i,2),actions(k)};
%             for j=1:length(tr_s)
%                 for jj=1:length(tr_q)
%                 ind=find((P.S(:,1)==tr_q(jj)) & (P.S(:,2)==tr_s(j)));  
%                 P.trans(i,ind)=1;
%                 P.weights(i,ind)= B.weights{P.S(i,2),actions(k)}(j,1)*100 + B.weights{P.S(i,2),actions(k)}(j,2)*10 +1;
%                 end
%             end
%         end
%     end
% end
% 
% P.States=P.trans;
% P.destinations=P.F;

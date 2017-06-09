

clear P;
P.Q = [];
P.curr = [sys(dep).curr B.curr];

act_no=size(B.Sigma,1);
P.Sigma = [1:act_no];

Qnew = [P.curr];
st_no_new=0;

i=0;

    P.Q = unique([P.Q; Qnew],'rows');
    Qnew = [];
    
    st_no_old=st_no_new+1;
    st_no_new=size(P.Q,1);
    
    for j=st_no_old:st_no_new %take a state
        
        for t=16 %take an alphabet element
            t
            for m=1:M %explore all components of sys(1)...sys(M)
            
            B.Sigma(t,m)
                if B.Sigma(t,m)==0
                    nothing = 1 
                    succ{m} = P.Q(j,m);
                else
                    if mod(intersect(spec(m).lab{B.Sigma(t,m)},[m*10:m*10+9]),10)==0
                        empty_service = 1
                        succ{m} = find(sys(m).adj(P.Q(j,m),:));
                    else
                        if ismember(intersect(spec(m).lab{B.Sigma(t,m)},[m*10:m*10+9]),sys(m).ser{P.Q(j,m)})
                            m
                            succ{m} = P.Q(j,m)
                        else
                            succ{m}=[]
                        end
                    end
                end 
            end
            m
            succ{M+1} = B.trans{P.Q(j,M+1),t}
            
            
            %P.trans{j,t} =
            %Qnew =
         succ
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

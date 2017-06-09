
clear all;

addpath('Inputs');

%no of agents
N=3; 

%inputs
offset(1)=-10;
offset(2)= 9;
offset(3)=-15;

%purple
%blue
%green

sys(1)=TB1();
sys(2)=TC2();
sys(3)=TA3();

spec(1)=B12();
spec(2)=C23();
spec(3)=A32();

grid = visualize();
scale = 30;

% horizon for the intersection automaton
h=3;
% horizon for the product
H=5;

reply = '';
i=1;
iter=0;

perm = [3,1,2]; %permutation (i.e. ordering), meaning that agent 3 < agent 1 < agent 2
%perm=[1,2,3];

totaltime=0;
counter = 0;

while isempty(reply)
    
    skip=0;
    iter=iter+1;
    
    fprintf('-----------------\n Iteration: %d. \n-----------------\n',iter);
   % h = input('Input h :');
   % if isempty(h)
        h=3;
   % end
    clear Dep;
    clear ell;
    clear Buchi;
    clear B;
    clear P;
    clear act;
    clear states;
    clear buchistates;

    sync = false;
    
    %dependency partition
    [Dep,ell] = dependency(spec,perm,N,h);
    for i=1:N
        cut(spec(i),h);
    end

    for i=1:N
        sys(i).previouscurr = sys(i).curr;
    end
        
    for i=1:ell
        clear Buchi;
        clear B;
        clear P;
        
        dep = Dep{i};
        M = length(dep);
        
        [Buchi, B] = intersection(spec,dep,M,h);
        fprintf('Buchi %d done \n',i);
        
       
        
       if isequal([1],B.Q)
            fprintf('h too small! \n');
            skip = 1;
            break;
       end
       
       % H = input('Input H :');
       % if isempty(H)
            H=5;
       % end

    if ~skip
        [P, sys, spec,path,actions] = product2(sys,spec,dep,M,B,Buchi,H);
         for m=1:M 
            states{dep(m),1} = P.Q(path(1),m);
            for i=1:length(actions)
                act{dep(m),i} =  intersect(sys(dep(m)).Pi,B.lab{actions(i)});
                if isempty(act{dep(m),i})
                    act{dep(m),i}= 0;
                end
                states{dep(m),i+1} = P.Q(path(i+1),m);
                buchistates{dep(m),i+1} = Buchi.Q(B.ultimate_translate{P.Q(path(i+1),M+1)},m);
                if i==1 
                    sys(dep(m)).lastaction=act{dep(m),i};
                end
                if act{dep(m),1} ~= 0
                   sync = true ;
                end
            end
            if dep(m)==1
                extimes{1} = randi([1 5],1,length(actions));
            else
                extimes{dep(m)} = randi([5 10],1,length(actions));
            end
            
        end
    end
    end
    
    if ~skip
       
    progress{1} = 1; progress{2} = 1; progress{3} = 1;
    eltimes{1} = 0; eltimes{2}=0; eltimes{3}=0;
    
    if sync
        fprintf('Syncing.................\n');
        for m=1:N
            fprintf('\n TS %d \n \n %d', sys(m).index, states{m,1});
            fprintf('   --%d-->   %d',act{m,1},  states{m,2});
       
        
        fprintf('\n');

        sys(m).previouscurr = sys(m).curr;
        sys((m)).lastaction=act{(m),1};
        sys((m)).curr = states{(m),2};
        spec((m)).curr = buchistates{m,2} ;
        
        if sys(m).lastaction~=0 && ismember(spec(m).curr,spec(m).F)
            perm = [setdiff(perm,[m],'stable'),m];
            fprintf('Reordering triggered by agent %d. \n', m);                 
        end    
        
       eltimes{m} = extimes{m}(1);
       progress{m} = 2;
        
        end    
    %visualize initial
            for i=1:N
                 if totaltime + eltimes{i} < 477
            fprintf('System %d, new current state %d, automaton state %d \n',sys(i).index, sys(i).curr, spec(i).curr);
            [xprevious,yprevious] = transform_coordinates(sys(i).previouscurr);
            [x,y]= transform_coordinates(sys(i).curr);
            switch i
                case 1
                    color = 0.610;
                case 2
                    color = 0.631;
                case 3
                    color = 0.108;
            end
            grid((xprevious-1)*scale+scale/2+4+ offset(i):(x-1)*scale+scale/2+4+offset(i), (yprevious-1)*scale+scale/2+4+offset(i):(y-1)*scale+scale/2+4+offset(i)) = color;
            grid((x-1)*scale+scale/2+4+offset(i):(xprevious-1)*scale+scale/2+4+offset(i), (y-1)*scale+scale/2+4+offset(i):(yprevious-1)*scale+scale/2+4+offset(i)) = color;
            if sys(i).lastaction ~= 0
                grid((x-1)*scale+scale/2+offset(i):(x-1)*scale+scale/2+8+offset(i),(y-1)*scale+scale/2+offset(i):(y-1)*scale+scale/2+8+offset(i)) = color;
                if ((i==1) || (i==3))
                    offset(i) = offset(i) + 2;
                else
                    offset(i) = offset(i) - 2;
                end
            end
            end
        
        
        imshow(grid)
        colormap(colorcube)
        pause(1)
            end
    end
     
    next = 0;
    nextime = 10000;
    quit=0;
    
    for i = 1: N
        if progress{i} < size(act,2)
            if ~isempty(act{i,progress{i}}) && act{i,progress{i}} == 0
                    if nextime > eltimes{i} + extimes{i}(progress{i})
                        nextime = eltimes{i} + extimes{i}(progress{i});
                        next=i;
                    end
            else
                quit = quit + 2^i;
            end
        else
            quit = quit +2^i;
        end
    end
   
    switch quit
       case 2
                      makestep = [2,3];
                  case 4
                      makestep = [1,3];
                  case 8
                      makestep = [1,2];
                  case 6
                      makestep = [3];
                  case 10
                      makestep = [2];
                  case 12
                      makestep = [1];
                  case 14
                      makestep = [];
                  otherwise
                      makestep = [];
    end
    makestep;
    for m=makestep
         fprintf('\n TS %d \n \n %d', sys(m).index, states{m,progress{m}});
           fprintf('   --%d-->   %d \n',act{m,progress{m}},  states{m,progress{m}+1});
            
           
            sys(m).previouscurr = sys(m).curr;
            sys((m)).lastaction=act{(m),progress{m}};
            sys((m)).curr = states{(m),progress{m}+1};
            spec((m)).curr = buchistates{m,progress{m}+1} ;
            
            if sys(m).lastaction~=0 && ismember(spec(m).curr,spec(m).F)
                perm = [setdiff(perm,[m],'stable'),m];
                fprintf('Reordering triggered by agent %d. \n', m);
            end
            
            eltimes{m} = eltimes{m}+extimes{m}(progress{m});
            progress{m} = progress{m}+1;
            
    end
    
            %visualization
            for i=makestep
                 if totaltime + eltimes{i} < 477
                fprintf('System %d, new current state %d, automaton state %d \n',sys(i).index, sys(i).curr, spec(i).curr);
                [xprevious,yprevious] = transform_coordinates(sys(i).previouscurr);
                [x,y]= transform_coordinates(sys(i).curr);
                switch i
                    case 1
                        color = 0.610;
                    case 2
                        color = 0.631;
                    case 3
                        color = 0.108;
                end
                grid((xprevious-1)*scale+scale/2+4+ offset(i):(x-1)*scale+scale/2+4+offset(i), (yprevious-1)*scale+scale/2+4+offset(i):(y-1)*scale+scale/2+4+offset(i)) = color;
                grid((x-1)*scale+scale/2+4+offset(i):(xprevious-1)*scale+scale/2+4+offset(i), (y-1)*scale+scale/2+4+offset(i):(yprevious-1)*scale+scale/2+4+offset(i)) = color;
                if sys(i).lastaction ~= 0
                    grid((x-1)*scale+scale/2+offset(i):(x-1)*scale+scale/2+8+offset(i),(y-1)*scale+scale/2+offset(i):(y-1)*scale+scale/2+8+offset(i)) = color;
                    if ((i==1) || (i==3))
                        offset(i) = offset(i) + 2;
                    else
                        offset(i) = offset(i) - 2;
                    end
                end
                imshow(grid)
                colormap(colorcube)
                pause(1)

                 end
            end
    
    while quit==0
        % do something
            for m=next
            fprintf('\n TS %d \n \n %d', sys(m).index, states{m,progress{m}});
            fprintf('   --%d-->   %d \n',act{m,progress{m}},  states{m,progress{m}+1});
            
            
            
            sys(m).previouscurr = sys(m).curr;
            sys((m)).lastaction=act{(m),progress{m}};
            sys((m)).curr = states{(m),progress{m}+1};
            spec((m)).curr = buchistates{m,progress{m}+1} ;
            
            if sys(m).lastaction~=0 && ismember(spec(m).curr,spec(m).F)
                perm = [setdiff(perm,[m],'stable'),m];
                fprintf('Reordering triggered by agent %d. \n', m);
            end
            
            eltimes{m} = eltimes{m}+extimes{m}(progress{m});
            progress{m} = progress{m}+1;
            end
            
            %visualization
            for i=next
                if totaltime + eltimes{i} < 477
                fprintf('System %d, new current state %d, automaton state %d \n',sys(i).index, sys(i).curr, spec(i).curr);
                [xprevious,yprevious] = transform_coordinates(sys(i).previouscurr);
                [x,y]= transform_coordinates(sys(i).curr);
                switch i
                    case 1
                        color = 0.610;
                    case 2
                        color = 0.631;
                    case 3
                        color = 0.108;
                end
                grid((xprevious-1)*scale+scale/2+4+ offset(i):(x-1)*scale+scale/2+4+offset(i), (yprevious-1)*scale+scale/2+4+offset(i):(y-1)*scale+scale/2+4+offset(i)) = color;
                grid((x-1)*scale+scale/2+4+offset(i):(xprevious-1)*scale+scale/2+4+offset(i), (y-1)*scale+scale/2+4+offset(i):(yprevious-1)*scale+scale/2+4+offset(i)) = color;
                if sys(i).lastaction ~= 0
                    grid((x-1)*scale+scale/2+offset(i):(x-1)*scale+scale/2+8+offset(i),(y-1)*scale+scale/2+offset(i):(y-1)*scale+scale/2+8+offset(i)) = color;
                    if ((i==1) || (i==3))
                        offset(i) = offset(i) + 2;
                    else
                        offset(i) = offset(i) - 2;
                    end
                end
                imshow(grid)
                colormap(colorcube)
                pause(1)
                end
            end
        
            
            %setting the next iteration
            next = 0;
            nextime = 10000;
            quit=0;
            
            
            for i = 1: N
                progress{i}
                if progress{i} < size(act,2)
                    if ~isempty(act{i,progress{i}}) && act{i,progress{i}} == 0
                       if nextime > eltimes{i} + extimes{i}(progress{i})
                        nextime = eltimes{i} + extimes{i}(progress{i});
                        next=i;
                       end
                    else
                        quit = quit+2^i;
                    end
                else
                    quit = quit+2^i;
                end
            end
            quit;
              switch quit
                  case 2
                      makestep = [2,3];
                  case 4
                      makestep = [1,3];
                  case 8
                      makestep = [1,2];
                  case 6
                      makestep = [3];
                  case 10
                      makestep = [2];
                  case 12
                      makestep = [1];
                  case 14
                      makestep = [];
                  otherwise
                      makestep = [];
              end
              makestep;
              %finishing the unfinished transitions
              for m=makestep
                  fprintf('\n TS %d \n \n %d', sys(m).index, states{m,progress{m}});
                  fprintf('   --%d-->   %d \n',act{m,progress{m}},  states{m,progress{m}+1});
                  
                  
                  sys(m).previouscurr = sys(m).curr;
                  sys((m)).lastaction=act{(m),progress{m}};
                  sys((m)).curr = states{(m),progress{m}+1};
                  spec((m)).curr = buchistates{m,progress{m}+1} ;
                  
                  if sys(m).lastaction~=0 && ismember(spec(m).curr,spec(m).F)
                      perm = [setdiff(perm,[m],'stable'),m];
                      fprintf('Reordering triggered by agent %d. \n', m);
                  end
                  
                  eltimes{m} = eltimes{m}+extimes{m}(progress{m});
                  progress{m} = progress{m}+1;
                  
              end
                  %visualization
                  for i=makestep
                      if totaltime + eltimes{m}<477
                      fprintf('System %d, new current state %d, automaton state %d \n',sys(i).index, sys(i).curr, spec(i).curr);
                      [xprevious,yprevious] = transform_coordinates(sys(i).previouscurr);
                      [x,y]= transform_coordinates(sys(i).curr);
                      switch i
                          case 1
                              color = 0.610;
                          case 2
                              color = 0.631;
                          case 3
                              color = 0.108;
                      end
                      grid((xprevious-1)*scale+scale/2+4+ offset(i):(x-1)*scale+scale/2+4+offset(i), (yprevious-1)*scale+scale/2+4+offset(i):(y-1)*scale+scale/2+4+offset(i)) = color;
                      grid((x-1)*scale+scale/2+4+offset(i):(xprevious-1)*scale+scale/2+4+offset(i), (y-1)*scale+scale/2+4+offset(i):(yprevious-1)*scale+scale/2+4+offset(i)) = color;
                      if sys(i).lastaction ~= 0
                          grid((x-1)*scale+scale/2+offset(i):(x-1)*scale+scale/2+8+offset(i),(y-1)*scale+scale/2+offset(i):(y-1)*scale+scale/2+8+offset(i)) = color;
                          if ((i==1) || (i==3))
                              offset(i) = offset(i) + 2;
                          else
                              offset(i) = offset(i) - 2;
                          end
                      end
                      imshow(grid)
                      colormap(colorcube)
                      pause(1)
                      end
                  end
     end  
    
    imshow(grid)
    colormap(colorcube)  
 
    fprintf('New permutation:'); perm
     
    

                 
%                 temp1 = spec(dep(1));
%                 temp2 = sys(dep(1));
%                 for j = dep(1):N-1
%                     spec(j) = spec(j+1);
%                     sys(j)=sys(j+1);
%                     perm(j+1) = j;
%                 end
%                 spec(N) = temp1;
%                 sys(N)=temp2;
%                 perm(dep(1)) = N;
%                 fprintf('Reordering happened. \n');
%             end
%         end


%%%%%%%%%
        %execution itself
        
        
        
%%%%%%%%%        
        
        totaltime=totaltime+max([eltimes{1} eltimes{2} eltimes{3}])
        
        if sys(1).lastaction == 0 
            reply = '';
        else
            counter = counter + 1;
            if totaltime < 477
                reply = '';
            else
                reply = input('Do you want more? ', 's');
            end
        end
        %reply = 'n';
        fprintf('\n');
    end
end
   
    
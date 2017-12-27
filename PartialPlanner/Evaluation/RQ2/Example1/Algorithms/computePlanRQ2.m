function [timeout,  Path EXPLICIT_STATES planningtime, solutionfound] = computePlanRQ2(sys,spec, environment, possiblepathenabled, timeoutval)
%COMPUTEPLAN Summary of this function goes here
%   Detailed explanation goes here
    timeout=0;
    planningtime=0;
    %% analysing the dependincies classes
    clear Buchi;
    clear B;
    clear P;

    solutionfound=0;
    N=size(sys,2);
    %dep = Dep{i};
    %M = length(dep);
    Path=[];
    %% compute the intersection automaton
    disp('computing the intersection');
    [Buchi, kmap, EXPLICIT_STATES] = intersection(spec);

%     visualizeBuchi(Buchi);
    disp('Computing the product');
    tStart = tic;
    [timeout, P, sys, spec, acceptingstates, acceptingFound] = productRQ2(sys,spec, Buchi, environment.x, environment.y, 0, timeoutval);
    tElapsed = toc(tStart);
    if(timeout)
        return;
    end
    planningtime=planningtime+tElapsed;
    if((acceptingFound==1))
        disp('searching for a definitive path to be performed');
        %[ DefinitivePath, found]=checkPlanPresence(oldPlans,[sys.curr],acceptingstates);
        %if(~(found==1))
            [DefinitivePath ] = searchActions(P, acceptingstates, N);
        %end
        solutionfound=1;
    end

    if(possiblepathenabled==1)
        disp('Computing the possible product');
        tStart = tic;
        [timeout, P, sys, spec, acceptingstates, pacceptingFound] = productRQ2(sys,spec, Buchi, environment.x, environment.y, 1, timeoutval);
        tElapsed = toc(tStart);
         if(timeout)
             return;
         end
        planningtime=planningtime+tElapsed;
        if((pacceptingFound==1))
            %disp('STEP 6: searcing for a path to be performed');
            %[ PossiblePath, found]=checkPlanPresence(oldPlans,[sys.curr],acceptingstates);
            %if(~(found==1))
                [PossiblePath ] = searchActions(P, acceptingstates, N);
           % end
            solutionfound=1;
        end

    end

    if(possiblepathenabled==1)
        if(pacceptingFound==0)
            disp('no definitive or possible plan available');
            return;
        else
            if(acceptingFound==0 && pacceptingFound==1)
                disp('no definitive plan available');
                Path=PossiblePath;
            else
                disp('the shortest between definitive and possible plan is chosen');
                if(size(DefinitivePath,1)<size(PossiblePath,1))
                    Path=DefinitivePath;
                else
                    Path=PossiblePath;
                end
            end
        end
    else
        if(acceptingFound==0)
            disp('no definitive plan available');
            return;
        else
            disp('definitive plan found');
            Path=DefinitivePath;
        end
    end
  %  Path=Path(1:size(Path,1)-1,:);
end


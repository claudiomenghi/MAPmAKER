function mapmaker_exp(scenario, experiment, location)
    clc
    close all

    if ~exist('location','var')
        % location not specified, perform custom experiment
        location = 0;
    else
        warning('off','all')
        current_folder=pwd;

        path='%s/MAPmAKER';
        addpath(sprintf(path, current_folder));

        path='%s/MAPmAKER/Visualization';
        addpath(sprintf(path, current_folder));

        path='%s/MAPmAKER/Utils';
        addpath(sprintf(path, current_folder));

        path='%s/MAPmAKER/Algorithms';
        addpath(sprintf(path, current_folder));

        % If only the running example for the paper is required
        if strcmp(location, 'RunningExample')
            path='%s/RunningExample/%s';
            addpath(sprintf(path, current_folder, experiment));        
        else
            % location specified, replicate experiment  
            path='%s/Evaluation/%s/%s/%s';
            addpath(sprintf(path, current_folder, location, scenario, experiment));

            path='%s/Evaluation/%s/%s/Algorithms';
            addpath(sprintf(path, current_folder, location, scenario));

            path='%s/ReplicationPackage/%s/%s/%s';
            addpath(sprintf(path, current_folder, location, scenario, experiment));
        end
        experiment(1)=lower(experiment(1));
        eval(experiment)
    end
end
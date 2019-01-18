function mapmaker_exp(RQ, example, experiment)
    
    warning('off','all')
    current_folder=pwd;

    path='%s/Evaluation/%s/%s/%s';
    addpath(sprintf(path, current_folder, RQ, example, experiment));
    
    path='%s/Evaluation/%s/%s/Algorithms';
    addpath(sprintf(path, current_folder, RQ, example));
    
    path='%s/ReplicationPackage/%s/%s/%s';
    addpath(sprintf(path, current_folder, RQ, example, experiment));
    
    path='%s/MAPmAKER';
    addpath(sprintf(path, current_folder));
    
    path='%s/MAPmAKER/Visualization';
    addpath(sprintf(path, current_folder));
    
    path='%s/MAPmAKER/Utils';
    addpath(sprintf(path, current_folder));
    
    path='%s/MAPmAKER/Algorithms';
    addpath(sprintf(path, current_folder));
    
    experiment(1)=lower(experiment(1));
    eval(experiment)
    
end
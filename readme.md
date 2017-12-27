
# MAPmAKER organization

- The extended verion of the paper in the file ICSE_extended.pdf .
- Videos of the performed experiments. Folder ./ResultsPaper contains all the videos related with our evaluation and specifically with RQ1. 
These videos are grouped in two folder containing the two examples.
Each of these folder contains a video for each ID for each step. For example, there two videos named “movie_1_Step1” and “movie_1_Step2” refer to the configuration marked with ID 1.
- Videos of the running example
- The source code of the tool in the folder MAPMAKER
- A replication package that allows to replicate the experiment

# Replicate an experiment
enter the folder MAPMAKER

The experimentLauncher.m file allows us to launch he experiments in an easy way. The only thing that we must do is to specify and add the paths to the folder that contain the experiment that we want to run. For example, if we to launch the RunningExample the added paths should be:

addpath('./MAPmAKER/RunningExample/Experiment1/');
experiment1;

To replicate the data presented in the Table 1 we should add the following paths:

addpath('./MAPmAKER/Evaluation/RQ1/Example1/Experiment1');
addpath('./MAPmAKER/Evaluation/RQ1/Example1/Algorithms/');
addpath('./MAPmAKER/ReplicationPackage/RQ1/Example1/Experiment1/');
experiment1;

Here we can change some parts of the paths in order to perform different experiments. For example, if we want to change the map of the environment the example must be changed. In that case, we can opt between Example1 or Example2. Then, the previous paths would be changed to:

addpath('./MAPmAKER/Evaluation/RQ1/Example2/Experiment1');
addpath('./MAPmAKER/Evaluation/RQ1/Example2/Algorithms/');
addpath('./MAPmAKER/ReplicationPackage/RQ1/Example2/Experiment1/');
experiment1;

Not only the map can be changed but also the research question experiment or the experiment to be performed (we have experiments from 1 to 3, but more experiments can be performed and stored in these paths). 

For creating new models we added a series of scripts that are stored in ./MAPmaKER/Evaluation/RQx/Exampley/Experimentz/RandomModelGenerator. New maps can be created customising the script Environment.m. But the fastest way of creating new models is just calling to the randomModelGenerator function. Its form is the following:

function [Models] =randomModelGenerator(numberOfInitialConfigurations, numberOfPartialInfoConfigurations, displayEnabled)

Here we can specify the number of initial configurations for the robot and the number of different partial configurations of the environment. If we want the experiment to be displayed, the variable displayEnabled must be set to 1.


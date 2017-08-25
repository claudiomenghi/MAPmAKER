We created the folder containing this document in order to make easier to understand our work. It also allows a reviewer to replicate the experiments that we performed for this paper.

In the folder ./ResultsPaper some videos that represents our algorithm working are stored. These videos are split in two other folders, one for the experiments regarding the first Research Question and one for the Running Example. For example, there two videos named Òmovie_RunningExample_Step1Ó and Òmovie_RunningExample_Step2Ó stored in the latter folder. They display both steps of the running example described in the paper. It is just an experiment that serves as an example for a better understanding of MAPmAKER. 

On the other hand, the folder RQ1 contains the data corresponding with both examples (the two presented scenarios) and the 3 different experiments (each one testing a type of uncertainty). These folders contain a certain number of videos named Òmovie_i_Step1Ó or Òmovie_i_Step2Ó. They represent the number of experiments performed in order to obtain the data that is presented in the Table 1 of the paper. In this case, we recreated 9 experiments (3 robot models and 3 environment models).

-How to launch an experiment

The experimentLauncher.m file allows us to launch he experiments in an easy way. The only thing that we must do is to specify and add the paths to the folder that contain the experiment that we want to run. For example, if we just want to launch a short example that does not take much time to compute we could launch the RunningExample. In that case, the specified paths should be:

addpath('./MAPmAKER/RunningExample/Experiment1/');
experiment1;

On the other hand, if we want to replicate the data presented in the Table 1 we should add the following paths:

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


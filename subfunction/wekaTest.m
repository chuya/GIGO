%%% include jar libraries to matlab environment:
javaaddpath('C:\Program Files\Weka-3-6\weka.jar');
addpath('..\lib\matlab2weka');
%%% importing of classes
import java.util.Enumeration;
import java.lang.String;
import weka.classifiers.Classifier;
import weka.classifiers.functions.supportVector.*;
% import weka.classifiers.Evaluation;
import weka.classifiers.functions.SMO;
import java.io.FileReader 
import weka.core.Instances
import weka.core.Utils.*;
import weka.core.Attribute
import java.lang.System
%%% Reading and configuring treaining set
reader = javaObject('java.io.FileReader','../temp/wekaformat/wekaData.arff');
dataset = javaObject('weka.core.Instances',reader);
dataset.setClassIndex(dataset.numAttributes() - 1);
% %%% Reading and Configuring testing set (in case we want to perform train/test evaluation)
% reader1 = javaObject('java.io.FileReader','TestSetOfInstances.arff');
% testset = javaObject('weka.core.Instances',reader1);
% testset.setClassIndex(testset.numAttributes() - 1);
% %%% getting the parameters of an arff file
% relationName = char(dataset.relationName);
% numAttr = dataset.numAttributes;
% numInst = dataset.numInstances;
% %%% creating an object of class J48 and setup the default options
% classifier = javaObject('weka.classifiers.functions.SMO');
% classifier.setOptions(weka.core.Utils.splitOptions('-C 1.0 -L 0.001 -P 1.0E-12 -N 2 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 1.0'));
classifier = weka.core.SerializationHelper.read('temp\features_20150110\SMO.model');
a = [];
attr = {};
for i = 1:373
    a(i) = 0.5; % !!!!here!!!!
    attr{i} = strcat(num2str(i),'f');
end
instance = matlab2weka('test',attr,a);
disp(wekaClassify(instance,classifier));
% classifier.distributionForInstance(instance); %dataset.instance(1));
% %%% string for setting the options
% v1 = String('-t');
% v2 = String('TrainSetOfInstances.arff');
% v3 = String('-x'); %%% if we want cross-validation
% v4 = String('10'); %%% with number of folds
% options = cat(1,v1,v2,v3,v4);
% %%% Creation of classification Model
% classifier.buildClassifier(dataset);
% %%% evaluation of the Classifier with options
% weka.classifiers.Evaluation.evaluateModel(classifier,options)
% %%% creating an object containing the evaluations
% eval = weka.classifiers.Evaluation(dataset);
% eval.evaluateModel(classifier, options1);
% %%% - this part works properly
% %%% printing the parameters of the evaluation
% fprintf('=== Run information ===\n\n')
% fprintf('Scheme: %s %s\n', ...
% char(classifier.getClass().getName()), ...
% char(weka.core.Utils.joinOptions(classifier.getOptions())) )
% fprintf('Relation: %s\n', char(dataset.relationName))
% fprintf('Instances: %d\n', dataset.numInstances)
% fprintf('Attributes: %d\n\n', dataset.numAttributes)
% %%% this part works properly
% fprintf('=== Classifier model ===\n\n')
% disp( char(classifier.toString()) )
% %%% this part works properly
% fprintf('=== Summary ===\n')
% disp( char(eval.toSummaryString()) )
% disp( char(eval.toClassDetailsString()) )
% disp( char(eval.toMatrixString()) )
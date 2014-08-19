%{
Objective:
A multiclass SVM classifier which classifies different PCB defects.
input:
feature vector x (n*1 matrix)
category (float)
dimensions
output:

example:
%}
clear all
load fisheriris
% or other sample data sets from here for testing:
% http://www.mathworks.com/help/stats/_bq9uxn4.html

svmtrain
svmclassify
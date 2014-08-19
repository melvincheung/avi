%{
Objective: (minitool) To read and rename stored data files (e.g. 003a_pad and 004a_pad)
%}

clear all
close all
load('003a_pad.mat');
pad003 = pcb_pad;
load('004a_pad.mat');
pad004 = pcb_pad;
clear pcb_pad;
load('cm_cs_aligned.mat'); %cm_cs
load('pad_pos.mat'); %pad
load('003a.mat');
pcb003 = pcb;
load('004a.mat');
pcb004 = pcb;
clear pcb;
load('err_subtract.mat');
% pad004 = load('004a_pad.mat');
clear all; close all; clc

addpath 'Data'
addpath 'Figures'
addpath 'Wordsets'
addpath 'Helper scripts'
addpath 'Analysis code'
addpath 'MRP_Experiments'

rawData = importFile('Data/Gallagher2020_data/MRP_20Q_fixed_v1_raw.csv',[1,Inf]);

importWords1 = importWords('Wordsets/Koh2020_wordsets/zhao_words_133_267_all.csv');
importWords2 = importWords('Wordsets/Koh2020_wordsets/zhao_words_67_all.csv');
importWords = [importWords1;importWords2];

[G,imgIDs] = findgroups(importWords.img_id);

getCleanData; 
addRow_RespConf;
addRow_Accuracy;
sortColumns;

import_word2vec_scores;
workFlow_dataAnalysis;

get_heatMaps;
MRP_wordWise_AUC;
MRP_wordWise_fullMatrixAUC;
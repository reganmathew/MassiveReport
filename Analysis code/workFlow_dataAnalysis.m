clc; 

%% clean data again in case of NaN from computation errors

TF = ismissing(cleanData,{'centre_mouse' 'practice' 'reveal' 'reset' 'test' NaN -99});
cleanData(any(TF,2),:)=[];

fullSample = cleanData(:,{'subject','imageName','trialcode','Accuracy'});

%% get subject evaluation overview

[G,subject]=findgroups(cleanData.subject);
subjectPerformance = table(subject);
subjectPerformance.trialCount=splitapply(@numel,cleanData.subject,G);
% disp(subjectPerformance);

%% Set up the cut-off criteria

trialCutOff = median(subjectPerformance.trialCount);
catchCutOff = 0.7999;
RTCutOff = 599;

%% see who didn't complete all trials

% identify subjects who don't complete all trials
dropOuts = subjectPerformance;
dropOuts(any(dropOuts.trialCount>=trialCutOff,2),:)=[];
% disp(dropOuts);

%% see which subjects failed catch trials

% identify the catch trials
catch_cleanData = grpstats(fullSample,{'trialcode','subject'},'mean','DataVars',{'Accuracy'});
TF = ismissing(catch_cleanData,{'practice_absent_trial' 'practice_present_trial' 'present_trial' 'absent_trial'  NaN -99});
catch_cleanData(any(TF,2),:)=[];
[G,subject]=findgroups(catch_cleanData.subject);
catchAccuracy = table(subject);
catchAccuracy.catchAcc = splitapply(@mean, catch_cleanData.mean_Accuracy,G);
% disp(catchAccuracy); % display subject catch performance table

% identify subjects who fail catch trials
rmBots = catchAccuracy;
rmBots(any(rmBots.catchAcc>catchCutOff,2),:)=[];
% disp(rmBots);


%% see which subjects respond too quickly

% identify the fast responders
RT_cleanData = grpstats(cleanData,{'trialcode','subject'},'median','DataVars',{'latency'});
TF = ismissing(RT_cleanData,{'practice_absent_trial' 'practice_present_trial' 'catch_present_trial' 'catch_absent_trial'  NaN -99});
RT_cleanData(any(TF,2),:)=[];
[G,subject]=findgroups(RT_cleanData.subject);
subjectRT = table(subject);
subjectRT.latency = splitapply(@mean, RT_cleanData.median_latency,G);
% disp(subjectRT); % display subject catch performance table

% identify subjects who fail catch trials
rmRT = subjectRT;
rmRT(any(rmRT.latency>RTCutOff,2),:)=[];
% disp(rmRT);

%% compile the pilot sample (sans excluded ppl)

% excluded subjects
rmSubjects = [dropOuts.subject; rmBots.subject; rmRT.subject];
rmSubjects = unique(rmSubjects);

% identify subjects meet inclusion criteria
pilotSample = cleanData;
TF = ismissing(pilotSample,{rmSubjects});
pilotSample(any(TF,2),:)=[];
% disp(pilotSample);

%% get summary data for the final pilot sample

% identify the catch trials
catch_pilotSample = grpstats(pilotSample,{'trialcode','subject'},'mean','DataVars',{'Accuracy'});
TF = ismissing(catch_pilotSample,{'practice_absent_trial' 'practice_present_trial' 'present_trial' 'absent_trial'  rmSubjects NaN -99});
catch_pilotSample(any(TF,2),:)=[];
[G,catch_group]=findgroups(catch_pilotSample.subject);
catch_group = table(catch_group);
catch_group.catchAcc = splitapply(@mean,catch_pilotSample.mean_Accuracy,G);

final_pilotSample = pilotSample;
TF = ismissing(final_pilotSample,{'practice_absent_trial' 'practice_present_trial' 'catch_present_trial' 'catch_absent_trial'  rmSubjects NaN -99});
final_pilotSample(any(TF,2),:)=[];
% disp(final_pilotSample);

removed_pilotSample = cleanData;
TF = ismissing(removed_pilotSample,{'practice_absent_trial' 'practice_present_trial' 'catch_present_trial' 'catch_absent_trial'  final_pilotSample.subject NaN -99});
removed_pilotSample(any(TF,2),:)=[];
% disp(removed_pilotSample);

% get removed subject evaluation overview
[G,rmSubjects]=findgroups(removed_pilotSample.subject);
rmSubjectPerformance = table(rmSubjects);
% rmSubjectPerformance.catchAcc=catch_group.catchAcc;
rmSubjectPerformance.trialCount=splitapply(@numel,removed_pilotSample.subject,G);
rmSubjectPerformance.meanAcc=splitapply(@mean,removed_pilotSample.Accuracy,G);
rmSubjectPerformance.meanRespConf=splitapply(@mean,removed_pilotSample.RespConf,G);
rmSubjectPerformance.meanConf=splitapply(@mean,removed_pilotSample.Confidence,G);
rmSubjectPerformance.medianRT=splitapply(@median,removed_pilotSample.latency,G);
disp(rmSubjectPerformance);

% get subject evaluation overview
[G,subject]=findgroups(final_pilotSample.subject);
subjectPerformance = table(subject);
subjectPerformance.catchAcc=catch_group.catchAcc;
subjectPerformance.trialCount=splitapply(@numel,final_pilotSample.subject,G);
subjectPerformance.meanAcc=splitapply(@mean,final_pilotSample.Accuracy,G);
subjectPerformance.meanRespConf=splitapply(@mean,final_pilotSample.RespConf,G);
subjectPerformance.meanConf=splitapply(@mean,final_pilotSample.Confidence,G);
subjectPerformance.medianRT=splitapply(@median,final_pilotSample.latency,G);
disp(subjectPerformance);

%% get separate wordlists for present and absent trials

separateWordLists = final_pilotSample(:,{'imageName','trialcode','word'});
presentImageWords = unique(separateWordLists);
absentImageWords = unique(separateWordLists);
absentImageWords(any(absentImageWords.trialcode=="present_trial",2),:)=[];
presentImageWords(any(presentImageWords.trialcode=="absent_trial",2),:)=[];

%% Following code is under construction !!

% % Image-level analyses
[G,imageName]=findgroups(cleanData.imageName);
imageAnalysis = table(imageName);
imageAnalysis.trialCount=splitapply(@numel,cleanData.imageName,G);
imageAnalysis.medianRT=splitapply(@median,cleanData.latency,G);
imageAnalysis.meanAcc=splitapply(@mean,cleanData.Accuracy,G);
imageAnalysis.meanRespConf=splitapply(@mean,cleanData.RespConf,G);
imageAnalysis.meanConf=splitapply(@mean,cleanData.Confidence,G);
disp(imageAnalysis);

% Trial-level analyses
[G,trialcode]=findgroups(cleanData.trialcode);
trialcodePerformance = table(trialcode);
trialcodePerformance.trialCount=splitapply(@numel,cleanData.trialcode,G);
trialcodePerformance.medianRT=splitapply(@median,cleanData.latency,G);
trialcodePerformance.meanAcc=splitapply(@mean,cleanData.Accuracy,G);
trialcodePerformance.meanRespConf=splitapply(@mean,cleanData.RespConf,G);
trialcodePerformance.meanConf=splitapply(@mean,cleanData.Confidence,G);
disp(trialcodePerformance);

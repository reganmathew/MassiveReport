clc; close all

tempArray = final_pilotSample(:,{'subject','imageName','trialcode','word','response','RespConf'});
TF = ismissing(tempArray,{'practice_absent_trial' 'practice_present_trial' 'catch_present_trial' 'catch_absent_trial'  NaN -99});
tempArray(any(TF,2),:)=[];
tempArray2 = grpstats(tempArray,{'imageName','trialcode','word','subject'},'mean','DataVars',{'RespConf'});

[G,criteria]=findgroups(tempArray.RespConf);
criteria = string(criteria);

[G,subjects]=findgroups(tempArray.subject);
subjects = string(subjects);

[G,words]=findgroups(tempArray.word);
words = string(words);

nCriteria = 8;
nsubjects = 15;
C = zeros(nsubjects,nCriteria);
% disp(tempArray2);


nImages = 5;
nSubjects = length(subjectPerformance.subject);
nWords = mode(subjectPerformance.trialCount)/nImages;
AUC = zeros(nWords,nWords,nImages);
trialTypes = 1;

respDB = zeros(nWords,nCriteria,trialTypes,nImages);

count = 0;
for image = 1:nImages
    image;
    for trialType = 1:trialTypes
%         figure; tiledlayout(2,5);
        trialType;
        for word = 1:nWords
            tally = zeros(1,8);
            for subject = 1:nSubjects
                count = count+1;
                r = tempArray2.mean_RespConf(count);
                f = find(criteria==num2str(r));
                tally(f) = tally(f) +1;
            end
            respDB(word,:,trialType,image) = tally;
%             disp(tally);
            nexttile
%             plot(tally);
%             xticklabels(criteria);
%             xlabel('decision x confidence');
%             ylabel('frequency');
%             title(tempArray2.word(count));
%             pause(2);
        end
    end
    
%     figure;
%     plot(mean(respDB(:,:,trialType,image)))
%     xticklabels(criteria);
%             xlabel('decision x confidence');
%             ylabel('frequency');
end
'finished'
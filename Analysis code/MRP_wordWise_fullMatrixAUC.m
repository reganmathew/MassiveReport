close all; clc

%% set up data table

% this code block gets a clean data table with only test trials (i.e., those ready for analysis).
tempArray = final_pilotSample(:,{'subject','imageName','trialcode','word','RespConf'});
tempArray2 = grpstats(tempArray,{'imageName','trialcode','word'},'mean','DataVars',{'RespConf'});
summaryT=sortrows(tempArray2);

%% Assign variables

imageNames = unique(tempArray.imageName);
subjectNames = unique(tempArray.subject);
criteria = string(unique(tempArray.RespConf));
trialTypes = unique(tempArray.trialcode);
allWords = tempArray.word;

nImages = length(imageNames);
nSubjects = length(subjectNames);
nCriteria = length(criteria);
nTrials = length(allWords)/nSubjects/nImages;
nTrialTypes = length(trialTypes);

%% get Dec x Conf per word

respDB = zeros(nTrials,nCriteria,nImages);
results = struct([]);
for image = 1:nImages
    
    listByImage = tempArray(tempArray.imageName==imageNames(image),:);
    imageSummaryTable = tempArray2(tempArray2.imageName==imageNames(image),:);
    
    PresentTrialType = listByImage(listByImage.trialcode==trialTypes(2),:);
    PresentWordList = unique(PresentTrialType.word);
    AbsentTrialType = listByImage(listByImage.trialcode==trialTypes(1),:);
    AbsentWordList = unique(AbsentTrialType.word);
    listByTrialType = [PresentTrialType; AbsentTrialType];
        
    currentWordList = [PresentWordList; AbsentWordList];
    for word = 1:length(currentWordList)
        tally = zeros(1,8);
        listByWord = listByTrialType(listByTrialType.word==currentWordList(word),:);
        for subject = 1:nSubjects
            r = listByWord.RespConf(subject);
            f = find(criteria==num2str(r));
            tally(f) = tally(f) +1;
        end
        respDB(word,:,image) = tally;
    end
    
    nTrials = length(currentWordList);
    AUC = zeros(nTrials,nTrials);
    
    % separate rows for each present word
    for present_word = 1:nTrials % present words = 50% of total words
        present = [0 respDB(present_word,:,image)]; % adds a 0 to TPR for the AUC calculation
        TPR = cumsum(present/nSubjects); % gets the TPR
        
        % separate columns for each absent word
        for absent_word = 1:nTrials % absent words = 50% of total words
            absent = [0 respDB(absent_word,:,image)]; % adds a 0 to FPR for the AUC calculation
            FPR = cumsum(absent/nSubjects); % gets the FPR
            
            % gets an AUC val for each absent/present word pair, for each of nImages (round to 2 dec)
            AUC(present_word,absent_word) = round(AreaUnderROC([FPR; TPR]'),2);
        end
    end
    results(image).data = AUC;
end
disp(respDB);

%% Display figure
score = struct([]);
for fig = 1:nImages
    g=figure; g.Color='white';
    tempResults = results(fig).data *100;
    allPresentWords = importWords(importWords.img_id==imgIDs(fig),:);
    masterPresentWords = table(allPresentWords.stem_word);
    %
    summaryT = tempArray2(tempArray2.imageName==imageNames(fig),:);
    Absent = sortrows(summaryT(summaryT.trialcode=='absent_trial',:));
    Present = sortrows(summaryT(summaryT.trialcode=='present_trial',:));
    
    y = Present.word; x= Absent.word;
    LIA = ismember(table(Absent.word),masterPresentWords,'rows');
    x(any(LIA,2),:)=[]; new_y = [y; x]; new_x = [y' x'];
    
    LIA = [zeros(length(y),1);LIA];
    tempResults(:,any(LIA,2))=[];
    tempResults(any(LIA,2),:)=[];
    
    heatmap(new_x,new_y,tempResults);
    colormap(autumn); caxis([0 100]);
%     set(gca,'FontSize',20);
%     print -djpeg
    
    % this still needs to be calc'd properly
    trianglePresent = triu(tempResults(1:10, 1:10,1));
    %     a=sum(trianglePresent); a=a-50; a=a(2:end);
    a=trianglePresent(1:end-1,2:end);
    clear b; count=0
    for i=1:length(a)
        for j = 1:i
            count=count+1;
            b(count)=a(j,i);
        end
    end
    
    %     for i=1:length(a)
    %         b(i)=a(i)/i;
    %     end
    c(fig,1)=mean(b);
    c(fig,2)=std(b);
    
    
    score(fig).data = word2vec_scores(new_x,new_y);
    tempMat_w2v = table2array(score(fig).data);
    corr(tempMat_w2v,tempResults)
    heatmap(new_x,new_y,tempMat_w2v)
    colormap(autumn); caxis([-1 1]);
    print -djpeg
    
    disp(new_y);
    disp(new_x);
%     pause(5);
    disp(tempResults);
%     pause(5);
    disp(tempMat_w2v);
    pause(5);
    
    close all;
%     tempCorr_w2v = corr(tempMat_w2v,tempResults);
%     heatmap(new_x,new_y,tempCorr_w2v)
%     colormap(autumn); caxis([-1 1]);
%     print -djpeg
end

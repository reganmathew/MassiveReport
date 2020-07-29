% close all; clc

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

% tempAUC = zeros(nTrials/2,nTrials/2,nImages); % nWords/2 because 50% = absent, 50% = present
% results = struct([]);

%% get Dec x Conf per word

% AUC = zeros(nTrials/2,nTrials/2,nImages); 
respDB = zeros(nTrials/2,nCriteria,nTrialTypes,nImages);
% results = struct([]);
for image = 1:nImages
    
    listByImage = tempArray(tempArray.imageName==imageNames(image),:);
    imageSummaryTable = tempArray2(tempArray2.imageName==imageNames(image),:);    
    
    
%     [PR,tempTally] = deal(zeros(nTrialTypes,nCriteria+1));
    for trialType = 1:numel(trialTypes)
        listByTrialType = listByImage(listByImage.trialcode==trialTypes(trialType),:);
        currentWordList = unique(listByTrialType.word);
        for word = 1:length(currentWordList)
            tally = zeros(1,8);
            listByWord = listByTrialType(listByTrialType.word==currentWordList(word),:);
            for subject = 1:nSubjects
                r = listByWord.RespConf(subject);
                f = find(criteria==num2str(r));
                tally(f) = tally(f) +1;
            end
            respDB(word,:,trialType,image) = tally;
%             tempTally(trialType,:) = [0 tally];
%             PR(trialType,:) = cumsum(tempTally(trialType,:))/nSubjects;
        end
%         AUC(present_word,absent_word,image) = round(AreaUnderROC([PR(1,:); PR(2,:)]'),2);
    end
%     results(image).data = respDB(:,:,:,image);  
%     
%     % separate rows for each present word
%     for present_word = 1:nWords/2 % present words = 50% of total words
%         present = [0 respDB(present_word,:,2,image)]; % adds a 0 to TPR for the AUC calculation
%         TPR = cumsum(present/nSubjects); % gets the TPR
%         
%         % separate columns for each absent word
%         for absent_word = 1:nWords/2 % absent words = 50% of total words
%             absent = [0 respDB(absent_word,:,1,image)]; % adds a 0 to FPR for the AUC calculation
%             FPR = cumsum(absent/nSubjects); % gets the FPR
%             
%             % gets an AUC val for each absent/present word pair, for each of nImages (round to 2 dec) 
%             AUC(present_word,absent_word,image) = round(AreaUnderROC([FPR; TPR]'),2);
%         end
%     end
end
disp(respDB);

%% run AUC calc

AUC = zeros(nTrials/2,nTrials/2,nImages);
for image = 1:nImages 
    %creates a separate matrix for each image
    
    % separate rows for each present word
    for present_word = 1:nTrials/2 % present words = 50% of total words
        present = [0 respDB(present_word,:,2,image)]; % adds a 0 to TPR for the AUC calculation
        TPR = cumsum(present/nSubjects); % gets the TPR
        
        % separate columns for each absent word
        for absent_word = 1:nTrials/2 % absent words = 50% of total words
            absent = [0 respDB(absent_word,:,1,image)]; % adds a 0 to FPR for the AUC calculation
            FPR = cumsum(absent/nSubjects); % gets the FPR
            
            % gets an AUC val for each absent/present word pair, for each of nImages (round to 2 dec) 
            AUC(present_word,absent_word,image) = round(AreaUnderROC([FPR; TPR]'),2);
        end
    end
end
disp(AUC); 

%% Display figure

% the table, T, which was the tempArray2 table above, contains all the x,y labels
% half of this code makes this more readable by assigning absent and present labels

imageCount=0; 
%   tiledlayout('flow');
tempMat=zeros(5,1); AUC = 100*AUC; % turn AUC into a percentage

results = struct([]);
remove = 1;
if remove == 0
    quadMean = zeros(5,2); 
end
% g=figure;
for fig = 1:nImages
    g=figure; g.Color='white';
    tempResults = AUC(:,:,fig);
    
    allPresentWords = importWords(importWords.img_id==imgIDs(fig),:);
    masterPresentWords = table(allPresentWords.stem_word);
    %     
    summaryT = tempArray2(tempArray2.imageName==imageNames(fig),:);
    Absent = sortrows(summaryT(summaryT.trialcode=='absent_trial',:));
    Present = sortrows(summaryT(summaryT.trialcode=='present_trial',:));

    y = Present.word; x = Absent.word; 
    
    if remove == 1
        LIA = ismember(table(Absent.word),masterPresentWords,'rows');
        x(any(LIA,2),:)=[];
        tempResults(:,any(LIA,2))=[];
        while size(tempResults,2)-size(x,1)>0
            tempResults(:,end) = [];
        end
    end
    
    
%     % this is not the cleanest. It's simply looping through all words to
%     % create the x and y labels from absent and present words.
%     Absent = summaryT(imageCount*nWords+1:imageCount*nWords+(nWords/2),:);
%     Present = summaryT(imageCount*nWords+(nWords/2+1):imageCount*nWords+nWords,:);
%     imageCount = imageCount+1;
    
%     nexttile; % all AUC matrices in one fig
% subplot(2,3,fig);
    heatmap(x,y,tempResults);
    colormap(autumn); caxis([0 100]);
    quadMean(fig,remove+1) = mean(tempResults(:));
    
    %     tempAUC = AUC(:,:,fig); tempC = C(:,:,fig); 
    %     tempMat(fig) = corr(tempAUC(:),tempC(:))
            set(gca,'FontSize',30);
    
    results(fig).data = tempResults;
%     size(tempResults)
%     size(x)
end 
disp(quadMean);

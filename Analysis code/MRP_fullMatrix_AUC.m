close all; clc

%% run AUC calc

close all; clc

% before running this code you'd need the respDB var, which is a matrix containing all subject responses and 
% the subjectPerformance table, both calculated elsewhere. I can provide code if a working example is desired. 

%% set up data table

% this code block gets a clean data table with only test trials (i.e., those ready for analysis). 
tempArray = final_pilotSample(:,{'subject','imageName','trialcode','word','RespConf'});
tempArray2 = grpstats(tempArray,{'imageName','trialcode','word'},'mean','DataVars',{'RespConf'});
TF = ismissing(tempArray2,{'practice_absent_trial' 'practice_present_trial' 'catch_present_trial' 'catch_absent_trial'  NaN -99});
tempArray2(any(TF,2),:)=[];
T=tempArray2;

%% run AUC calc

nImages = 5; % this is hardcoded for now, but can be determined from results output
nSubjects = length(subjectPerformance.subject); % can be hard-coded, better to do dynamically
nWords = mode(subjectPerformance.trialCount)/nImages; % not optimally coded, but we delete subjects who don't finish all trials
AUC = zeros(nWords,nWords,nImages); % nWords/2 because 50% = absent, 50% = present

for image = 1:nImages 
    %creates a separate matrix for each image
    
    % separate rows for each present word
    for wordProbe1 = 1:nWords % present words = 50% of total words
        present = [0 respDB(wordProbe1,:,1,image)]; % adds a 0 to TPR for the AUC calculation
        TPR = cumsum(present/nSubjects); % gets the TPR
        
        % separate columns for each absent word
        for wordProbe2 = 1:nWords % absent words = 50% of total words
            absent = [0 respDB(wordProbe2,:,1,image)]; % adds a 0 to FPR for the AUC calculation
            FPR = cumsum(absent/nSubjects); % gets the FPR
            
            % gets an AUC val for each absent/present word pair, for each of nImages (round to 2 dec) 
            AUC(wordProbe2,wordProbe1,image) = round(AreaUnderROC([FPR; TPR]'),2);
        end
    end
    
end
disp(AUC); 


% AUC matrix for each image

%% Display figure

% the table, T, which was the tempArray2 table above, contains all the x,y labels
% half of this code makes this more readable by assigning absent and present labels

imageCount=0; 
g=figure; g.Color='white'; tiledlayout('flow');
tempMat=zeros(5,1); AUC = 100*AUC; % turn AUC into a percentage
for fig = 1:1
    
    % this is not the cleanest. It's simply looping through all words to
    % create the x and y labels from absent and present words.
    Absent = T(imageCount*nWords+1:imageCount*nWords+(nWords/2),:);
    Present = T(imageCount*nWords+(nWords/2+1):imageCount*nWords+nWords,:);
    wordList = [Present; Absent];
    imageCount = imageCount+1;
    
    nexttile; % all AUC matrices in one fig
    heatmap(wordList.word,wordList.word,AUC(:,:,fig));
    colormap(autumn); caxis([0 100]);
    
    tempAUC = AUC(:,:,fig);
    trianglePresent = triu( tempAUC(1:10, 1:10,1 ) );
    a=sum(trianglePresent);
    for i=1:length(a);
        b(i)=a(i)/i;
    end
    c(fig)=mean(b);
    
%      tempC = C(:,:,fig); 
%     tempMat(fig) = corr(tempAUC(:),tempC(:))
    set(gca,'FontSize',20)
end 
disp(c);
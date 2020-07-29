close all; clc

%% run AUC calc

nImages = 5; % this is hardcoded for now, but can be determined from results output
nSubjects = length(subjectPerformance.subject); % can be hard-coded, better to do dynamically
nWords = mode(subjectPerformance.trialCount)/nImages; % not optimally coded, but we delete subjects who don't finish all trials
AUC = zeros(nWords/2,nWords/2,nImages); % nWords/2 because 50% = absent, 50% = present

for image = 1:nImages
    %creates a separate matrix for each image
    
    % separate rows for each present word
    for present1_word = 1:nWords/2 % present words = 50% of total words
        present1 = [0 respDB(present1_word,:,2,image)]; % adds a 0 to TPR for the AUC calculation
        TPR = cumsum(present1/nSubjects); % gets the TPR
        
        % separate columns for each absent word
        for present2_word = 1:nWords/2 % absent words = 50% of total words
            present2 = [0 respDB(present2_word,:,2,image)]; % adds a 0 to FPR for the AUC calculation
            FPR = cumsum(present2/nSubjects); % gets the FPR
            
            % gets an AUC val for each absent/present word pair, for each of nImages (round to 2 dec)
            AUC(present1_word,present2_word,image) = round(AreaUnderROC([FPR; TPR]'),2);
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
for fig = 1:nImages
    
    % this is not the cleanest. It's simply looping through all words to
    % create the x and y labels from absent and present words.
    Absent = T(imageCount*nWords+1:imageCount*nWords+(nWords/2),:);
    Present = T(imageCount*nWords+(nWords/2+1):imageCount*nWords+nWords,:);
    imageCount = imageCount+1;
    
    nexttile; % all AUC matrices in one fig
    heatmap(Present.word,Present.word,AUC(:,:,fig));
    colormap(autumn); caxis([0 100]);
    %
    tempAUC = AUC(:,:,fig);
    trianglePresent = triu( tempAUC(1:10, 1:10,1 ) );
    a=sum(trianglePresent); a=a-50; a=a(2:end);
    for i=1:length(a)
        b(i)=a(i)/i;
    end
    c(fig,1)=mean(b);
    d(fig,1)=std(b);
    
    
    tempAUC = AUC(:,:,fig); tempC = C(:,:,fig);
    tempMat(fig) = corr(tempAUC(:),tempC(:))
    %     set(gca,'FontSize',20)
end

%% repeat for absent

for image = 1:nImages
    %creates a separate matrix for each image
    
    % separate rows for each present word
    for absent1_word = 1:nWords/2 % present words = 50% of total words
        absent1 = [0 respDB(absent1_word,:,1,image)]; % adds a 0 to TPR for the AUC calculation
        TPR = cumsum(absent1/nSubjects); % gets the TPR
        
        % separate columns for each absent word
        for absent2_word = 1:nWords/2 % absent words = 50% of total words
            absent2 = [0 respDB(absent2_word,:,1,image)]; % adds a 0 to FPR for the AUC calculation
            FPR = cumsum(absent2/nSubjects); % gets the FPR
            
            % gets an AUC val for each absent/present word pair, for each of nImages (round to 2 dec)
            AUC(absent1_word,absent2_word,image) = round(AreaUnderROC([FPR; TPR]'),2);
        end
    end
    
end
disp(AUC);

%% Display figure

% the table, T, which was the tempArray2 table above, contains all the x,y labels
% half of this code makes this more readable by assigning absent and present labels

imageCount=0;
g=figure; g.Color='white'; tiledlayout('flow');
tempMat=zeros(5,1); AUC = 100*AUC; % turn AUC into a percentage
for fig = 1:nImages
    
    % this is not the cleanest. It's simply looping through all words to
    % create the x and y labels from absent and present words.
    Absent = T(imageCount*nWords+1:imageCount*nWords+(nWords/2),:);
    Present = T(imageCount*nWords+(nWords/2+1):imageCount*nWords+nWords,:);
    imageCount = imageCount+1;
    
    nexttile; % all AUC matrices in one fig
    heatmap(Absent.word,Absent.word,AUC(:,:,fig));
    colormap(autumn); caxis([0 100]);
    
    tempAUC = AUC(:,:,fig);
    trianglePresent = triu( tempAUC(1:10, 1:10,1 ) );
    a=sum(trianglePresent); a=a-50; a=a(2:end);
    for i=1:length(a)
        b(i)=a(i)/i;
    end
    c(fig,2)=mean(b);
    d(fig,2)=std(b);
    
    tempAUC = AUC(:,:,fig); tempC = C(:,:,fig);
    tempMat(fig) = corr(tempAUC(:),tempC(:))
    %     set(gca,'FontSize',20)
end

disp(c);disp(d);



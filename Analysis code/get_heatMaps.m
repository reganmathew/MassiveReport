clc; close all;
%
g=figure;
tempArray = final_pilotSample(:,{'subject','imageName','trialcode','word','RespConf'});
tempArray2 = grpstats(tempArray,{'imageName','trialcode','word'},'mean','DataVars',{'RespConf'});
T=sortrows(tempArray2);

[G,imageNames] = findgroups(T.imageName);
nImages = length(imageNames);

count = 0; Results = struct([]);
for image = 1:nImages
    
    allPresentWords = importWords(importWords.img_id==imgIDs(image),:);
    currentPresentWords = table(allPresentWords.stem_word);
    
    currentT = T(T.imageName==imageNames(image),:);
    Absent = currentT(currentT.trialcode=='absent_trial',:);
    Present = currentT(currentT.trialcode=='present_trial',:);
    
    LIA = ismember(table(Absent.word),currentPresentWords,'rows');
    
    A=Absent.mean_RespConf;
    P=Present.mean_RespConf;
    
    tempResults = zeros(length(P),length(A));
    for i = 1:length(A) 
        for j = 1:length(P)
            if P(j)-A(i) < -0.5
                tempResults(j,i) = -1;
            elseif P(j)-A(i) > 0.5
                tempResults(j,i) = 1;
            else
                tempResults(j,i) = 0;
            end
        end
    end

    y = Present.word; x = Absent.word; x(any(LIA,2),:)=[];
    tempC = tempResults; tempC(:,any(LIA,2))=[];
    subplot(2,3,image);
    g.Color='white';
    heatmap(x,y,tempC); colormap(autumn);
    set(gca,'FontSize',20); print -djpeg;
    Results(image).data = tempC;
    
    sprintf('image %d of %d \n(%d absent words, %d present words)',image,nImages, length(x),length(y))
    disp(Results(image).data);
    disp(x); disp(y);
end
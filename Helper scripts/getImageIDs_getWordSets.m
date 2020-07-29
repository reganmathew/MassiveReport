disp('getting image IDs and associated words... '); pause(1);

image_ids = unique(importWords.(1));
nImages = length(image_ids);
maxWords = max(importWords.(4));
minWords = min(importWords.(4));
wordSetCell = cell(maxWords,nImages);
varNames = cell(1,nImages);

count=0;
for imageNum = 1:nImages
    wordsetLength = importWords.(4)(count+1);
    image_ids(2,imageNum) = wordsetLength;
    word_item = [];
    for word=1:wordsetLength
        count=count+1;
        wordSetCell{word,imageNum} = num2str(importWords.(2)(count));
    end
    C = strsplit(importWords.(1)(count),'.');
    varNames{1,imageNum}  = C{1};
    image_ids(1,imageNum) = importWords.(1)(count);
end
wordSetTable=cell2table(wordSetCell, 'VariableNames', varNames);

disp(wordSetCell);
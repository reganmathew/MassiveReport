clear vars; close all; clc; sca;
%load('includes/frequencyMatrix_lessRemoved_allWords_proportion02.mat');


nImages = length(Data);
maxWords = 80;

count = 0;
output = [];
index = [];
wordList = {};
for i = 1:nImages
    tally = 0;
    for j = 1:maxWords
        
        if ischar(Data(i).mostCommonWord_Cell{j,1})
            count = count+1;
            wordList{count} = Data(i).mostCommonWord_Cell{j,1};
            tally = tally +1;
            
        end
    end
    index(i) = i;
    output(i,:) = tally;
end

wordList = sort(wordList);

for i = 1:length(wordList)-1
    if strcmp(wordList{i},wordList{i+1})
        wordList{i} = [];
    end
end

count=0;
finalList = {};
for j = 1:length(wordList)
    if ischar(wordList{j})
        count = count+1;
        finalList{count} = wordList{j};
    end
end

disp(finalList');
disp(length(finalList));

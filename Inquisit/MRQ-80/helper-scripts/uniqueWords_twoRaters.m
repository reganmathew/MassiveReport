count=0;
wordList={};
for i = 1:length(Data)
    for j = 1:length(Data(i).propAbove04Words)
        count = count+1;
        wordList{count} = Data(i).propAbove04Words{j};
    end
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
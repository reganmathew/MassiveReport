clc;

tally = 0;
wordList = {};

count = 0;
for i=1:length(Data)
    for j = 1:length(Data(i).Subject1)
        count = count + 1;
        wordList{count} = Data(i).Subject1{j};
    end
end

for i=1:length(Data)
    for j = 1:length(Data(i).Subject2)
        count = count + 1;
        wordList{count} = Data(i).Subject2{j};
    end
end

for i=1:length(Data)
    for j = 1:length(Data(i).Subject3)
        count = count + 1;
        wordList{count} = Data(i).Subject3{j};
    end
end

for i=1:length(Data)
    for j = 1:length(Data(i).Subject4)
        count = count + 1;
        wordList{count} = Data(i).Subject4{j};
    end
end

for i=1:length(Data)
    for j = 1:length(Data(i).Subject5)
        count = count + 1;
        wordList{count} = Data(i).Subject5{j};
    end
end

length(wordList)

count=0;
allWords = {};
for i=1:length(wordList)
    if isempty(wordList{i})
        count = count;
    else
        count = count + 1;
        allWords{count} = wordList{i};
    end
end

wordList = sort(allWords);

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

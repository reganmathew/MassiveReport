disp('getting a randomised list of absent words... '); pause(1);

fileID = fopen('MRP_Experiments/allAbsentWords.iqx','w');
absent_list_order = randperm(length(importWords.(2)));
allAbsentWords = cell(length(importWords.(2)),1);

count=0;
fprintf(fileID,'<item absent_wordset>\n');
for word = 1:length(importWords.(2))
    count=count+1;
    fprintf(fileID,'/ %g',word);
    fprintf(fileID,' = "%s"\n',importWords.(2)(absent_list_order(count)));
    allAbsentWords{word} = importWords.(2)(absent_list_order(count));
end
fprintf(fileID,'</item>\n');

fclose(fileID);
shuffledAbsentWords = cell2table(allAbsentWords);
type('MRP_Experiments/allAbsentWords.iqx');
disp('now creating the fixed absent word lists... '); pause(1);

fileID = fopen('MRP_Experiments/absentWordLists.iqx','w');
absent_list_order = randperm(length(importWords.(2)));
allWordCounts = str2double(image_ids(2,:));

fixedAbsentWords = cell(maxWords,nImages);

count=0;
for image = 1:nImages
    fprintf(fileID,'<item absent_wordset%g>\n',image);
    for word = 1:allWordCounts(image)
        count=count+1;
        fprintf(fileID,'/ %g',word);
        fprintf(fileID,' = "%s"\n',importWords.(2)(absent_list_order(count)));
        fixedAbsentWords{word,image} = num2str(importWords.(2)(absent_list_order(count)));
    end
    fprintf(fileID,'</item>\n');
end

fclose(fileID);
fixedAbsentWordList = cell2table(fixedAbsentWords, 'VariableNames', varNames);
type('MRP_Experiments/absentWordLists.iqx');

clear vars; close all; clc; sca; 

nWords = 40;
nImages = 40;
imSet = {};
output = {};
fileID = fopen('../testWordList.iqx','w');
for i = 1:nImages
    count=0;
    for j = 1:nWords
        count=count+1;
        item = importWords.img_id(i);
        descriptor = importWords.stem_word{j};
        output{1, count} = item;
        output{2, count} = descriptor;
    end
    imSet{i} = item;
    fileID = fopen('../testWordList.iqx','a');
    formatSpec = "<item word_set%g>\n";
    fprintf(fileID,formatSpec, i);
    for k = 1:nWords
        fprintf(fileID,'/ %g',k);
        fprintf(fileID,' = "%s"\n',output{2,k});
    end
    fprintf(fileID,'</item>\n');
    fclose(fileID);
end

fileID = fopen('../testWordList.iqx','w');
formatSpec = "<item pictures>\n";
fprintf(fileID,formatSpec, item);
for k = 1:nImages
    fprintf(fileID,'/ %g',k);
    fprintf(fileID,' = "Images/im000%s.jpg"\n',imSet{k});
end
fprintf(fileID,'</item>\n');
fclose(fileID);

type('../testWordList.iqx');
type('../testWordList.iqx');
disp('finished');
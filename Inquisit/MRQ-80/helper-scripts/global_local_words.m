clear vars; close all; clc; sca; 
load('frequencyMatrix_lessRemoved_allWords_proportion02.mat');

nWords = 5;
nImages = 20;
gl_words = 0;
imSet = {};
output = {};
fileID = fopen('../includes/words_gl.iqx','w');
formatSpec = "<item words_gl>\n";
fprintf(fileID,formatSpec);
for i = 1:nImages
    count=0;
    for j = 1:nWords
        count=count+1;
        item = Data(i).imgNum;
        descriptor = Data(i).mostCommonWord_Cell{j};
        output{1, count} = item;
        output{2, count} = descriptor;
    end
    imSet{i} = item;
    for k = 1:nWords
        gl_words = gl_words + 1;
        fprintf(fileID,'/ %g',gl_words);
        fprintf(fileID,' = "%s"\n',output{2,k});
    end
    
end
fprintf(fileID,'</item>\n');
fclose(fileID);
    
fileID = fopen('../includes/pictures.iqx','w');
formatSpec = "<item pictures>\n";
fprintf(fileID,formatSpec, item);
for k = 1:nImages
    fprintf(fileID,'/ %g',k);
    fprintf(fileID,' = "Images/im000%s.jpg"\n',imSet{k});
end
fprintf(fileID,'</item>\n');
fclose(fileID);

disp('finished');
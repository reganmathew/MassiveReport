load('zhaowords133267top40frequency');
uniqueWords_twoRaters

fileID = fopen('../includes/absent_wordlist_v0.iqx','w');
formatSpec = "<item absent_words_v0>\n";
fprintf(fileID,formatSpec);

for j = 1:length(finalList)
    fprintf(fileID,'/ %g',j);
    fprintf(fileID,' = "%s"\n',finalList{j});
end
% fclose(fileID);


fprintf(fileID,'</item>\n');
fclose(fileID);

disp('finished');

type('../includes/absent_wordlist.iqx');

importWords = importWords('Koh2020_wordsets/zhao_words_133_267_all.csv');
getImageIDs_getWordSets; % parse.csv file

% output files will be created
generate_presentWordLists;
generate_allAbsentWords;
generate_absentWordLists;


disp(wordSetTable);
disp('finished');
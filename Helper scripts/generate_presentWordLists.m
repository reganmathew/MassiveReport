disp('generating present word lists... '); pause(1);

fileID = fopen('MRP_Experiments/presentWordLists.iqx','w');

for image = 1:nImages
    fprintf(fileID,'<item present_wordset%g>\n',image);
    for word = 1:str2double(image_ids(2,image))
        fprintf(fileID,'/ %g',word);
        fprintf(fileID,' = "%s"\n',wordSetCell{word,image});
    end
    fprintf(fileID,'</item>\n');
end

fclose(fileID);
type('MRP_Experiments/presentWordLists.iqx');
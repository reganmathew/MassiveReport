fileID = fopen('MRP_Experiments/stimulusPictureList.iqx','w');

imIDs = image_ids(1,:);


fprintf(fileID,'<item pictures>\n');
for image = 1:nImages

    fprintf(fileID,'/ %g',image);
    fprintf(fileID,' = "im0000%g.jpg"\n',imIDs(image));

end
fprintf(fileID,'</item>\n');

fclose(fileID);
type('MRP_Experiments/stimulusPictureList.iqx');
disp('cleaning raw data... '); pause(2);

cleanData = rawData;

TF = ismissing(cleanData,{'centre_mouse' 'practice' 'reveal' 'reset' 'test' NaN -99});
cleanData(any(TF,2),:)=[];

disp(cleanData);
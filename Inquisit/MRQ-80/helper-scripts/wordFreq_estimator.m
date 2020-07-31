clear vars; close all; clc; sca;
load('helper-scripts/frequencyMatrix_lessRemoved_allWords_proportion02.mat');


nImages = 570;
maxWords = 80;

output = [];
index = [];
for i = 1:nImages
    tally = 0;
    for j = 1:maxWords
        if ischar(Data(i).mostCommonWord_Cell{j,1})
            tally = tally +1;
        end
    end
    index(i) = i;
    output(i,:) = tally;
end

output = sort(output, 'descend');
output = [index' output];
plot(output(:,1), output(:,end));


xlabel('n. images') 
ylabel('Unique descriptors') 
ylim([0 80])
xticks(0:50:600)

h = refline(0,50);
g = refline(0,30);
k = refline(0,40);

h.LineStyle = '--';
g.LineStyle = '--';
k.LineStyle = '--';


a=find(output(:,2)==50,1,'last'); disp(a);
b=find(output(:,2)==40,1,'last'); disp(b);
c=find(output(:,2)==30,1,'last'); disp(c);

line([a a], ylim)
line([b b], ylim)
line([c c], ylim)

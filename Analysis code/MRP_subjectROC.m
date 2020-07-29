clear all; close all; clc

nTrials = 400;
nSubjects = 15;
subjAUC = zeros(nSubjects,1);

absentTrials = zeros(1,nTrials/2);
presentTrials = zeros(1,nTrials/2)+1;
allTrials = [absentTrials presentTrials];
% trials = Shuffle(allTrials)';

Stim = allTrials';

for subject = 1:nSubjects
    Resp = zeros(nTrials,1);
    Conf = zeros(nTrials,1);
    RespConf = zeros(nTrials,1);
    
    Hit_tally = 0;
    FA_tally = 0;
    CR_tally = 0;
    Miss_tally = 0;
    
    for i = 1:length(Stim)
        %     Stim(i) = round(randi(2)-1);
        Resp(i) = round(randi(2)*2-3);
        Conf(i) = round(randi(4));
        RespConf(i) = Resp(i)*Conf(i);
    end
    
    rawData = [Stim Resp Conf RespConf];
    
    for i = 1:length(rawData)
        if rawData(i,1) == 0
            if rawData(i,2) == -1
                CR_tally = CR_tally + 1;
            else
                FA_tally = FA_tally + 1;
            end
        else
            if rawData(i,2) == -1
                Miss_tally = Miss_tally + 1;
            else
                Hit_tally = Hit_tally + 1;
            end
        end
    end
    
    SDT_Results = [Hit_tally Miss_tally FA_tally CR_tally];
    Data_Table = array2table(rawData);
    
    absent = zeros(1,8);
    present = zeros(1,8);
    absentTally = 0;
    presentTally = 0;
    
    for j = 1:length(rawData)
        if rawData(j,1) == 0
            absentTally = absentTally + 1;
            if rawData(j,end) == -4
                absent(1) = absent(1) + 1;
            end
            if rawData(j,end) == -3
                absent(2) = absent(2) + 1;
            end
            if rawData(j,end) == -2
                absent(3) = absent(3) + 1;
            end
            if rawData(j,end) == -1
                absent(4) = absent(4) + 1;
            end
            if rawData(j,end) == 1
                absent(5) = absent(5) + 1;
            end
            if rawData(j,end) == 2
                absent(6) = absent(6) + 1;
            end
            if rawData(j,end) == 3
                absent(7) = absent(7) + 1;
            end
            if rawData(j,end) == 4
                absent(8) = absent(8) + 1;
            end
        else
            presentTally = presentTally + 1;
            if rawData(j,end) == -4
                present(1) = present(1) + 1;
            end
            if rawData(j,end) == -3
                present(2) = present(2) + 1;
            end
            if rawData(j,end) == -2
                present(3) = present(3) + 1;
            end
            if rawData(j,end) == -1
                present(4) = present(4) + 1;
            end
            if rawData(j,end) == 1
                present(5) = present(5) + 1;
            end
            if rawData(j,end) == 2
                present(6) = present(6) + 1;
            end
            if rawData(j,end) == 3
                present(7) = present(7) + 1;
            end
            if rawData(j,end) == 4
                present(8) = present(8) + 1;
            end
        end
    end
    absent = [0 absent];
    present = [0 present];
    
    
    FPR = cumsum(absent/absentTally);
    TPR = cumsum(present/presentTally);
    %     AUC = AreaUnderROC([FPR; TPR]');
    %     subjAUC(subject) = AUC;
    
    plot(TPR,FPR, 'o-'); hold on
    xlabel('False positive rate')
    ylabel('True positive rate')
    title('ROC for Classification by Logistic Regression')
end


disp(subjAUC);
mean(subjAUC)

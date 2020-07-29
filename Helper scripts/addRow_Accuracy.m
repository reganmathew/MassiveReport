disp('calculating Hits and Misses... '); pause(2);
Accuracy=zeros(length(cleanData.response),1);
for i=1:length(Accuracy)
    
    if cleanData.trialcode(i) == "absent_trial"
%         disp('absent_trial');
        if Decision(i) == -1
            Accuracy(i) = 1;
        elseif Decision(i) == 1
            Accuracy(i) = 0;
        else
            Accuracy(i) = "NaN";
        end
    elseif cleanData.trialcode(i) == "present_trial"
%         disp('present_trial');
        if Decision(i) == 1
            Accuracy(i) = 1;
        elseif Decision(i) == -1
            Accuracy(i) = 0;
        else
            Accuracy(i) = "NaN";
        end
    elseif cleanData.trialcode(i) == "practice_absent_trial"
%         disp('practice_absent_trial');
        if Decision(i) == -1
            Accuracy(i) = 1;
        elseif Decision(i) == 1
            Accuracy(i) = 0;
        else
            Accuracy(i) = "NaN";
        end
    elseif cleanData.trialcode(i) == "practice_present_trial"
%         disp('practice_present_trial');
        if Decision(i) == 1
            Accuracy(i) = 1;
        elseif Decision(i) == -1
            Accuracy(i) = 0;
        else
            Accuracy(i) = "NaN";
        end
    elseif cleanData.trialcode(i) == "catch_trial"
%         disp('catch_trial');
        if cleanData.word(i) == "PRESS: No 4"
            if RespConf(i) == -4
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: No 3"
            if RespConf(i) == -3
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: No 2"
            if RespConf(i) == -2
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: No 1"
            if RespConf(i) == -1
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: Yes 1"
            if RespConf(i) == 1
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: Yes 2"
            if RespConf(i) == 2
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: Yes 3"
            if RespConf(i) == 3
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: Yes 4"
            if RespConf(i) == 4
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        end
    elseif cleanData.trialcode(i) == "catch_absent_trial"
%         disp('catch_absent_trial');
        if cleanData.word(i) == "PRESS: No 4"
            if RespConf(i) == -4
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: No 3"
            if RespConf(i) == -3
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: No 2"
            if RespConf(i) == -2
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: No 1"
            if RespConf(i) == -1
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        end
    elseif cleanData.trialcode(i) == "catch_present_trial"
%         disp('catch_absent_trial');
        if cleanData.word(i) == "PRESS: Yes 1"
            if RespConf(i) == 1
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: Yes 2"
            if RespConf(i) == 2
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: Yes 3"
            if RespConf(i) == 3
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        elseif cleanData.word(i) == "PRESS: Yes 4"
            if RespConf(i) == 4
                Accuracy(i) = 1;
            else
                Accuracy(i) = 0;
            end
        end
    end
end
T = table(Accuracy);
cleanData = [cleanData T];
disp('cleaning up... '); pause(2);
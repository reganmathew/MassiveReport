RespConf=zeros(length(cleanData.response),1);
Decision=zeros(length(cleanData.response),1);
Confidence=zeros(length(cleanData.response),1);
for i=1:length(RespConf)
    
    if cleanData.response(i) == "no_4"
        RespConf(i) = -4;
        Decision(i) = -1;
        Confidence(i) = 4;
    elseif cleanData.response(i) == "no_3"
        RespConf(i) = -3;
        Decision(i) = -1;
        Confidence(i) = 3;
    elseif cleanData.response(i) == "no_2"
        RespConf(i) = -2;
        Decision(i) = -1;
        Confidence(i) = 2;
    elseif cleanData.response(i) == "no_1"
        RespConf(i) = -1;
        Decision(i) = -1;
        Confidence(i) = 1;
    elseif cleanData.response(i) == "yes_1"
        RespConf(i) = 1;
        Decision(i) = 1;
        Confidence(i) = 1;
    elseif cleanData.response(i) == "yes_2"
        RespConf(i) = 2;
        Decision(i) = 1;
        Confidence(i) = 2;
    elseif cleanData.response(i) == "yes_3"
        RespConf(i) = 3;
        Decision(i) = 1;
        Confidence(i) = 3;
    elseif cleanData.response(i) == "yes_4"
        RespConf(i) = 4;
        Decision(i) = 1;
        Confidence(i) = 4;
    else
        RespConf(i) = "NaN";
    end
    
end
T = table(RespConf,Confidence,Decision);
cleanData = [cleanData T];
disp('converting participant responses... '); pause(2);
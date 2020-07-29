cleanData = movevars(cleanData, 'response', 'Before', 'RespConf');
cleanData = movevars(cleanData, 'latency', 'Before', 'word');
cleanData = movevars(cleanData, 'imageName', 'Before', 'latency');
cleanData = movevars(cleanData, 'imageNumber', 'Before', 'wordNumber');
cleanData = movevars(cleanData, 'latency', 'After', 'Accuracy');
cleanData = movevars(cleanData, 'Decision', 'Before', 'Confidence');
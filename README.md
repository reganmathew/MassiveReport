# MassiveReport

This repository holds the experiment files and analysis code for the Tsuchiya lab's Massive Report Paradigm.

Contents
1. Viewing the wordsets used in the pilots
2. Running the Massive Report Experiment
3. Downloading the pilot datasets
4. Performing the analyses  
5. Visualising the results

----

**1. Viewing the wordsets used in the pilots**

The wordsets used for the pilot experiments can be found in "Wordsets/Koh2020/"

**2. Running the Massive Report Experiment**

To run the experiment, you will need to launch inquisit 5. The main inquisit file is "Inquisit/MRQ OnlineV1/MRQ-Pilot_FixedAbsent_20Q_V7.iqx". This is the simple 20Q version of the study. All other dependencies are written at the top of the script. You may need to change the file path for this file to run. 

**3. Downloading the pilot datasets**

Experimental data for the 20Q version of the pilot can be found in "Data/Gallagher2020_data/MRP_20Q_Fixed_v1_raw.csv". data for the 20, 40, and 80 question versions can also be found in the same folder. Each has a Fixed and Varied word dataset.

**4. Performing the analyses**

The main Matlab file needed to analyse the data is the "workFlow_dataOutput.m" script found in the main folder ("MassiveReport/"). This file includes all of the necessary paths, wordset files, and data files. other dependencies including the individual scripts that do all the heavy lifting for the analyses are included at the bottom of the file. Running the main file "workFlow_dataOutput.m" will automate the analysis of experimental data. These analyses require the Psychophysics toolbox and have been tested on Matlab R2019a and R2020a.

**5. Visualising the results**

Forthcoming.

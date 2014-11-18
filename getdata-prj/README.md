# Cleaning Data

### Running the analysis

1. Download dataset. The dataset used for tests can be found at
 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. On file 'run_analysis.R', edit the lines containing 

* **DATA.ROOT** <- root of the location where dataset was extracted. 
    *e.g.* "C:\\tmp\\data\\UCI_HAR_Dataset" (Windows) or "~/work/data/UCI_HAR_Dataset" (Mac OS X)

* **SEPARATOR** <- separator used in paths: '\\' for Windows, '/' for Unix / Mac OS X

3. Run 'run_analysis.R' script: From R prompt, set the working directory as the location containing 'run_analysis.R' and use:

> source("run_analysis.R")

  Another way is to give the full path: 

> source("*<full_path_to_script>/*run_analysis.R")

4. If everything goes well, the following message is displayed:

> Script successfully executed. Check 'merged.data' and 'mean.data'

* 'merged.data' contains the data obtained at step 4: Means and std measurements with activity labels.

* 'mean.data' contains the data obtained at step 5: Tidy dataset with average of each variable for each activity and subject from step 4.


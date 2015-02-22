# Getting And Cleaning Data

The data was downloaded and read into R using read.table(), and then the x and y test data was merged together with the x and y train data.

Then, the activity labels were merged with the test and train data.

Then, the activity labels were given descriptive names.

Then, all of the column names (the features) were cleaned up. (Parentheses and dashes were removed, etc.)

Then, all of the features that were not a mean or standard deviation were discarded. 

Then, using the dplyr package, the data was grouped by subject and activity, and the mean of each feature was calculated.

The end result is a tidy dataset with 180 rows and 81 columns. Each row is a subject and activity, and each column is a mean of a standard deviation feature or mean feature.

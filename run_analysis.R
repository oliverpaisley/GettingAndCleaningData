library(dplyr)

# Reading in the test data.
x_test   <- read.table('test/X_test.txt', stringsAsFactors = FALSE)
y_test   <- read.table('test/Y_test.txt', stringsAsFactors = FALSE)
sub_test <- read.table('test\\subject_test.txt')

# Reading in the train data.
x_train   <- read.table('train/X_train.txt', stringsAsFactors = FALSE)
y_train   <- read.table('train/Y_train.txt', stringsAsFactors = FALSE)
sub_train <- read.table('train\\subject_train.txt')

# Getting the variable names from the features.txt file.
var_names <- read.table('features.txt', stringsAsFactors = FALSE)
var_names <- var_names$V2

# Setting the column names of the x variables.
colnames(x_test)   <- var_names
colnames(x_train)  <- var_names
colnames(sub_test) <- "Subject"

# Setting the column names of the y variable.
colnames(y_test)    <- "Activity"
colnames(y_train)   <- "Activity"
colnames(sub_train) <- "Subject"

# Merging the x and y data into the test and train datasets.
test  <- cbind(y_test, x_test)
train <- cbind(y_train, x_train)

# Merging the test and train data.
both_sets <- rbind(train, test)
names(both_sets[2:562, ]) <- var_names

# Converting from a data.frame to a data_frame (for better printing).
both_sets <- as_data_frame(both_sets)

# Subsetting the data just to get the features with mean or standard
# deviation.
subset_data <- both_sets[ , grepl("(mean)|(std)", colnames(both_sets))]

# Putting back on the activity labels.
subset_data <- cbind(Activity = both_sets[, 1], subset_data)

# Converting the Activity column to a factor.
subset_data$Activity <- as.factor(subset_data$Activity)

# Setting descriptive names for the activies.
levels(subset_data$Activity) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

# These 3 gsub() lines fix the names of the columns.
# It gets rid of all the unnecessary characters, and keeps all of the
# important information.
names(subset_data) <- gsub("-", "", names(subset_data))
names(subset_data) <- gsub("[()]", "", names(subset_data))

# This groups the data by activity, then takes the mean of each feature.
tidy_data <- subset_data %>%
  group_by(Activity) %>%
  summarise_each(funs(mean))

tidy_data <- tidy_data[, -2]

# This creates a file called tidy_data.txt.
file.create("tidy_data.txt")
# This writes tidy_data into the tidy_data.txt text file.
write.table(tidy_data, file = "tidy_data.txt", row.name = FALSE)

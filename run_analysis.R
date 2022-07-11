library(readr)
library(dplyr)

# determine which features are needed from datasets, then find their indices
con <- file("./UCI_HAR_Dataset/features.txt", open='r')
lines <- readLines(con)
close(con)
l <- lapply(lines, function(x) {ifelse(grep("mean|std()|Mean", x), TRUE, FALSE)})
l <- as.logical(l)
desired_features_indecies <- which(l)
feature_names <- lapply(lines[desired_features_indecies], function(x) {strsplit(trimws(x), " ")[[1]][2]})
#feature_names

#setting up the top half of the first data.frame
con <- file("./UCI_HAR_Dataset/train/subject_train.txt", open='r')
subjects <- readLines(con)
close(con)

con <- file("./UCI_HAR_Dataset/train/X_train.txt", open='r')
X_train <- readLines(con)
close(con)
X_train <- lapply(X_train, function(x) {strsplit(trimws(x), " +")[[1]][desired_features_indecies]})
X_train <- matrix(unlist(X_train,), nrow=86)
X_train <- as.data.frame(t(X_train))

con <- file("./UCI_HAR_Dataset/train/y_train.txt", open='r')
y_train <- readLines(con)
close(con)

df_1 <- data.frame(bind_cols(subjects, X_train, y_train))
colnames(df_1) <- c("subject", feature_names, "activity")
#head(df_1)

#setting up the bottom half of the first data.frame
con <- file("./UCI_HAR_Dataset/test/subject_test.txt", open='r')
subjects <- readLines(con)
close(con)

con <- file("./UCI_HAR_Dataset/test/X_test.txt", open='r')
X_test <- readLines(con)
close(con)
X_test <- lapply(X_test, function(x) {strsplit(trimws(x), " +")[[1]][desired_features_indecies]})
X_test <- matrix(unlist(X_test,), nrow=86)
X_test <- as.data.frame(t(X_test))

con <- file("./UCI_HAR_Dataset/test/y_test.txt", open='r')
y_test <- readLines(con)
close(con)

df_1_bottom <- data.frame(bind_cols(subjects, X_test, y_test))
colnames(df_1_bottom) <- c("subject", feature_names, "activity")

#binding the bottom half to the original top half
df_1 <- bind_rows(df_1, df_1_bottom)
write.table(df_1, file="df_1.csv", sep=",", row.names=FALSE)

#turning dataframe values into doubles (to later be averaged)
for(x in feature_names) {df_1[[x]] <- as.numeric(df_1[[x]])}
df_1$subject <- as.numeric(df_1$subject)

#renaming activity values to strings 
toActivity <- function(x) {
  if(x == 1) "WALKING"
  else if(x == 2) "WALKING_UPSTAIRS"
  else if(x == 3) "WALKING_DOWNSTAIRS"
  else if(x == 4) "SITTING"
  else if(x == 5) "STANDING"
  else "LAYING"
}
df_1$activity <- lapply(df_1$activity, toActivity)
df_1$activity <- unlist(df_1$activity)

df_1_grouped <- group_by(df_1, activity, subject)
df_2 <- summarize_all(df_1_grouped, mean, na.rm=TRUE)

feature_names_2 <- lapply(feature_names, function(x) {paste("avg_", x, sep="")})
feature_names_2 <- unlist(feature_names_2)
colnames(df_2) <- c("activity", "subject", feature_names_2)
write.table(df_2, file="df_2.csv", sep=",", row.names=FALSE)
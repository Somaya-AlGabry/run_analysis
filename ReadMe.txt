This is the project of Johns Hopkins' getting and cleaning data course on coursera. The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

#Steps done to clean and summerise the data:
1. download the data.
2. load features and activity labels
3. load training set, training labels and training subjects, bind them using cbind, and rename the variables. 
4. load test set, test labels and test subjects, bind them  using cbind and rename the variables. 
5. merge the training and test data using rbind.
6. rename activities using activity labels.
7. using grep() and regular expressions, extract mean and standard deviation columns. 
8. edit the variable names to make it tidier using gsub()
9. create tidy data set with the average of each variable for eache activity using melt() and dcast() from reshape2 library. 
10. you can find the final tidy data in "tidydata.txt". 

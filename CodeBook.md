
1. make sure the "getdata_projectfiles_UCI HAR Dataset.zip" file is stored in your R working directory and it is unpacked!
2. load data from the raw files to following variables:
features - features table
activity_labels - labels for activities
subject_train - subject ID for training data
x_train - x measures for training data
y_train - y measures for training data
subject_test - subject ID for test data
x_test - x measures for test data
y_test - y measures for test data
3. change column names to more meaningful for tables
activity_labels
subject_train
x_train
y_train
subject_test
x_test
y_test
4. merge training data into a variable training_dataset
5. merge test data into a variable test_dataset
6. merge both test & training datasets into a variable both
7. extract column names of both to cn
8. grep column names cn to ms according to requirements for mean and stddev
9. extract greped columns in both
10. merge both and activity_labels tables by activity_ID master key
11. extract column names of both to cn
12. clean cn to more meaningful 
13. rename both column names using cn
14. in tiny_temp dataframe store both with removed activity_type column for easier mean calculation, it will be re-added later
15. calculate mean of tidy_temp by subject_ID and activity_ID, store the result in tidy
16. remove 1st two columns of tidy
17. merge previously removed lavel (ref. 14)
18. export tidy to "tidy_dataset.txt" file
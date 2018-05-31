
# Code procedure of run_analysis.R
* genearl procedures including import `reshape2`, define the directory adress `'folder_name'`, load `activity_labels` and `features`.
* load the basic data for `test` and `train` and mearge them according to `x` or `y`, the files has names of `x_total` and `y_total`.
* extract the values of `mean` and `standard deviation` from the file `x_total`.
* subset the file according to the extraction, and tidy the names in the meantime.
* change the names of `y_total` into `activity` and `subject_total` into `subject`.
* merge all date with function `cbind`
* calculate the average using the `dcast` and `melt` functions from `reshape2` pacakages, then print the data to file `tidy_mean.txt`

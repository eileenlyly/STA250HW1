FastCSVSample Method
---------------------

####Summary
* Data set: US flight information from 1987 to 2012, [compressed bz2 files].
* We want to calculate the average, SD and median for the values (in minutes) in column *ArrDelay* in each csv files. In files 1987.csv-2007.csv, it is column 15; in files 2008[month].csv - 2012[month].csv, it is column 43.
* All procedures are tested in Mac OSX 10.8.5 and R 3.0.2
* For convenience, store all data files and R workspace are in the same directory. If not, change the path to file accordingly.

---

####System Setup

Install [FastCSVSample](https://github.com/duncantl/FastCSVSample) package by Duncan in R.

----
####Step One: Sample Lines from CSV Files
First we need to decompress the given tar.bz2 file into multiple csv files. To make things organized, I put them into one subdirectory "data". 

For each csv file, we sample 2000 lines using the csvSample method from package FastCSVSample.
```R
> csvSample(File, 2000) 
```
-----
####Step Two: Extract ArrDelay Column
We consider two types of files (both have delimator ","): for files from 1987-2007, we extract column 15 ; for files from 2008 to later, we extract column 45. Then we try (with error handler) to convert the extracted strings into integers and store them into a new vector ArrDelay.
```R
> tryCatch({x = as.integer(strsplit(SampleLines1[i],",")[[1]][15])}, 
+ warning = function(x){x= NA})
> if(is.integer(x) & !is.na(x))
+ ArrDelay = c(ArrDelay, x)
```

----
####Step Three: Calculate Average, Standard Deviation and Median with R
* mean {base}
* sd {stats}
* median{stats}

---
####Result Report
* 157,938 valid sample ArrDelay values extracted, that is about 0.1% of the total data set.
* ####Average = 5.4639, SD = 33.7427, Median = -2 (All these results are variable)
* Runtime: 1526 s in R
* The detailed R script is [M3.R](https://github.com/eileenlyly/STA250HW1/blob/master/M3.R).

----
**Author: Yu Liu, [yuliu@ucdavis.edu](mailto:yuliu@ucdavis.edu)**

[compressed bz2 files]: http://eeyore.ucdavis.edu/stat250/Data/Airlines/Delays1987_2013.tar.bz2

    
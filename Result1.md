Frequency Table Method
---------------------

####Summary
* Data set: US flight information from 1987 to 2012, [compressed bz2 files].
* We want to calculate the average, SD and median for the values (in minutes) in column *ArrDelay* in each csv files. In files 1987.csv-2007.csv, it is column 15; in files 2008[month].csv - 2012[month].csv, it is column 43.
* All procedures are tested in Mac OSX 10.8.5 and R 3.0.2
* For convenience, store all data files and R workspace are in the same directory. If not, change the path to file accordingly.

---

####System Setup

We will use *sed* command in shell. If you encounter the error:
```
sed: RE error: illegal byte sequence
```
you need to modify ~/.bash_profile to set the environment variable to C.

In Mac OSX/UNIX, add two lines:
```
export LC_CTYPE=C 
export LANG=C
```
----
####Step One: Extract ArrDelay Column in Shell

A big problem for extracting the data is the desired columns are in different column numbers in different files. My way is to cut both column 15 and 45 (because there are extra commas in the content of city info) for all decompressed stdout. For data from 2011, we will extract both *ORIGIN* (in letter) and *ArrDelay*. Then we can use sed to filter the number only and delete empty lines and unnecessary suffix ".00". 
This is not a formal solution, but will do the job neatly.

To sum up, the following command in shell will extract the *ArrDelay* column in all csv files:
```bash
$ tar xOjf Delays1987_2013.tar.bz2 | cut -d, -f15,45 | sed -e '/ARR_DEL15/d' -e 's/[^0-9.-]*//g' -e '/^$/d' -e 's/\.00//' 
```
-----
####Step Two: Sort and Get Frequency Table
In this step, we want to get the frequency table from the cleaned data getting from step one. Of course, it can be done in R, but here I combine step one and step two into a total pipeline in shell, which will be much more efficient then do it separately.
```bash
$ tar xOjf Delays1987_2013.tar.bz2 | cut -d, -f15,45 | sed -e '/ARR_DEL15/d' -e 's/[^0-9.-]*//g' -e '/^$/d' -e 's/\.00//' | sort -n | uniq -c > uniq.txt
```
The stdout is saved in the uniq.txt file for read in R later.

*Note: the shell command can also be executed in R with uniq <- system(cmd, intern = TRUE) function, which will invoke the system call as in bash.
*

----
####Step Three: Calculate Average, Standard Deviation and Median in R
In the final step, we can calculate the three parameters in regular way since the unique table has very small data size (less than 2000 rows). The detailed R script is [M1.R](https://github.com/eileenlyly/STA250HW1/blob/master/M1.R).

---
####Result Report
##### Average = 6.5665, SD = 31.5563, Median = 0
* 145.6 million valid ArrDelay numbers, 1913 unique values
* Runtime: 1168s in shell, 0.44s in R

----
**Author: Yu Liu, [yuliu@ucdavis.edu](mailto:yuliu@ucdavis.edu)**

[compressed bz2 files]: http://eeyore.ucdavis.edu/stat250/Data/Airlines/Delays1987_2013.tar.bz2

    

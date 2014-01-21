MySQL Method
---------------------
----

####Summary
* Data set: US flight information from 1987 to 2012, [compressed bz2 files].
* We want to calculate the average, SD and median for the values (in minutes) in column *ArrDelay* in each csv files. In files 1987.csv-2007.csv, it is column 15; in files 2008[month].csv - 2012[month].csv, it is column 43.
* All procedures are tested in Mac OSX 10.8.5, MySQL 5.6.15 and R 3.0.2
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
Install the latest distribution of [MySQl](http://dev.mysql.com/downloads/)

Install RMySQL package in R (available from CRAN)，see [manual](http://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf).

----
####Step One: Extract ArrDelay Column in Shell

We use the same technique to extract the *ArrDelay* column in all csv files and write into ArrDelay_clean.txt:
```bash
$ tar xOjf Delays1987_2013.tar.bz2 | cut -d, -f15,45 | sed -e '/ARR_DEL15/d' -e 's/[^0-9.-]*//g' -e '/^$/d' -e 's/\.00// > ArrDelay_clean.txt' 
```
-----
####Step Two: Connect to MySQL and Load the Data
RMySQL enable us to connect MySQL through R interface
```R
> conn <- dbConnect(MySQL(), user = "root")
```
Then we can send SQL queries using
```R
> dbSendQuery(conn, SQLquery)
```
SQL that tells the database to create a new database Flight, with a new table Delay, which has a single INT type column Arr 
```SQL
CREATE DATABASE Flight
USE Flight
CREATE TABLE Delay (Arr INT)
```
Then we import txt file into the table
```SQL
LOAD DATA INFILE 'ArrDelay_clean.txt' INTO TABLE Delay
```

----
####Step Three: Calculate Average, Standard Deviation and Median with SQL
Average
```SQl
SELECT AVG(Arr) FROM Delay
```
Standard Deviation
```SQL
SELECT STDDEV(Arr) FROM Delay
```
Median from ordered table (MID is the middle index)
```SQL
CREATE TABLE Delay_Ordered AS (SELECT * FROM Delay ORDER BY Arr)
SELECT * FROM Delay_Ordered LIMIT 1 OFFSET MID
```
---
####Result Report
* 145.6 million valid ArrDelay numbers
* ####Average = 6.5665, SD = 31.5563, Median = 0
* Runtime: 1033 s in shell,  2082 s in R
* The detailed R script is [M2.R](https://github.com/eileenlyly/STA250HW1/blob/master/M2.R).

----
**Author: Yu Liu, [yuliu@ucdavis.edu](mailto:yuliu@ucdavis.edu)**

[compressed bz2 files]: http://eeyore.ucdavis.edu/stat250/Data/Airlines/Delays1987_2013.tar.bz2

    

GitHub Repository
---------------------
https://github.com/eileenlyly/STA250HW1.git

----

Efficiency Comparison
---------------------
* ####Loading Data
To standardize the data loading time,  the time is all counted from decompressing the tar.bz2 file 

|            |     Time |
| :-----------: | :-----------: |
|**Frequency Table**| 1033 s 
| **MySQL**     | 985 s
|**CSV Sample**|615 s

* ####Calculation
For frequency table and MySQL method, we get median by sorting the data first, which is the dominate of the time for finding median. We iterate every line of frequency table to calculate the average and sd. MySQL has build-in function `AVG()` and `SD()`; R also has `mean{base}`, `sd{stats}` and  `median{stats}`.

|            |    Average   | Standard Deviation  | Sort|  Median  |
| :-----------: | :-----------: |:-------------:| :----------:| :----------:|
|**Frequency Table**| 0.171 s| 0.159 s|133 s (shell)|0.039 s
| **MySQL**     | 112.817 s |93.79 s  |3150.43 s|81.18 s
|**CSV Sample**|0.026 s|0.039 s|--|0.038 s
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*Sort in shell is done in a pipeline, so it takes significantly less time.*

* ####Total Execution time

|            |  Time    |
| :-----------: | :-----------: |
|**Frequency Table**| 1168 s 
| **MySQL**     | 4423 s
|**CSV Sample**|1526 s

Frequency table is the most efficiency way in time.

---

Results Comparison
---------------------

|            |   Data Size|Average   | Standard Deviation  |  Median  |
| :-----------: | :-----------: |:-------------:| :----------:|:----------:|
|**Frequency Table**| 145,574,558| 6.5665| 31.5563|0
| **MySQL**     | 145,574,558|6.5665 |31.5563  |0
|**CSV Sample**|157,938|5.4639|33.7427|-2

Only the result from CSV Sample is inaccurate and variable for each time we execute the code.

---

Method Details
---------------------
See following pages [Result1.md](https://github.com/eileenlyly/STA250HW1/blob/master/Result1.md), [Result2.md](https://github.com/eileenlyly/STA250HW1/blob/master/Result2.md), [Result3.md](https://github.com/eileenlyly/STA250HW1/blob/master/Result3.md). 

----
**Author: Yu Liu, [yuliu@ucdavis.edu](mailto:yuliu@ucdavis.edu)**

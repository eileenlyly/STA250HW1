####################################################################################
#                         STA250 Homework1 Method 2 -- MySQL
#                         Yu Liu 998611750 yuliu@ucdavis.edu
####################################################################################

# Execute the following shell command in bash, stdout is written to txt file
# $tar xOjf Delays1987_2013.tar.bz2 | cut -d, -f15,45 | sed -e '/ARR_DEL15/d' -e' s/[^0-9.-]*//g'  -e '/^$/d'  -e 's/\.00//'  > ArrDelay_clean.txt
# Run time = 1033s

# R code timer starts here
start <- proc.time()
library(RMySQL)

# Log in with root
# If you have setup password, use:
# conn <- dbConnect(MySQL(), user = "root", password = <password>)
conn <- dbConnect(MySQL(), user = "root")

# Create new database and table, delete duplicate db and table if any
dbSendQuery(conn, "CREATE DATABASE Flight")
dbSendQuery(conn, "USE Flight")
dbSendQuery(conn, "CREATE TABLE Delay (Arr INT)")

# Load txt file to db
pathtofile = getwd()
query = paste("LOAD DATA INFILE '",pathtofile, "/ArrDelay_clean.txt' INTO TABLE Delay", sep = "")
dbSendQuery(conn, query)

# Get mean
res <- dbSendQuery(conn, "SELECT AVG(Arr) FROM Delay")
dbmean = fetch(res, n=-1)[1,1]

# Get SD
res <- dbSendQuery(conn, "SELECT STDDEV(Arr) FROM Delay")
dbsd = fetch(res, n=-1)[1,1]

# Get median by sorting
res <- dbSendQuery(conn, "SELECT COUNT(*) FROM Delay")
dbn = fetch(res, n=-1)[1,1]
dbSendQuery(conn, "CREATE TABLE Delay_Ordered AS (SELECT * FROM Delay ORDER BY Arr)")

if(dbn%%2 == 0){
  mid1 = n/2
  mid2 = mid1 + 1
}
if(dbn%%2 == 1){
  mid1 = n/2 + 0.5
  mid2 = mid1
}

query = paste("SELECT * FROM Delay_Ordered LIMIT 1 OFFSET", toString(mid1-1))
res <- dbSendQuery(conn, query)
dbm1 = fetch(res, n=-1)[1,1]

query = paste("SELECT * FROM Delay_Ordered LIMIT 1 OFFSET", toString(mid2-1))
res <- dbSendQuery(conn, query)
dbm2 = fetch(res, n=-1)[1,1]

dbmedian = (dbm1+dbm2)/2

# Get execution time
dbtime = dbtime + proc.time()-start
# Result2: Mean = 6.5665 SD = 31.5563 Median = 0 time = 2082 +1033s

# Save system information
M2Info <- list(time = dbtime +1033, results = c(mean = dbmean, median = dbmedian, sd = dbsd),
               system = Sys.info(),  session = sessionInfo())
save(M2Info, file = "results2.rda")

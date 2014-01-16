####################################################################################
#                         STA250 Homework1 Method 2 -- MySQL
#                         Yu Liu 998611750 yuliu@ucdavis.edu
####################################################################################
start <- proc.time()
library(RMySQL)

pathtofile = getwd()
# Log in with root
# If you have setup password, use:
# conn <- dbConnect(MySQL(), user = "root", password = <password>)
conn <- dbConnect(MySQL(), user = "root")
# dbSendQuery(conn, "CREATE DATABASE Flight")
dbSendQuery(conn, "USE Flight")
dbSendQuery(conn, "CREATE TABLE Delay (Arr INT)")
query = paste("LOAD DATA INFILE '",pathtofile, "/ArrDelay_clean.txt' INTO TABLE Delay", sep = "")
dbSendQuery(conn, query)
res <- dbSendQuery(conn, "SELECT AVG(Arr) FROM Delay")
dbmean = fetch(res, n=-1)[1,1]

res <- dbSendQuery(conn, "SELECT STDDEV(Arr) FROM Delay")
dbsd = fetch(res, n=-1)[1,1]

res <- dbSendQuery(conn, "SELECT COUNT(*) FROM Delay")
dbn = fetch(res, n=-1)[1,1]
start <- proc.time()
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
dbtime = dbtime + proc.time()-start

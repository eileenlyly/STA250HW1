####################################################################################
#                     STA250 Homework1 Method 3 -- FastCSVSample
#                        Yu Liu 998611750 yuliu@ucdavis.edu
####################################################################################

# R code timer starts here
start <- proc.time()

# Modify FastCSVSample package:
# R-> FastCSVSample.R ->
# getNumLines =
#   function(file)
#   {
#     txt = system(sprintf("wc -l %s", file), intern = TRUE)
#     as.integer(gsub("?([0-9]+) .*", "\\1", txt))
#   }
library(FastCSVSample)

# Decompress tar.bz2 to subdirectory data
dir = paste(getwd(), "/data", sep = "")
system(paste("cd", getwd()))
system("mkdir data")
system("tar xjf Delays1987_2013.tar.bz2 -C data")

# List all the csv filename in the directory
files <- list.files(dir)

# Initial sample lines
SampleLines1 = {}
SampleLines2 = {}

# Loop over files, each file grab 2000 samples
for(i in 1:21){
  SampleLines1 = c(SampleLines1, csvSample(paste("data/", files[i], sep = ""), 2000))
}

for(i in 22:81){
  SampleLines2 = c(SampleLines2, csvSample(paste("data/", files[i], sep = ""), 2000))
}

# Each sample line extract the 15/45 column, convert them to integers and store
ArrDelay = {}
n1 = length(SampleLines1)
for(i in 1:n1){
  x = NA
  tryCatch({x = as.integer(strsplit(SampleLines1[i],",")[[1]][15])}, warning = function(x){x= NA})
  if(is.integer(x) & !is.na(x))
    ArrDelay = c(ArrDelay, x)
}

n2 = length(SampleLines2)
for(i in 1:n2){
  x = NA
  tryCatch({x = as.integer(strsplit(SampleLines2[i],",")[[1]][45])}, warning = function(x){x= NA})
  if(is.integer(x) & !is.na(x))
    ArrDelay = c(ArrDelay, x)
}

# Calculate mean, sd and median with build-in functions
SampleMean = mean(ArrDelay)
SampleSD = sd(ArrDelay)
SampleMedian = median(ArrDelay)
# SampleMean = 5.3992, SampleSD = 34.3086, SampleMedian = -3

# Get execution time
SampleTime = proc.time()-start

# Save system information
M3Info <- list(time = SampleTime, results = c(mean = SampleMean, median = SampleMedian, sd = SampleSD),
               system = Sys.info(),  session = sessionInfo())
save(M3Info, file = "results3.rda")

library(FastCSVSample)
dir = paste(getwd(), "/data", sep = "")
# system("mkdir data")
# system("tar xjf Delays1987_2013.tar.bz2 -C data")
files <- list.files(dir)
SampleLines1 = {}
SampleLines2 = {}

getNumLines =
  function(file)
  {
    txt = system(sprintf("wc -l %s", file), intern = TRUE)
    as.integer(gsub("?([0-9]+) .*", "\\1", txt))
  }

for(i in 1:2){
  SampleLines1 = c(SampleLines1, csvSample(paste("data/", files[i], sep = ""), 100))
}

for(i in 21:22){
  SampleLines2 = c(SampleLines2, csvSample(paste("data/", files[i], sep = ""), 100))
}

# SampleLines2 = csvSample(paste("data/", "2008_April.csv", sep = ""), numRows = 598127, 100)

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

SampleMean = mean(ArrDelay)
SampleSD = sd(ArrDelay)
SampleMedian = median(ArrDelay)

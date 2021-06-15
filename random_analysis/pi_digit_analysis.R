## Library

library(tm)
library(data.table)

pi_digits_10m <- fread(file = "data/pi-10million.txt", header = FALSE)

sample <- fread(file = "data/sample.txt", header = FALSE)
View(sample)
unlist(strsplit(sample$V1,""))

dim(pi_digits_10m)
class(pi_digits_10m)

pi_digits <- unlist(strsplit(pi_digits_10m$V1, ""))

str(pi_digits_10m)

dim(pi_digits)

digits <- "662432587213933934459020916622729054934938271782051266690211494719231138093382231122409958837224633250122232337896"
unlist(strsplit(digits, ""))


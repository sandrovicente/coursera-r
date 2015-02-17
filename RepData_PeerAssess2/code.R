

if (exists("dataset")) {
    message("Data already exists. Don't load it up again")
} else {
    dataset <- read.csv(bzfile("repdata_data_StormData.csv.bz2"), nrows=900000, na.strings="")    
}


s <- split(dataset$FATALITIES, dataset$EVTYPE)

fat.evtype <- sapply(s, sum)

attributes(fat.evtype)[[1]][which.max(fat.evtype)]
fat.evtype[which.max(fat.evtype)]

# function to calculate damages using value and exp 
#
# Rules:
#
# B,b = billions 
# M,m = millions 
# K,k = thousands 
# H,h = hundreds 
# 
# + = Not sure, but I assume positive sign = +1 
# - = Not sure, but I assume negative sign = -1 ,   EDIT: finally I chose 0 
# ? = I don't know, but I assume it's 0 or unused , EDIT: finally I chose 0 
# 
# 0..8 = number of zeros in the exponent ,     EDIT: <--- WRONG, it is multiplier of 10 
# i.e. 0 = 1, 1 = 10, 2 = 100, 3 = 1000, 4 = 10000, ... , 7 = 1e7, 8 = 1e8 

fexp <- function(exp) {
    exp.num <- grepl("^[[:digit:]]+$", exp)
    exp.na <- is.na(exp)
    
    exp.1 <- ifelse(exp.na, 0, exp)
    exp.2 <- ifelse(!exp.num & !exp.na, tolower(exp), exp.1)
    
    exp.sym <- !exp.num & !exp.na
    exp.3 <- ifelse(exp.sym, 
                    ifelse(exp.2=='h', 2, 
                           ifelse(exp.2=='k', 3, 
                                  ifelse(exp.2=='m', 6,
                                         ifelse(exp.2=='b', 9, 
                                                ifelse(exp.2=='+', 1,
                                                       0))))), 
                    exp.2)
    as.numeric(exp.3)
}


fexp(c(3,'m',1,'H',0, NA, 'k', '+', 'b', '?'))
fexp(c('M','K','M'))

fexp2 <- function(val, exp) {
    val * (10^fexp(exp))
}

fexp2(c(2.0,10.0,31,42,0,-1, 1, 12,2), c(3,'m',1,'H',0, NA, 'k', '+', 'b'))
fexp2(c(10.0,500.0,1.0),c('M','K','M'))

for (i in 1:nrow(dataset)){
    dataset[i, "PROPDMG.VAL"] <- dataset[i, "PROPDMG"]
}

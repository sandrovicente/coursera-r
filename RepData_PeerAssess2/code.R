

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

fexp <- function(val, exp) {
    exp <- tolower(exp)    
    if (is.na(exp)) {
        return(val)    
    } 
    exp.num <- grep("^[[:digit:]]+$", exp)
    if (length(exp.num) > 0) {
        return(val*(10^as.numeric(exp)))
    }
    
    switch(exp, k={val*1e3}, h={val*1e2}, m={val*1e6}, b={val*1e9}, '+'={val*10}, '-'={val}, {val})
}

fexp(NA, NA)
fexp(9, NA)
fexp(10,"+")
fexp(12, "h")
fexp(12, 3)

fexp2 <- function(val, exp) {
    ret <- val
    ifelse(is.na(exp), 
           ret<-val, {
               exp.num <- grep("^[[:digit:]]+$", exp)
               ifelse(length(exp.num)>1, 
                      val*(10^as.numeric(exp)),
                      val)
           } )
}


fexp2 <- function(val, exp) {
    exp.num <- grepl("^[[:digit:]]+$", exp)  
    val <- ifelse(exp.num, (10^as.numeric(exp[exp.num])), val)
    val
}

fexp2(c(2,10,31,0,-1), c(3,'A',1,0, NA))




for (i in 1:nrow(dataset)){
    dataset[i, "PROPDMG.VAL"] <- dataset[i, "PROPDMG"]
}

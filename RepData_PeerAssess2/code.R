

if (exists("dataset")) {
    message("Data already exists. Don't load it up again")
} else {
    dataset <- read.csv(bzfile("repdata_data_StormData.csv.bz2"), nrows=1000000, na.strings="")    
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
    exp <- as.character(exp)
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


#fexp(c(3,'m',1,'H',0, NA, 'k', '+', 'b', '?'))
#fexp(c('M','K','M'))

fvalexp <- function(val, exp) {
    val * (10^fexp(exp))
}

#fvalexp(c(2.0,10.0,31,42,0,-1, 1, 12,2), c(3,'m',1,'H',0, NA, 'k', '+', 'b'))
#fvalexp(c(10.0,500.0,1.0),c('M','K','M'))

library(dplyr)

dataset$PROPDMG.V <-with(dataset, fvalexp(PROPDMG, PROPDMGEXP))
dataset$CROPDMG.V <- with(dataset, fvalexp(CROPDMG, CROPDMGEXP))
dataset$TOTALDMG.V <- with(dataset, CROPDMG.V + PROPDMG.V)

dataset$BGN_DATE.V <- with(dataset, as.Date(BGN_DATE, "%m/%d/%Y"))
dataset$BGN_DECADE <- with(dataset, paste(substr(format(dataset$BGN_DATE.V, "%Y"),1,3), "0", sep=""))

decade.split <- split(dataset, dataset$BGN_DECADE)
decades <- unique(dataset$BGN_DECADE)

# health effects
top <- 20

# fatalities
for (d in decades) {
    print(d)
    x<-decade.split[[d]]  %>% arrange(desc(FATALITIES, INJURIES)) %>% select(BGN_DATE, EVTYPE, FATALITIES, INJURIES, PROPDMG.V, CROPDMG.V, TOTALDMG.V) %>% head(top)
    print(x)
}

dataset %>% arrange(desc(FATALITIES, INJURIES)) %>% select(BGN_DATE, EVTYPE, FATALITIES, INJURIES, PROPDMG.V, CROPDMG.V, TOTALDMG.V) %>%  head(top) 

# injuries
for (d in decades) {
    print(d)
    x<-decade.split[[d]]  %>% arrange(desc(FATALITIES + INJURIES)) %>% select(BGN_DATE, EVTYPE, FATALITIES, INJURIES, PROPDMG.V, CROPDMG.V, TOTALDMG.V) %>% head(top)
    print(x)
}


# damages

for (d in decades) {
    print(d)
    x<-decade.split[[d]] %>% arrange(desc(TOTALDMG.V)) %>% select(BGN_DATE, EVTYPE, FATALITIES, INJURIES, PROPDMG.V, CROPDMG.V, TOTALDMG.V) %>% head(top)
    print(x)
}

dataset  %>% arrange(desc(TOTALDMG.V)) %>% select(BGN_DATE, EVTYPE, FATALITIES, INJURIES, PROPDMG.V, CROPDMG.V, TOTALDMG.V) %>% head(top)
 

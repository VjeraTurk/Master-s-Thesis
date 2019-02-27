
1.  in system.time **=** does not work while **<-** does   

    system.time( PhoneData = fread(file=file, sep="auto", header=FALSE, col.names = phone))
        Error in system.time(PhoneData = fread(file = file, sep = "auto", header = FALSE,  : 
        unused argument (PhoneData = fread(file = file, sep = "auto", header = FALSE, col.names = phone))
                                       
    system.time( PhoneData <- fread(file=file, sep="auto", header=FALSE, col.names = phone, quote=""))

2. 

    system.time( PhoneData <- fread(file=file, sep="auto", header=FALSE, col.names = phone))
    PhoneData[order(Time)] #or
    setorder(PhoneData, Time)
        "never" end !! Gase komp grrrrrrrrrr
    #neka komanda
        Error: C stack usage  343997353 is too close to the limit
    system.time(setorderv(PhoneData,PhoneData$Time))
        Error: C stack usage  344004761 is too close to the limit
        Timing stopped at: 55.25 1.528 115.3

    Cstack_info()
        size    current  direction eval_depth 
        7969177      25240          1          2
    
    system.time( PhoneData <- fread(file=file, sep="auto", header=FALSE, col.names = phone, quote=""))
    system.time(setorderv(PhoneData,PhoneData$Time))
        Error: C stack usage  344002345 is too close to the limit
        Timing stopped at: 52.54 1.552 124.9
    #ne radi ni sa quote = ""

3.  
    strftime(PDsample$Time, format ="%H:%M:%S")
        Error in as.POSIXlt.character(x, tz = tz) : 
          character string is not in a standard unambiguous format
    
    strptime(PDsample$Time, format ="%H:%M:%S")# Doda danasnji datum, ne zelim to
 




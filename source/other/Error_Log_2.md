
1.  in system.time **=** does not work while **<-** does   

    ```system.time( PhoneData = fread(file=file, sep="auto", header=FALSE, col.names = phone))```
        Error in system.time(PhoneData = fread(file = file, sep = "auto", header = FALSE,  : 
        unused argument (PhoneData = fread(file = file, sep = "auto", header = FALSE, col.names = phone))
                                       
    ```system.time( PhoneData <- fread(file=file, sep="auto", header=FALSE, col.names = phone, quote=""))```

2. 

   ```system.time( PhoneData <- fread(file=file, sep="auto", header=FALSE, col.names = phone))
    PhoneData[order(Time)] #or
    setorder(PhoneData, Time)```
       execution "never" ends !!
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
 

4.  

        install.packages("OpenStreetMap") #reqires package rJava
        ERROR: dependency ‘rJava’ is not available for package ‘OpenStreetMap’
        
        install.packages("rJava")
        (...)        
        Make sure you have Java Development Kit installed and correctly registered in R.
        If in doubt, re-run "R CMD javareconf" as root.  


        require(OpenStreetMap)
        Error: package or namespace load failed for ‘OpenStreetMap’:
         .onLoad failed in loadNamespace() for 'rJava', details:
        call: dyn.load(file, DLLpath = DLLpath, ...)
        error: unable to load shared object '/home/adminuser/R/x86_64-pc-linux-gnu-library/3.6/rJava/libs/rJava.so':
        libjvm.so: cannot open shared object file: No such file or directory  
    https://github.com/rstudio/rstudio/issues/2254#issuecomment-372474049



 in cmd:

        $R CMD javareconf

    after that require `rJava` and `OpenstreetMap` without Error

5.  

    ulem.sty missing

    ulem.sty can be found in a much smaller package (3 MiB instead of 1 000 MiB), namely texlive-generic-recommended:
    sudo apt-get install texlive-generic-recommended
    
    https://askubuntu.com/a/936359/591187


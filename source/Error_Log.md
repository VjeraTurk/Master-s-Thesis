1.
        data <- read.csv(file.choose())
        Error: cannot allocate vector of size 125.0 Mb

2.
        data = fread(file=file,sep="auto")
        Error in fread(file = file, sep = "auto") : Opened 0TB (1947283562 bytes) file ok but could not memory map it. 
        This is a 32bit process. Please upgrade to 64bit.
  
3. 
        data.table::update.dev.pkg(repo="https://Rdatatable.gitlab.io/data.table")
        
        Installing package into ‘C:/Users/admin/Documents/R/win-library/3.4’
        (as ‘lib’ is unspecified)
        
        Warning: unable to access index for repository https://Rdatatable.gitlab.io/data.table/bin/windows/contrib/3.4:     cannot open URL 'https://Rdatatable.gitlab.io/data.table/bin/windows/contrib/3.4/PACKAGES'
        Package which is only available in source form, and may need compilation of C/C++/Fortran:  
        ‘data.table’ These will not be installed R data.table package has been updated to NA (1.11.8)

4. 
        zz=gzfile('454.csv.gz','rt')
        c454=read.csv(zz,header=T)

        1: In read.table(file = file, header = header, sep = sep, quote = quote,  : seek on a gzfile connection returned an internal error
        2: In read.table(file = file, header = header, sep = sep, quote = quote,  : seek on a gzfile connection returned an internal error
    https://www.stat.berkeley.edu/~paciorek/computingTips/Reading_gzipped_bzipped_zip.html
    https://stackoverflow.com/questions/30834963/seeking-on-a-gz-connection-is-unpredictable
5.
        install.packages("vcd")
        install.packages("vcdExtra")

        Installing package into ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.2’
        (as ‘lib’ is unspecified)
        Warning in install.packages :
        package ‘vcd’ is not available (for R version 3.2.3)

        Installing package into ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.2’
        (as ‘lib’ is unspecified)
        Warning in install.packages :
        package ‘vcdExtra’ is not available (for R version 3.2.3)

        R version 3.2.3 (2015-12-10) -- "Wooden Christmas-Tree"
        Copyright (C) 2015 The R Foundation for Statistical Computing
        Platform: x86_64-pc-linux-gnu (64-bit)


6.
        sudo apt-get install r-base
        [sudo] password for adminuser: 
        Reading package lists... Done
        Building dependency tree       
        Reading state information... Done
        r-base is already the newest version (3.2.3-4).
        0 upgraded, 0 newly installed, 0 to remove and 48 not upgraded.

        sudo nano /etc/apt/sources.list
        #add:
        deb https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/

        sudo apt-get update
        
        W: GPG error: https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 51716619E084DAB9
        W: The repository 'https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease' is not signed.
        N: Data from such a repository can't be authenticated and is therefore potentially dangerous to use.
        N: See apt-secure(8) manpage for repository creation and user configuration details.
        ^^ nema veze

        sudo apt-get install r-base
        (... output in r_version_3.5.txt )

        R version 3.5.1 (2018-07-02) -- "Feather Spray"
        Copyright (C) 2018 The R Foundation for Statistical Computing
        Platform: x86_64-pc-linux-gnu (64-bit)

        R is free software and comes with ABSOLUTELY NO WARRANTY.
        You are welcome to redistribute it under certain conditions.
        Type 'license()' or 'licence()' for distribution details.

        Natural language support but running in an English locale

        R is a collaborative project with many contributors.
        Type 'contributors()' for more information and
        'citation()' on how to cite R or R packages in publications.

7. 
    Update all user installed r packages
    use script : update_all_packages.r
    as proposed in:  https://www.r-bloggers.com/update-all-user-installed-r-packages-again/
1.
        data <- read.csv(file.choose())
        Error: cannot allocate vector of size 125.0 Mb

2.
        data = fread(file=file,sep="auto")
        Error in fread(file = file, sep = "auto") : Opened 0TB (1947283562 bytes) file ok but could not memory map it. 
        This is a 32bit process. Please upgrade to 64bit.
  
3. 
        data.table::update.dev.pkg(repo="https://Rdatatable.gitlab.io/data.table")
        
        Installing package into ‘C:/Users/admin/Documents/R/win-library/3.4’
        (as ‘lib’ is unspecified)
        
        Warning: unable to access index for repository https://Rdatatable.gitlab.io/data.table/bin/windows/contrib/3.4:     cannot open URL 'https://Rdatatable.gitlab.io/data.table/bin/windows/contrib/3.4/PACKAGES'
        Package which is only available in source form, and may need compilation of C/C++/Fortran:  
        ‘data.table’ These will not be installed R data.table package has been updated to NA (1.11.8)

4. 
        zz=gzfile('454.csv.gz','rt')
        c454=read.csv(zz,header=T)

        1: In read.table(file = file, header = header, sep = sep, quote = quote,  : seek on a gzfile connection returned an internal error
        2: In read.table(file = file, header = header, sep = sep, quote = quote,  : seek on a gzfile connection returned an internal error
    https://www.stat.berkeley.edu/~paciorek/computingTips/Reading_gzipped_bzipped_zip.html
    https://stackoverflow.com/questions/30834963/seeking-on-a-gz-connection-is-unpredictable
5.
        install.packages("vcd")
        install.packages("vcdExtra")

        Installing package into ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.2’
        (as ‘lib’ is unspecified)
        Warning in install.packages :
        package ‘vcd’ is not available (for R version 3.2.3)

        Installing package into ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.2’
        (as ‘lib’ is unspecified)
        Warning in install.packages :
        package ‘vcdExtra’ is not available (for R version 3.2.3)

        R version 3.2.3 (2015-12-10) -- "Wooden Christmas-Tree"
        Copyright (C) 2015 The R Foundation for Statistical Computing
        Platform: x86_64-pc-linux-gnu (64-bit)


6.
        sudo apt-get install r-base
        [sudo] password for adminuser: 
        Reading package lists... Done
        Building dependency tree       
        Reading state information... Done
        r-base is already the newest version (3.2.3-4).
        0 upgraded, 0 newly installed, 0 to remove and 48 not upgraded.

        sudo nano /etc/apt/sources.list
        #add:
        deb https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/

        sudo apt-get update
        
        W: GPG error: https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 51716619E084DAB9
        W: The repository 'https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease' is not signed.
        N: Data from such a repository can't be authenticated and is therefore potentially dangerous to use.
        N: See apt-secure(8) manpage for repository creation and user configuration details.
        ^^ nema veze

        sudo apt-get install r-base
        (... output in r_version_3.5.txt )

        R version 3.5.1 (2018-07-02) -- "Feather Spray"
        Copyright (C) 2018 The R Foundation for Statistical Computing
        Platform: x86_64-pc-linux-gnu (64-bit)

        R is free software and comes with ABSOLUTELY NO WARRANTY.
        You are welcome to redistribute it under certain conditions.
        Type 'license()' or 'licence()' for distribution details.

        Natural language support but running in an English locale

        R is a collaborative project with many contributors.
        Type 'contributors()' for more information and
        'citation()' on how to cite R or R packages in publications.

7. 
    NOT THE WAY: Update all user installed r packages
    use script : update_all_packages.r
    as proposed in:  https://www.r-bloggers.com/update-all-user-installed-r-packages-again/

    ONE WAY: install packages again
        lib_loc<- "/home/adminuser/R/x86_64-pc-linux-gnu-library/3.2"
        to_install <- unname(installed.packages(lib.loc = lib_loc)[, "Package"])
        install.packages(pkgs = to_install)

    https://community.rstudio.com/t/reinstalling-packages-on-new-version-of-r/7670/4

8. 
        install.packages("rgdal")
        
        Installing package into ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5’
        (as ‘lib’ is unspecified)
        trying URL 'https://cloud.r-project.org/src/contrib/rgdal_1.3-6.tar.gz'
        Content type 'application/x-gzip' length 1666975 bytes (1.6 MB)
        ==================================================
        downloaded 1.6 MB

        * installing *source* package ‘rgdal’ ...
        ** package ‘rgdal’ successfully unpacked and MD5 sums checked
        configure: R_HOME: /usr/lib/R
        configure: CC: gcc -std=gnu99
        configure: CXX: g++
        configure: C++11 support available
        configure: rgdal: 1.3-6
        checking for /usr/bin/svnversion... no
        configure: svn revision: 773
        checking for gdal-config... no
        no
        configure: error: gdal-config not found or not executable.
        ERROR: configuration failed for package ‘rgdal’
        * removing ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/rgdal’
        Warning in install.packages :
          installation of package ‘rgdal’ had non-zero exit status

        The downloaded source packages are in
        ‘/tmp/RtmpEOKzTo/downloaded_packages’

        
        sudo apt-get install libgdal1-dev libproj-dev
       
nije pomoglo



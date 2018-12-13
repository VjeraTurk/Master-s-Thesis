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
       
^^ nije pomoglo

        sudo apt-get install apt-file
        sudo apt-file update

^^ nije pomoglo
        sudo apt-get install -y libxml2-dev libcurl4-openssl-dev libssl-dev

^^ nije pomoglo

ali...
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
        checking for gdal-config... /usr/bin/gdal-config
        checking gdal-config usability... yes
        configure: GDAL: 1.11.3
        checking GDAL version >= 1.11.4... no
        configure: error: upgrade GDAL to 1.11.4 or later
        ERROR: configuration failed for package ‘rgdal’
        * removing ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/rgdal’
        Warning in install.packages :
          installation of package ‘rgdal’ had non-zero exit status

        The downloaded source packages are in
	        ‘/tmp/RtmpvLdSsa/downloaded_packages’

      
    **checking GDAL version >= 1.11.4... no**

    
    http://www.sarasafavi.com/installing-gdalogr-on-ubuntu.html
    ^^nije pomoglo

   
    ________________________________________________________________________________

 SOLUTION: https://askubuntu.com/questions/1068266/how-to-get-gdal-2-0-0-on-ubuntu-16-04-lts   
     output:
        sudo add-apt-repository ppa:nextgis/dev
        You are about to add the following PPA:
         NextGIS Development builds
         More info: https://launchpad.net/~nextgis/+archive/ubuntu/dev
        Press Enter to continue or Ctrl+C to cancel

        Executing: /tmp/tmp.2ECmaz5lqO/gpg.1.sh --keyserver
        hkp://keyserver.ubuntu.com:80
        --recv-keys
        CF0CF9F7
        gpg: requesting key CF0CF9F7 from hkp server keyserver.ubuntu.com
        gpg: key CF0CF9F7: public key "Launchpad PPA for NextGIS" imported
        gpg: Total number processed: 1
        gpg:               imported: 1  (RSA: 1)
        adminuser@vjera-HP-EliteBook-8440p ~ $ sudo apt-get update
        Hit:1 http://ppa.launchpad.net/nathan-renniewaldock/flux/ubuntu xenial InRelease
        Get:2 http://security.ubuntu.com/ubuntu xenial-security InRelease [107 kB]     
        Hit:3 http://archive.canonical.com/ubuntu xenial InRelease                     
        Hit:4 http://archive.ubuntu.com/ubuntu xenial InRelease                        
        Ign:5 http://dl.google.com/linux/chrome/deb stable InRelease                   
        Ign:6 http://www.mirrorservice.org/sites/packages.linuxmint.com/packages serena InRelease
        Get:7 http://archive.ubuntu.com/ubuntu xenial-updates InRelease [109 kB]       
        Get:8 http://ppa.launchpad.net/nextgis/dev/ubuntu xenial InRelease [17,5 kB]   
        Hit:9 http://dl.google.com/linux/chrome/deb stable Release                     
        Hit:10 http://www.mirrorservice.org/sites/packages.linuxmint.com/packages serena Release
        Hit:11 http://ppa.launchpad.net/ubuntugis/ppa/ubuntu xenial InRelease          
        Get:12 https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease [3606 B]
        Get:13 https://mirror.ibcp.fr/pub/CRAN/bin/linux/ubuntu xenial/ InRelease [3590 B]
        Get:14 http://archive.ubuntu.com/ubuntu xenial-backports InRelease [107 kB]    
        Hit:17 https://download.sublimetext.com apt/stable/ InRelease
        Get:18 http://ppa.launchpad.net/nextgis/dev/ubuntu xenial/main Sources [1460 B]
        Get:19 http://ppa.launchpad.net/nextgis/dev/ubuntu xenial/main amd64 Packages [2936 B]
        Ign:12 https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease   
        Ign:13 https://mirror.ibcp.fr/pub/CRAN/bin/linux/ubuntu xenial/ InRelease     
        Get:20 http://ppa.launchpad.net/nextgis/dev/ubuntu xenial/main i386 Packages [2940 B]
        Get:21 http://ppa.launchpad.net/nextgis/dev/ubuntu xenial/main Translation-en [1496 B]
        Fetched 356 kB in 1s (219 kB/s)                                     
        Reading package lists... Done
        W: Target Packages (Packages) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en_US) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: GPG error: https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 51716619E084DAB9
        W: The repository 'https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease' is not signed.
        N: Data from such a repository can't be authenticated and is therefore potentially dangerous to use.
        N: See apt-secure(8) manpage for repository creation and user configuration details.
        W: GPG error: https://mirror.ibcp.fr/pub/CRAN/bin/linux/ubuntu xenial/ InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 51716619E084DAB9
        W: The repository 'https://mirror.ibcp.fr/pub/CRAN/bin/linux/ubuntu xenial/ InRelease' is not signed.
        N: Data from such a repository can't be authenticated and is therefore potentially dangerous to use.
        N: See apt-secure(8) manpage for repository creation and user configuration details.
        W: Target Packages (Packages) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en_US) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        adminuser@vjera-HP-EliteBook-8440p ~ $ sudo apt-get install libgdal-dev
        Reading package lists... Done
        Building dependency tree       
        Reading state information... Done
        The following packages were automatically installed and are no longer required:
          libdap-dev libdap17v5 libdapclient6v5 libdapserver7v5 libepsilon1 libgdal1i
          libhdf4-0-alt libjasper-dev libkmlbase1 libkmldom1 libkmlengine1 libminizip1
          libmysqlclient-dev libmysqlclient20 libnetcdf-dev libnetcdf11 libogdi3.2
          liburiparser1 libwebp-dev libxerces-c-dev libxerces-c3.1 mysql-common
          unixodbc-dev
        Use 'sudo apt autoremove' to remove them.
        The following additional packages will be installed:
          gdal-bin gdal-data libarmadillo-dev libarpack2-dev libgdal20 libgeotiff-dev
          libhdf4-0 libhdf4-dev libjbig-dev libjson-c-dev libopencad-dev libopencad1
          libopenjp2-7-dev libqhull-dev libsuperlu-dev libtiff5-dev libtiffxx5
          postgresql-client-common postgresql-common postgresql-server-dev-9.5
          postgresql-server-dev-all
        Suggested packages:
          python-gdal libitpp-dev libgdal-doc libgeotiff-epsg libhdf4-doc hdf4-tools
          libopencad-doc libsuperlu-doc
        Recommended packages:
          proj-bin opencad-bin
        The following packages will be REMOVED:
          libhdf4-alt-dev
        The following NEW packages will be installed:
          gdal-data libarmadillo-dev libarpack2-dev libgeotiff-dev libhdf4-0
          libhdf4-dev libjbig-dev libjson-c-dev libopencad-dev libopencad1
          libopenjp2-7-dev libqhull-dev libsuperlu-dev libtiff5-dev libtiffxx5
          postgresql-client-common postgresql-common postgresql-server-dev-9.5
          postgresql-server-dev-all
        The following packages will be upgraded:
          gdal-bin libgdal-dev libgdal20
        3 upgraded, 19 newly installed, 1 to remove and 99 not upgraded.
        Need to get 15,0 MB of archives.
        After this operation, 30,0 MB of additional disk space will be used.
        Do you want to continue? [Y/n] 
        Get:1 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libhdf4-0 amd64 4.2.10-3.2 [295 kB]
        Get:2 http://ppa.launchpad.net/nextgis/dev/ubuntu xenial/main amd64 gdal-data all 2.6.0+2-0xenial1 [482 kB]
        Get:3 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libarpack2-dev amd64 3.3.0-1build2 [94,7 kB]
        Get:4 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libsuperlu-dev amd64 4.3+dfsg-3 [174 kB]
        Get:5 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libarmadillo-dev amd64 1:6.500.5+dfsg-1 [297 kB]
        Get:6 http://archive.ubuntu.com/ubuntu xenial/main amd64 libjbig-dev amd64 2.1-3.1 [24,8 kB]
        Get:7 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libtiffxx5 amd64 4.0.6-1ubuntu0.4 [5588 B]
        Get:8 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 libtiff5-dev amd64 4.0.6-1ubuntu0.4 [268 kB]
        Get:9 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libgeotiff-dev amd64 1.4.1-2 [77,3 kB]
        Get:10 http://ppa.launchpad.net/nextgis/dev/ubuntu xenial/main amd64 gdal-bin amd64 2.6.0+2-0xenial1 [179 kB]
        Get:11 http://archive.ubuntu.com/ubuntu xenial/main amd64 libjson-c-dev amd64 0.11-4ubuntu2 [30,6 kB]
        Get:12 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 postgresql-client-common all 173ubuntu0.2 [28,4 kB]
        Get:13 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 postgresql-common all 173ubuntu0.2 [154 kB]
        Get:14 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 postgresql-server-dev-9.5 amd64 9.5.14-0ubuntu0.16.04 [722 kB]
        Get:15 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 postgresql-server-dev-all all 173ubuntu0.2 [9616 B]
        Get:16 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libhdf4-dev amd64 4.2.10-3.2 [411 kB]
        Get:17 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 libopenjp2-7-dev amd64 2.1.2-1.1+deb9u2build0.1 [25,4 kB]
        Get:18 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libqhull-dev amd64 2015.2-1 [240 kB]
        Get:19 http://ppa.launchpad.net/nextgis/dev/ubuntu xenial/main amd64 libopencad1 amd64 0.3.3+8-0xenial1 [115 kB]
        Get:20 http://ppa.launchpad.net/nextgis/dev/ubuntu xenial/main amd64 libgdal20 amd64 2.6.0+2-0xenial1 [5105 kB]
        Get:21 http://ppa.launchpad.net/nextgis/dev/ubuntu xenial/main amd64 libgdal-dev amd64 2.6.0+2-0xenial1 [6093 kB]
        Get:22 http://ppa.launchpad.net/nextgis/dev/ubuntu xenial/main amd64 libopencad-dev amd64 0.3.3+8-0xenial1 [143 kB]
        Fetched 15,0 MB in 12s (1153 kB/s)                                             
        Preconfiguring packages ...
        Selecting previously unselected package gdal-data.
        (Reading database ... 289633 files and directories currently installed.)
        Preparing to unpack .../gdal-data_2.6.0+2-0xenial1_all.deb ...
        Unpacking gdal-data (2.6.0+2-0xenial1) ...
        Preparing to unpack .../gdal-bin_2.6.0+2-0xenial1_amd64.deb ...
        Unpacking gdal-bin (2.6.0+2-0xenial1) over (2.1.3+dfsg-1~xenial2) ...
        Selecting previously unselected package libhdf4-0.
        Preparing to unpack .../libhdf4-0_4.2.10-3.2_amd64.deb ...
        Unpacking libhdf4-0 (4.2.10-3.2) ...
        Selecting previously unselected package libopencad1.
        Preparing to unpack .../libopencad1_0.3.3+8-0xenial1_amd64.deb ...
        Unpacking libopencad1 (0.3.3+8-0xenial1) ...
        Preparing to unpack .../libgdal20_2.6.0+2-0xenial1_amd64.deb ...
        Unpacking libgdal20 (2.6.0+2-0xenial1) over (2.1.3+dfsg-1~xenial2) ...
        Selecting previously unselected package libarpack2-dev.
        Preparing to unpack .../libarpack2-dev_3.3.0-1build2_amd64.deb ...
        Unpacking libarpack2-dev (3.3.0-1build2) ...
        Selecting previously unselected package libsuperlu-dev:amd64.
        Preparing to unpack .../libsuperlu-dev_4.3+dfsg-3_amd64.deb ...
        Unpacking libsuperlu-dev:amd64 (4.3+dfsg-3) ...
        Selecting previously unselected package libarmadillo-dev.
        Preparing to unpack .../libarmadillo-dev_1%3a6.500.5+dfsg-1_amd64.deb ...
        Unpacking libarmadillo-dev (1:6.500.5+dfsg-1) ...
        Selecting previously unselected package libjbig-dev:amd64.
        Preparing to unpack .../libjbig-dev_2.1-3.1_amd64.deb ...
        Unpacking libjbig-dev:amd64 (2.1-3.1) ...
        Selecting previously unselected package libtiffxx5:amd64.
        Preparing to unpack .../libtiffxx5_4.0.6-1ubuntu0.4_amd64.deb ...
        Unpacking libtiffxx5:amd64 (4.0.6-1ubuntu0.4) ...
        Selecting previously unselected package libtiff5-dev:amd64.
        Preparing to unpack .../libtiff5-dev_4.0.6-1ubuntu0.4_amd64.deb ...
        Unpacking libtiff5-dev:amd64 (4.0.6-1ubuntu0.4) ...
        Selecting previously unselected package libgeotiff-dev:amd64.
        Preparing to unpack .../libgeotiff-dev_1.4.1-2_amd64.deb ...
        Unpacking libgeotiff-dev:amd64 (1.4.1-2) ...
        Selecting previously unselected package libjson-c-dev:amd64.
        Preparing to unpack .../libjson-c-dev_0.11-4ubuntu2_amd64.deb ...
        Unpacking libjson-c-dev:amd64 (0.11-4ubuntu2) ...
        Selecting previously unselected package postgresql-client-common.
        Preparing to unpack .../postgresql-client-common_173ubuntu0.2_all.deb ...
        Unpacking postgresql-client-common (173ubuntu0.2) ...
        Selecting previously unselected package postgresql-common.
        Preparing to unpack .../postgresql-common_173ubuntu0.2_all.deb ...
        Adding 'diversion of /usr/bin/pg_config to /usr/bin/pg_config.libpq-dev by postgresql-common'
        Unpacking postgresql-common (173ubuntu0.2) ...
        Selecting previously unselected package postgresql-server-dev-9.5.
        Preparing to unpack .../postgresql-server-dev-9.5_9.5.14-0ubuntu0.16.04_amd64.deb ...
        Unpacking postgresql-server-dev-9.5 (9.5.14-0ubuntu0.16.04) ...
        Selecting previously unselected package postgresql-server-dev-all.
        Preparing to unpack .../postgresql-server-dev-all_173ubuntu0.2_all.deb ...
        Unpacking postgresql-server-dev-all (173ubuntu0.2) ...
        Preparing to unpack .../libgdal-dev_2.6.0+2-0xenial1_amd64.deb ...
        Unpacking libgdal-dev (2.6.0+2-0xenial1) over (1.11.3+dfsg-3build2) ...
        Processing triggers for man-db (2.7.5-1) ...
        Processing triggers for libc-bin (2.23-0ubuntu10) ...
        Processing triggers for doc-base (0.10.7) ...
        Processing 1 added doc-base file...
        Registering documents with scrollkeeper...
        Processing triggers for systemd (229-4ubuntu12) ...
        Processing triggers for ureadahead (0.100.0-19) ...
        ureadahead will be reprofiled on next reboot
        (Reading database ... 291087 files and directories currently installed.)
        Removing libhdf4-alt-dev (4.2.10-3.2) ...
        Processing triggers for man-db (2.7.5-1) ...
        Selecting previously unselected package libhdf4-dev.
        (Reading database ... 291029 files and directories currently installed.)
        Preparing to unpack .../libhdf4-dev_4.2.10-3.2_amd64.deb ...
        Unpacking libhdf4-dev (4.2.10-3.2) ...
        Selecting previously unselected package libopencad-dev.
        Preparing to unpack .../libopencad-dev_0.3.3+8-0xenial1_amd64.deb ...
        Unpacking libopencad-dev (0.3.3+8-0xenial1) ...
        Selecting previously unselected package libopenjp2-7-dev.
        Preparing to unpack .../libopenjp2-7-dev_2.1.2-1.1+deb9u2build0.1_amd64.deb ...
        Unpacking libopenjp2-7-dev (2.1.2-1.1+deb9u2build0.1) ...
        Selecting previously unselected package libqhull-dev:amd64.
        Preparing to unpack .../libqhull-dev_2015.2-1_amd64.deb ...
        Unpacking libqhull-dev:amd64 (2015.2-1) ...
        Processing triggers for man-db (2.7.5-1) ...
        Setting up gdal-data (2.6.0+2-0xenial1) ...
        Setting up libhdf4-0 (4.2.10-3.2) ...
        Setting up libopencad1 (0.3.3+8-0xenial1) ...
        Setting up libgdal20 (2.6.0+2-0xenial1) ...
        Setting up gdal-bin (2.6.0+2-0xenial1) ...
        Setting up libarpack2-dev (3.3.0-1build2) ...
        Setting up libsuperlu-dev:amd64 (4.3+dfsg-3) ...
        Setting up libarmadillo-dev (1:6.500.5+dfsg-1) ...
        Setting up libjbig-dev:amd64 (2.1-3.1) ...
        Setting up libtiffxx5:amd64 (4.0.6-1ubuntu0.4) ...
        Setting up libtiff5-dev:amd64 (4.0.6-1ubuntu0.4) ...
        Setting up libgeotiff-dev:amd64 (1.4.1-2) ...
        Setting up libjson-c-dev:amd64 (0.11-4ubuntu2) ...
        Setting up postgresql-client-common (173ubuntu0.2) ...
        Setting up postgresql-common (173ubuntu0.2) ...
        supported-versions: WARNING! Unknown distribution: linuxmint
        ubuntu found in ID_LIKE, treating as Ubuntu
        supported-versions: WARNING: Unknown Ubuntu release: 18.1
        Adding user postgres to group ssl-cert

        Creating config file /etc/postgresql-common/createcluster.conf with new version

        Creating config file /etc/logrotate.d/postgresql-common with new version
        Building PostgreSQL dictionaries from installed myspell/hunspell packages...
          en_us
        Removing obsolete dictionary files:
        Setting up postgresql-server-dev-9.5 (9.5.14-0ubuntu0.16.04) ...
        Setting up postgresql-server-dev-all (173ubuntu0.2) ...
        Setting up libhdf4-dev (4.2.10-3.2) ...
        Setting up libopencad-dev (0.3.3+8-0xenial1) ...
        Setting up libopenjp2-7-dev (2.1.2-1.1+deb9u2build0.1) ...
        Setting up libqhull-dev:amd64 (2015.2-1) ...
        Setting up libgdal-dev (2.6.0+2-0xenial1) ...
        Processing triggers for libc-bin (2.23-0ubuntu10) ...
        Processing triggers for systemd (229-4ubuntu12) ...
        Processing triggers for ureadahead (0.100.0-19) ...

9. installing stplanr

    https://github.com/ropensci/stplanr

        #sudo apt-get install libgdal1-dev libgdal-dev libgeos-c1v5 libproj-dev
        
        install.packages("rgdal", type = "source")
        install.packages("rgeos", type = "source")

        #sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
        #sudo apt-get update
        #sudo apt-get install libudunits2-dev libgdal-dev libgeos-dev libproj-dev 

        ##GDAL (>= 2.0.0), GEOS (>= 3.3.0) and Proj.4 (>= 4.8.0) are required.
        #gdalinfo --version
        #GDAL 2.6.0-nextgis-dev[2.3.1], released 2018/06/22
        #geos-config --version
        #3.5.1

        install.packages("proj4")        


        https://github.com/r-spatial/sf/issues/884


        




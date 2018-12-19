## 32-bit Windowns:

1.

    data <- read.csv(file.choose())
        Error: cannot allocate vector of size 125.0 Mb

Problem: 4 GB RAM ?  

2.

    data.table::update.dev.pkg(repo="https://Rdatatable.gitlab.io/data.table")
        Installing package into ‘C:/Users/admin/Documents/R/win-library/3.4’
        (as ‘lib’ is unspecified)
        
        Warning: unable to access index for repository https://Rdatatable.gitlab.io/data.table/bin/windows/contrib/3.4:     cannot open URL 'https://Rdatatable.gitlab.io/data.table/bin/windows/contrib/3.4/PACKAGES'
        Package which is only available in source form, and may need compilation of C/C++/Fortran:  
        ‘data.table’ These will not be installed R data.table package has been updated to NA (1.11.8)

Solution?!

3.

    data = fread(file=file,sep="auto")
        Error in fread(file = file, sep = "auto") : Opened 0TB (1947283562 bytes) file ok but could not memory map it. 
        This is a 32bit process. Please upgrade to 64bit.
    
Problem : 32-bit Windows  
Solution: Decided to move to 64 bit Linux Mint (Ubuntu)  
___

## 64-bit Linux Mint:  

1.

    zz=gzfile('454.csv.gz','rt')
    c454=read.csv(zz,header=T)

        1: In read.table(file = file, header = header, sep = sep, quote = quote,  : seek on a gzfile connection returned an internal error
        2: In read.table(file = file, header = header, sep = sep, quote = quote,  : seek on a gzfile connection returned an internal error
    https://www.stat.berkeley.edu/~paciorek/computingTips/Reading_gzipped_bzipped_zip.html
    https://stackoverflow.com/questions/30834963/seeking-on-a-gz-connection-is-unpredictable

2.

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

3.

    sudo apt-get install r-base
        [sudo] password for adminuser: 
        Reading package lists... Done
        Building dependency tree       
        Reading state information... Done
        r-base is already the newest version (3.2.3-4).
        0 upgraded, 0 newly installed, 0 to remove and 48 not upgraded.
___
    sudo nano /etc/apt/sources.list
        #add:
        deb https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/

        sudo apt-get update
        
        W: GPG error: https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 51716619E084DAB9
        W: The repository 'https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease' is not signed.
        N: Data from such a repository can't be authenticated and is therefore potentially dangerous to use.
        N: See apt-secure(8) manpage for repository creation and user configuration details.
___

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

4.

**NOT** THE WAY:  
Update all user installed r packages  
use script : update_all_packages.r  
as proposed in:  https://www.r-bloggers.com/update-all-user-installed-r-packages-again/

ONE WAY:  
install packages again  

        lib_loc<- "/home/adminuser/R/x86_64-pc-linux-gnu-library/3.2"
        to_install <- unname(installed.packages(lib.loc = lib_loc)[, "Package"])
        install.packages(pkgs = to_install)

https://community.rstudio.com/t/reinstalling-packages-on-new-version-of-r/7670/4

...this is not really updating ALL the packages...


5.

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

___
    sudo apt-get install libgdal1-dev libproj-dev
       
^^ nije pomoglo
___
    sudo apt-get install apt-file
    sudo apt-file update

^^ nije pomoglo
___
    sudo apt-get install -y libxml2-dev libcurl4-openssl-dev libssl-dev

^^ nije pomoglo
___

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
___



**!!WARNING!! LATER PROVEN TO BE BAD SOLUTION!!!: **

https://askubuntu.com/questions/1068266/how-to-get-gdal-2-0-0-on-ubuntu-16-04-lts   

    
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

**CORRECT?**  
https://github.com/ropensci/MODIStsp/issues/155
    
    sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable

6.

installing stplanr
    https://github.com/ropensci/stplanr
___
    sudo apt-get install libgdal1-dev libgdal-dev libgeos-c1v5 libproj-dev
___    
    install.packages("rgdal", type = "source")
    install.packages("rgeos", type = "source")
        GDAL (>= 2.0.0), GEOS (>= 3.3.0) and Proj.4 (>= 4.8.0) are required.
___
    sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
    sudo apt-get update
    sudo apt-get install libudunits2-dev libgdal-dev libgeos-dev libproj-dev 

Ove komande ne znace ništa, jer najnovija dostupna verzija GDAL-a je 2.6.0, ovim komandama neće preć na nižu a stabilniju ubuntugit-unstable verziju

___
    gdalinfo --version
        GDAL 2.6.0-nextgis-dev[2.3.1], released 2018/06/22
    geos-config --version
        3.5.1
___
        install.packages("proj4")        
**WENT OK**
___
    install.packages("sf")  

        Installing package into ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5’
        (as ‘lib’ is unspecified)
        trying URL 'https://cloud.r-project.org/src/contrib/sf_0.7-1.tar.gz'
        Content type 'application/x-gzip' length 8330564 bytes (7.9 MB)
        ==================================================
        downloaded 7.9 MB

        * installing *source* package ‘sf’ ...
        ** package ‘sf’ successfully unpacked and MD5 sums checked
        configure: CC: gcc -std=gnu99
        configure: CXX: g++ -std=gnu++11
        checking for gdal-config... /usr/bin/gdal-config
        checking gdal-config usability... yes
        
        configure: GDAL: 2.6.0
        
        checking GDAL version >= 2.0.0... yes
        checking for gcc... gcc -std=gnu99
        checking whether the C compiler works... yes
        checking for C compiler default output file name... a.out
        checking for suffix of executables... 
        checking whether we are cross compiling... no
        checking for suffix of object files... o
        checking whether we are using the GNU C compiler... yes
        checking whether gcc -std=gnu99 accepts -g... yes
        checking for gcc -std=gnu99 option to accept ISO C89... none needed
        checking how to run the C preprocessor... gcc -std=gnu99 -E
        checking for grep that handles long lines and -e... /bin/grep
        checking for egrep... /bin/grep -E
        checking for ANSI C header files... yes
        checking for sys/types.h... yes
        checking for sys/stat.h... yes
        checking for stdlib.h... yes
        checking for string.h... yes
        checking for memory.h... yes
        checking for strings.h... yes
        checking for inttypes.h... yes
        checking for stdint.h... yes
        checking for unistd.h... yes
        checking gdal.h usability... yes
        checking gdal.h presence... yes
        checking for gdal.h... yes
        checking GDAL: linking with --libs only... yes
        checking GDAL: /usr/share/gdal/2.6/pcs.csv readable... yes
        checking GDAL: checking whether PROJ is available for linking:... yes
        checking GDAL: checking whether PROJ is available fur running:... yes
        configure: pkg-config proj exists, will use it
        checking proj_api.h usability... yes
        checking proj_api.h presence... yes
        checking for proj_api.h... yes
        configure: PROJ: 4.9.2
        checking for pj_init_plus in -lproj... yes
        checking PROJ: epsg found and readable... yes
        checking PROJ: conus found and readable... yes
        checking for geos-config... /usr/bin/geos-config
        checking geos-config usability... yes
        configure: GEOS: 3.5.1
        checking GEOS version >= 3.4.0... yes
        checking geos_c.h usability... yes
        checking geos_c.h presence... yes
        checking for geos_c.h... yes
        checking geos: linking with -L/usr/lib/x86_64-linux-gnu -lgeos_c -L/usr/lib/x86_64-linux-gnu -lgeos-3.5.1... yes
        configure: Package CPP flags:   -I/usr/include/gdal -I/usr/include
        configure: Package LIBS: -lproj   -L/usr/lib/x86_64-linux-gnu -lgdal -L/usr/lib/x86_64-linux-gnu -lgeos_c -L/usr/lib/x86_64-linux-gnu -lgeos-3.5.1
        configure: creating ./config.status
        config.status: creating src/Makevars
        ** libs
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I/usr/include -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c RcppExports.cpp -o RcppExports.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I/usr/include -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c bbox.cpp -o bbox.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I/usr/include -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c gdal.cpp -o gdal.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I/usr/include -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c gdal_geom.cpp -o gdal_geom.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I/usr/include -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c gdal_read.cpp -o gdal_read.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I/usr/include -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c gdal_utils.cpp -o gdal_utils.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I/usr/include -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c gdal_write.cpp -o gdal_write.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I/usr/include -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c geos.cpp -o geos.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I/usr/include -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c hex.cpp -o hex.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I/usr/include -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c polygonize.cpp -o polygonize.o
        polygonize.cpp: In function ‘Rcpp::List CPL_polygonize(Rcpp::CharacterVector, Rcpp::CharacterVector, Rcpp::CharacterVector, Rcpp::CharacterVector, Rcpp::CharacterVector, Rcpp::CharacterVector, Rcpp::IntegerVector, Rcpp::CharacterVector, bool, bool)’:
        polygonize.cpp:113:75: error: ‘GDALContourGenerateEx’ was not declared in this scope
         create_options(contour_options).data(), NULL, NULL) != OGRERR_NONE)
                                                           ^
        /usr/lib/R/etc/Makeconf:168: recipe for target 'polygonize.o' failed
        make: *** [polygonize.o] Error 1
        ERROR: compilation failed for package ‘sf’
        * removing ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/sf’
        Warning in install.packages :
        installation of package ‘sf’ had non-zero exit status

        The downloaded source packages are in
        ‘/tmp/RtmpOGJu7H/downloaded_packages’

https://github.com/r-spatial/sf/issues/884
        
        configure: GDAL: 2.6.0

link sugests problem is in GDAL version.  
As latest version has highest priority:  
- Should current version be removed?  
- Should packages be downgraded after priority is reversed **manually**?

https://launchpad.net/~ubuntugis/+archive/ubuntu/ubuntugis-unstable

        sudo apt-cache policy libgdal-dev
        libgdal-dev:
          Installed: 2.6.0+2-0xenial1
          Candidate: 2.6.0+2-0xenial1
          Version table:
         *** 2.6.0+2-0xenial1 500
                500 http://ppa.launchpad.net/nextgis/dev/ubuntu xenial/main amd64 Packages
                100 /var/lib/dpkg/status
             2.2.2+dfsg-1~xenial1 500
                500 http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu xenial/main amd64 Packages
             2.1.3+dfsg-1~xenial2 500
                500 http://ppa.launchpad.net/ubuntugis/ppa/ubuntu xenial/main amd64 Packages
             1.11.3+dfsg-3build2 500
                500 http://archive.ubuntu.com/ubuntu xenial/universe amd64 Packages

___

    sudo apt-get install ppa-purge
___

**WARNING!!  
SKIP THIS NEXT COMAND - DO NOT RUN THIS**:

    sudo add-apt-repository -r ppa:nextgis/dev
        You are about to remove the following PPA:
        NextGIS Development builds
        More info: https://launchpad.net/~nextgis/+archive/ubuntu/dev
        Press Enter to continue or Ctrl+C to cancel

    sudo ppa-purge ppa:nextgis/dev
        W:Target Packages (Packages) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en_US) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: GPG error: https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 51716619E084DAB9
        W: The repository 'https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease' is not signed.
        W: GPG error: https://mirror.ibcp.fr/pub/CRAN/bin/linux/ubuntu xenial/ InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 51716619E084DAB9
        W: The repository 'https://mirror.ibcp.fr/pub/CRAN/bin/linux/ubuntu xenial/ InRelease' is not signed.
        W: Target Packages (Packages) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en_US) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        PPA to be removed: nextgis dev
        Warning:  Could not find package list for PPA: nextgis dev
___

    sudo apt-get update
        Ign:1 http://dl.google.com/linux/chrome/deb stable InRelease
        Hit:2 http://archive.ubuntu.com/ubuntu xenial InRelease                           
        Ign:3 http://www.mirrorservice.org/sites/packages.linuxmint.com/packages serena InRelease
        Hit:4 http://ppa.launchpad.net/nathan-renniewaldock/flux/ubuntu xenial InRelease  
        Hit:5 http://archive.ubuntu.com/ubuntu xenial-updates InRelease                   
        Hit:6 http://www.mirrorservice.org/sites/packages.linuxmint.com/packages serena Release
        Get:7 http://archive.ubuntu.com/ubuntu xenial-backports InRelease [107 kB]        
        Get:8 http://security.ubuntu.com/ubuntu xenial-security InRelease [107 kB]        
        Hit:9 http://archive.canonical.com/ubuntu xenial InRelease                        
        Hit:10 http://ppa.launchpad.net/ubuntugis/ppa/ubuntu xenial InRelease             
        Get:11 https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease [3606 B]
        Hit:12 http://dl.google.com/linux/chrome/deb stable Release                       
        Hit:13 http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu xenial InRelease
        Get:14 https://mirror.ibcp.fr/pub/CRAN/bin/linux/ubuntu xenial/ InRelease [3590 B]
        Hit:16 https://download.sublimetext.com apt/stable/ InRelease                     
        Ign:11 https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease
        Ign:14 https://mirror.ibcp.fr/pub/CRAN/bin/linux/ubuntu xenial/ InRelease
        Fetched 221 kB in 1s (137 kB/s)
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

___
    sudo apt-cache policy libgdal-dev
        libgdal-dev:
          Installed: 2.6.0+2-0xenial1
          Candidate: 2.6.0+2-0xenial1
          Version table:
         *** 2.6.0+2-0xenial1 100
                100 /var/lib/dpkg/status
             2.2.2+dfsg-1~xenial1 500
                500 http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu xenial/main amd64 Packages
             2.1.3+dfsg-1~xenial2 500
                500 http://ppa.launchpad.net/ubuntugis/ppa/ubuntu xenial/main amd64 Packages
             1.11.3+dfsg-3build2 500
                500 http://archive.ubuntu.com/ubuntu xenial/universe amd64 Packages
___
    sudo apt-get upgrade
        Reading package lists... Done
        Building dependency tree       
        Reading state information... Done
        Calculating upgrade... Done
        The following packages were automatically installed and are no longer required:
          cdbs dh-translations intltool libdap-dev libdap17v5 libdapclient6v5 libdapserver7v5 libepsilon1 libgdal1i libgeos-3.5.0 libhdf4-0-alt libjasper-dev libkmlbase1
          libkmldom1 libkmlengine1 libminizip1 libmysqlclient-dev libmysqlclient20 libnetcdf-dev libnetcdf11 libogdi3.2 liburiparser1 libwebp-dev libxerces-c-dev
          libxerces-c3.1 mysql-common python-scour unixodbc-dev
        Use 'sudo apt autoremove' to remove them.
        The following packages have been kept back:
          libegl1-mesa libgl1-mesa-dri:i386 libgl1-mesa-dri libwayland-egl1-mesa libxatracker2 r-cran-class r-cran-kernsmooth r-cran-nnet
        The following packages will be upgraded:
          chromium-browser chromium-codecs-ffmpeg-extra cpp-5 cups cups-bsd cups-client cups-common cups-core-drivers cups-daemon cups-ppdc cups-server-common dbus dbus-x11
          firefox firefox-locale-en freerdp-x11 g++-5 gcc-5 gcc-5-base gcc-5-base:i386 gfortran-5 google-chrome-stable grub-common grub-pc grub-pc-bin grub2-common libasan2
          libatomic1 libcc1-0 libcilkrts5 libcups2 libcups2:i386 libcupscgi1 libcupsimage2:i386 libcupsimage2 libcupsmime1 libcupsppdc1 libdbus-1-3 libdbus-1-3:i386
          libegl1-mesa-drivers libfreerdp-cache1.1 libfreerdp-client1.1 libfreerdp-codec1.1 libfreerdp-common1.1.0 libfreerdp-core1.1 libfreerdp-crypto1.1 libfreerdp-gdi1.1
          libfreerdp-locale1.1 libfreerdp-plugins-standard libfreerdp-primitives1.1 libfreerdp-rail1.1 libfreerdp-utils1.1 libgbm1 libgcc-5-dev libgfortran-5-dev libgfortran3
          libgomp1 libitm1 liblsan0 libmpx0 libpam-systemd libpoppler-glib8 libpoppler-qt4-4 libpoppler-qt5-1 libpoppler58 libquadmath0 libstdc++-5-dev libstdc++6:i386
          libstdc++6 libsystemd0 libsystemd0:i386 libtsan0 libubsan0 libudev1 libudev1:i386 libwinpr-crt0.1 libwinpr-dsparse0.1 libwinpr-environment0.1 libwinpr-file0.1
          libwinpr-handle0.1 libwinpr-heap0.1 libwinpr-input0.1 libwinpr-interlocked0.1 libwinpr-library0.1 libwinpr-path0.1 libwinpr-pool0.1 libwinpr-registry0.1
          libwinpr-rpc0.1 libwinpr-sspi0.1 libwinpr-synch0.1 libwinpr-sysinfo0.1 libwinpr-thread0.1 libwinpr-utils0.1 libxfreerdp-client1.1 linux-firmware linux-libc-dev
          poppler-utils r-base-dev r-cran-cluster r-cran-lattice r-cran-nlme r-cran-rpart r-cran-survival systemd systemd-sysv udev x11-common xorg xserver-common
          xserver-xorg xserver-xorg-core xserver-xorg-input-all xserver-xorg-video-all xserver-xorg-video-amdgpu
        114 upgraded, 0 newly installed, 0 to remove and 8 not upgraded.
        Need to get 275 MB of archives.
        After this operation, 83,9 MB of additional disk space will be used.
        Do you want to continue? [Y/n] 
(...)
___

one more time just for fun:

    sudo apt-get upgrade
        [sudo] password for adminuser: 
        Reading package lists... Done
        Building dependency tree       
        Reading state information... Done
        Calculating upgrade... Done
        The following packages were automatically installed and are no longer required:
          cdbs dh-translations intltool libdap-dev libdap17v5 libdapclient6v5 libdapserver7v5 libepsilon1 libgdal1i libgeos-3.5.0 libhdf4-0-alt libjasper-dev libkmlbase1
          libkmldom1 libkmlengine1 libminizip1 libmysqlclient-dev libmysqlclient20 libnetcdf-dev libnetcdf11 libogdi3.2 liburiparser1 libwebp-dev libxerces-c-dev
          libxerces-c3.1 mysql-common python-scour unixodbc-dev
        Use 'sudo apt autoremove' to remove them.
        The following packages have been kept back:
          libegl1-mesa libgl1-mesa-dri:i386 libgl1-mesa-dri libwayland-egl1-mesa libxatracker2 r-cran-class r-cran-kernsmooth r-cran-nnet
        0 upgraded, 0 newly installed, 0 to remove and 8 not upgraded.

___
**ADD repository back** since I removed it earlier -.-' 


    sudo add-apt-repository ppa:nextgis/dev 
        You are about to add the following PPA:
         NextGIS Development builds
         More info: https://launchpad.net/~nextgis/+archive/ubuntu/dev
        Press Enter to continue or Ctrl+C to cancel

        Executing: /tmp/tmp.yUTS08bsD3/gpg.1.sh --keyserver
        hkp://keyserver.ubuntu.com:80
        --recv-keys
        CF0CF9F7
        gpg: requesting key CF0CF9F7 from hkp server keyserver.ubuntu.com
        gpg: key CF0CF9F7: "Launchpad PPA for NextGIS" not changed
        gpg: Total number processed: 1
        gpg:              unchanged: 1
____
Purge removes **packages**?! Does it leave source in source list?!

    sudo ppa-purge ppa:nextgis/dev 
        Updating packages lists
        W: Target Packages (Packages) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en_US) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: GPG error: https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 51716619E084DAB9
        W: The repository 'https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease' is not signed.
        W: GPG error: https://mirror.ibcp.fr/pub/CRAN/bin/linux/ubuntu xenial/ InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 51716619E084DAB9
        W: The repository 'https://mirror.ibcp.fr/pub/CRAN/bin/linux/ubuntu xenial/ InRelease' is not signed.
        W: Target Packages (Packages) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en_US) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        PPA to be removed: nextgis dev
        Package revert list generated:
         gdal-bin- gdal-data- libgdal-dev- libgdal1i- libgdal20- libopencad-dev- 
        libopencad1-

        Disabling nextgis PPA from /etc/apt/sources.list.d/nextgis-dev-xenial.list
        Updating packages lists
        W: Target Packages (Packages) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en_US) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: GPG error: https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 51716619E084DAB9
        W: The repository 'https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/ InRelease' is not signed.
        W: GPG error: https://mirror.ibcp.fr/pub/CRAN/bin/linux/ubuntu xenial/ InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 51716619E084DAB9
        W: The repository 'https://mirror.ibcp.fr/pub/CRAN/bin/linux/ubuntu xenial/ InRelease' is not signed.
        W: Target Packages (Packages) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en_US) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        W: Target Translations (en) is configured multiple times in /etc/apt/sources.list.d/additional-repositories.list:1 and /etc/apt/sources.list.d/additional-repositories.list:2
        Reading package lists... Done
        Building dependency tree       
        Reading state information... Done
        The following packages were automatically installed and are no longer required:
          cdbs dh-translations hdf5-helpers intltool libaec-dev libaec0 libarmadillo-dev libarmadillo6 libarpack2 libarpack2-dev libdap-dev libdap17v5 libdapclient6v5
          libdapserver7v5 libepsilon1 libfreexl1 libgeos-3.5.0 libgeotiff-dev libgeotiff2 libgif-dev libhdf4-0 libhdf4-0-alt libhdf4-dev libhdf5-10 libhdf5-cpp-11 libhdf5-dev
          libjasper-dev libjbig-dev libjson-c-dev libkmlbase1 libkmldom1 libkmlengine1 libminizip1 libmysqlclient-dev libmysqlclient20 libnetcdf-dev libnetcdf11 libogdi3.2
          libopenjp2-7 libopenjp2-7-dev libqhull-dev libqhull7 libspatialite-dev libspatialite7 libsqlite3-dev libsuperlu-dev libsuperlu4 libsz2 libtiff5-dev libtiffxx5
          liburiparser1 libwebp-dev libxerces-c-dev libxerces-c3.1 mysql-common python-scour unixodbc-dev
        Use 'sudo apt autoremove' to remove them.
        The following packages will be REMOVED:
          gdal-bin gdal-data libgdal-dev libgdal1-dev libgdal1i libgdal20 libopencad-dev libopencad1
        0 upgraded, 0 newly installed, 8 to remove and 8 not upgraded.
        After this operation, 78,3 MB disk space will be freed.
        Do you want to continue? [Y/n] 
        (Reading database ... 291599 files and directories currently installed.)
        Removing gdal-bin (2.6.0+2-0xenial1) ...
        Removing libgdal1-dev (1.11.3+dfsg-3build2) ...
        Removing libgdal-dev (2.6.0+2-0xenial1) ...
        Removing libgdal20 (2.6.0+2-0xenial1) ...
        Removing gdal-data (2.6.0+2-0xenial1) ...
        Removing libgdal1i (1.11.3+dfsg-3build2) ...
        Removing libopencad-dev (0.3.3+8-0xenial1) ...
        Removing libopencad1 (0.3.3+8-0xenial1) ...
        Processing triggers for man-db (2.7.5-1) ...
        Processing triggers for libc-bin (2.23-0ubuntu10) ...
        PPA purged successfully
___

    sudo apt-cache policy libgdal-dev 
        libgdal-dev:
          Installed: (none)
          Candidate: 2.2.2+dfsg-1~xenial1
          Version table:
             2.2.2+dfsg-1~xenial1 500
                500 http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu xenial/main amd64 Packages
             2.1.3+dfsg-1~xenial2 500
                500 http://ppa.launchpad.net/ubuntugis/ppa/ubuntu xenial/main amd64 Packages
             1.11.3+dfsg-3build2 500
                500 http://archive.ubuntu.com/ubuntu xenial/universe amd64 Packages
___
   
    sudo apt-get install libgdal1-dev libproj-dev
___

    sudo apt-cache policy libgdal-dev
        libgdal-dev:
          Installed: 2.2.2+dfsg-1~xenial1
          Candidate: 2.2.2+dfsg-1~xenial1
          Version table:
         *** 2.2.2+dfsg-1~xenial1 500
                500 http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu xenial/main amd64 Packages
                100 /var/lib/dpkg/status
             2.1.3+dfsg-1~xenial2 500
                500 http://ppa.launchpad.net/ubuntugis/ppa/ubuntu xenial/main amd64 Packages
             1.11.3+dfsg-3build2 500
                500 http://archive.ubuntu.com/ubuntu xenial/universe amd64 Packages
___
    gdalinfo --version
        bash: /usr/bin/gdalinfo: No such file or directory
___
    
    install.packages("stplanr")

(...)

        installing to /home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/stplanr/libs
        ** R
        ** data
        *** moving datasets to lazyload DB
        ** demo
        ** inst
        ** byte-compile and prepare package for lazy loading
        Error : package ‘lattice’ was installed by an R version with different internals; it needs to be reinstalled for use with this R version
        ERROR: lazy loading failed for package ‘stplanr’
        * removing ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/stplanr’
        Warning in install.packages :
          installation of package ‘stplanr’ had non-zero exit status

        The downloaded source packages are in
	        ‘/tmp/RtmpOGJu7H/downloaded_packages’
___

    install.packages("lattice")
___
Again:

    install.packages("stplanr")
        Installing package into ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5’
        (as ‘lib’ is unspecified)
        trying URL 'https://cloud.r-project.org/src/contrib/stplanr_0.2.6.tar.gz'
        Content type 'application/x-gzip' length 1603631 bytes (1.5 MB)
        ==================================================
        downloaded 1.5 MB

        * installing *source* package ‘stplanr’ ...
        ** package ‘stplanr’ successfully unpacked and MD5 sums checked
        ** libs
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/RcppArmadillo/include" -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"   -DARMA_DONT_PRINT_OPENMP_WARNING -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c RcppExports.cpp -o RcppExports.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/RcppArmadillo/include" -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"   -DARMA_DONT_PRINT_OPENMP_WARNING -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c spatialnetworks.cpp -o spatialnetworks.o
        g++ -std=gnu++11 -shared -L/usr/lib/R/lib -Wl,-Bsymbolic-functions -Wl,-z,relro -o stplanr.so RcppExports.o spatialnetworks.o -L/usr/lib/R/lib -lR
        installing to /home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/stplanr/libs
        ** R
        ** data
        *** moving datasets to lazyload DB
        ** demo
        ** inst
        ** byte-compile and prepare package for lazy loading
        Error in dyn.load(file, DLLpath = DLLpath, ...) : 
          unable to load shared object '/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/rgdal/libs/rgdal.so':
          /home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/rgdal/libs/rgdal.so: undefined symbol: _ZNK10OGRFeature19GetFieldAsInteger64Ei
        ERROR: lazy loading failed for package ‘stplanr’
        * removing ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/stplanr’
        Warning in install.packages :
          installation of package ‘stplanr’ had non-zero exit status

        The downloaded source packages are in
	        ‘/tmp/RtmpOGJu7H/downloaded_packages’
___


    require(rgdal)
        Loading required package: rgdal
        Error: package or namespace load failed for ‘rgdal’ in dyn.load(file, DLLpath = DLLpath, ...):
         unable to load shared object '/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/rgdal/libs/rgdal.so':
          /home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/rgdal/libs/rgdal.so: undefined symbol: _ZNK10OGRFeature19GetFieldAsInteger64Ei
___

intermetzzo...

    sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
    sudo apt-get update
    sudo apt-get install libudunits2-dev libgdal-dev libgeos-dev libproj-dev
    
___

Nekim čudom sad prošlo...

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
        checking for gdal-config... /usr/bin/gdal-config
        checking gdal-config usability... yes
        configure: GDAL: 2.2.2
        checking GDAL version >= 1.11.4... yes
        checking gdal: linking with --libs only... yes
        checking GDAL: /usr/share/gdal/2.2/pcs.csv readable... yes
        configure: pkg-config proj exists, will use it
        configure: PROJ version: 4.9.2
        checking proj_api.h presence and usability... yes
        checking PROJ version >= 4.8.0... yes
        checking projects.h presence and usability... yes
        checking PROJ.4: epsg found and readable... yes
        checking PROJ.4: conus found and readable... yes
        configure: Package CPP flags:  -I/usr/include/gdal
        configure: Package LIBS:  -L/usr/lib -lgdal -lproj
        configure: creating ./config.status
        config.status: creating src/Makevars
        ** libs
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/sp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c OGR_write.cpp -o OGR_write.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/sp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c gdal-bindings.cpp -o gdal-bindings.o
        gcc -std=gnu99 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/sp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g  -c init.c -o init.o
        gcc -std=gnu99 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/sp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g  -c inverser.c -o inverser.o
        gcc -std=gnu99 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/sp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g  -c local_stubs.c -o local_stubs.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/sp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c ogr_geom.cpp -o ogr_geom.o
        gcc -std=gnu99 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/sp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g  -c ogr_polygons.c -o ogr_polygons.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/sp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c ogr_proj.cpp -o ogr_proj.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/sp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c ogrdrivers.cpp -o ogrdrivers.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/sp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c ogrsource.cpp -o ogrsource.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG -I/usr/include/gdal -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/sp/include"    -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c projectit.cpp -o projectit.o
        g++ -std=gnu++11 -shared -L/usr/lib/R/lib -Wl,-Bsymbolic-functions -Wl,-z,relro -o rgdal.so OGR_write.o gdal-bindings.o init.o inverser.o local_stubs.o ogr_geom.o ogr_polygons.o ogr_proj.o ogrdrivers.o ogrsource.o projectit.o -L/usr/lib -lgdal -lproj -L/usr/lib/R/lib -lR
        installing to /home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/rgdal/libs
        ** R
        ** data
        ** inst
        ** byte-compile and prepare package for lazy loading
        ** help
        *** installing help indices
        ** building package indices
        ** installing vignettes
        ** testing if installed package can be loaded
        * DONE (rgdal)

        The downloaded source packages are in
	        ‘/tmp/RtmpOGJu7H/downloaded_packages’
___

    require(rgdal)
        Loading required package: rgdal
        rgdal: version: 1.3-6, (SVN revision 773)
         Geospatial Data Abstraction Library extensions to R successfully loaded
         Loaded GDAL runtime: GDAL 2.2.2, released 2017/09/15
         Path to GDAL shared files: /usr/share/gdal/2.2
         GDAL binary built with GEOS: TRUE 
         Loaded PROJ.4 runtime: Rel. 4.9.2, 08 September 2015, [PJ_VERSION: 492]
         Path to PROJ.4 shared files: (autodetected)
         Linking to sp version: 1.3-1 

___

    install.packages("stplanr")
        Installing package into ‘/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5’
        (as ‘lib’ is unspecified)
        trying URL 'https://cloud.r-project.org/src/contrib/stplanr_0.2.6.tar.gz'
        Content type 'application/x-gzip' length 1603631 bytes (1.5 MB)
        ==================================================
        downloaded 1.5 MB

        * installing *source* package ‘stplanr’ ...
        ** package ‘stplanr’ successfully unpacked and MD5 sums checked
        ** libs
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/RcppArmadillo/include" -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"   -DARMA_DONT_PRINT_OPENMP_WARNING -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c RcppExports.cpp -o RcppExports.o
        g++ -std=gnu++11 -I"/usr/share/R/include" -DNDEBUG  -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/RcppArmadillo/include" -I"/home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/Rcpp/include"   -DARMA_DONT_PRINT_OPENMP_WARNING -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2 -g -c spatialnetworks.cpp -o spatialnetworks.o
        g++ -std=gnu++11 -shared -L/usr/lib/R/lib -Wl,-Bsymbolic-functions -Wl,-z,relro -o stplanr.so RcppExports.o spatialnetworks.o -L/usr/lib/R/lib -lR
        installing to /home/adminuser/R/x86_64-pc-linux-gnu-library/3.5/stplanr/libs
        ** R
        ** data
        *** moving datasets to lazyload DB
        ** demo
        ** inst
        ** byte-compile and prepare package for lazy loading
        ** help
        *** installing help indices
        ** building package indices
        ** installing vignettes
        ** testing if installed package can be loaded
        * DONE (stplanr)

        The downloaded source packages are in
        ‘/tmp/RtmpOGJu7H/downloaded_packages’

7.




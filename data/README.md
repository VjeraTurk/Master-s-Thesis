## Data description

### / 
##### Large data files **are not pushed** to remote / are only available locally

* **SmartCardData** Smartcard ID, Time, Transaction type (21, 22, 31), Metro Station or Bus Line  
Transaction Type:  31-Bus Boarding & 21-Subway Swiped-In  & 22-Subway Swiped-Out  
* **PhoneData** SIM Card ID, Time, Latitude, Longitude   
WARNING:" it is actually Longtude, Latitude

* **TaxiData** Taxi ID, Time, Latitude, Longitude, Occupancy Status, Speed  
Occupancy Status: 1-with passengers & 0-with passengers  
* **BusData** BUS ID, Time, PlateID, Latitude, Longitude, Speed  
* **TruckData**Truck ID, Date Time, Latitude, Longitude, Speed
___
### /samples 

samples of data, **header included**
___
### /cell

OpenCellID https://www.opencellid.org  
token: 87c071c289c482
cell_towers.csv.gz
Updated: 2018-12-01 (911MB)

___

##### file size in bytes, date-time of data acquisition, filename

            2992882 Nov 27 12:40 454.csv.gz
             109719 Nov 27 12:40 455.csv.gz
           14889486 Nov 27 12:41 460.csv.gz
         1947283562 Oct 19 19:58 BusData
         1615783554 Oct 19 19:48 PhoneData
          225656375 Oct 19 18:45 SmartCardData
         1875174152 Nov 25 11:36 TaxiData
         2289131124 Oct 19 20:08 TruckData

          741651985 Mar 14 22:55 cell_towers_2017.csv.gz

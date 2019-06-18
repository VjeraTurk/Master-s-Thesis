### TODO's
* Što je POM, što je 1 ćelija
   * opisati matricu, n x n ?!
* POM -> Telekomunikacijska POM -> Kontekstualizirana POM

#### **PARAMETRI USPOREDBE**
* Koji uvjeti moraju biti zadovoljeni za usporedbu?
   * rezolucija: ne - ona je indikator kvalitete
   * isto područje: da - isti grad
   * isto doba godine: da
   * isto vremensko razdoblje: da (dani, mjeseci godine?)

* statističko učenje - problem klasifikacije za SVAKI PARAMETAR ZASEBNO (parametat!=značajka)
  - odrediti "Granice vrijednosti parametara OD - DO" pronaći optimum

* Međusobna ovisnost parametara
  - ako je velika ćelija, nema potrebe za jako preciznom vremenskom definicijom kraja putovanja
  - važna je optimizacija rezolucije
  - kako ćemo dokazati napredak u odnosu na referentnu?!

**PERIOD** vremenski okvir - o čemu ovisi optimum?
**ŠIRINA UKUPNOG TOKA** po periodu 
   * uz omjer 0 i !0 ćelija?
   * (jednaka će biti ulaznog/izlaznog)
   * distribucija tokova - NE
**REZOLUCIJA** broj ćelija
   * točnost položaja (samo utječe na rezoluciju)
**PROSTORNA PODJELA**
   * OBLIK ĆELIJE
   * (ne)uniformna podjela
**DEFINICIJA PUTOVANJA**
   *  početak/kraj putovanja u dodjeljenom periodu
   *  NAJVAŽNIJE
**SREDSTVO KRETANJA I INFRASTRUKTURA**   eng. mode
   * infrastruktura (npr. samo ceste)
   * sredstvo (npr. samo Taxi)
**JE LI MATRICA KONTEKST ILI SAMO POMAK**
   * gustoća informacija
**ROBUSNOST** 
   * u dodatku šuma - ostaje li matrica vjerna? 

#### Graphical representation (matrix, image)

**COLOUR PALETTE - gray scale?**
   * s koliko nijansi prikazati tokove, 256, manje ili više?!

* heatmapa
* TODO: compare 2 images using 3 definitions of MSSIM, compare results
* 4D, mogu izračunati udaljenost svih stanica jednih od drugih

#### **USPOREDBA** RAZMISLITI
* TAXI POM VS CDR POM ?
* TAXI CPOM VS CDR CPOM ?
* CDR POM VS CDR POM (TWICK TRIP DEFINITION, PERIOD)
* grand-truth

* simulacija cdr?
* simulacija na osnovu non-cdr! --> DA
* zbrojene matrice?! usporedba zbrojenih

#### Matrix
* DONE: Voronoi tessellations (base stations)
* R clipping Lovelence

* IN PROGRESS: generirati POM iz CDR (prema algoritmu iz objevljanog rada- teško)(validirati) --> NE
* NEXT: twickati PERIOD 15min-30min-1h-3h (over under fitting) --> NE
* IN PROGRESS: twickati definiciju KRAJA PUTOVANJA ?! --> NE

* generirati POM iz TAXI (pomoć Petra) --> NE
* generirati CPOM iz CDR i TAXI (pomoć Petra, TehRep) -->NE

#### R
* DONE: instalirati noviju verziju! # upgraded to R version 3.5.1 (2018-07-02) -- "Feather Spray"
* DONE: instaliran gdal, rgdal, stplanr

#### Paper

* IN PROGRESS: Sadržaj
* IN PROGRESS: RELATED WORK-> pozvati se na radove, spomenuti ključne ljude

* Prometna vs Napredna
* Fizička mobilnost vs socio-ekonomska aktivnost

* Voronoi ćelije vs druga prostorna podjela
* skalabilnost


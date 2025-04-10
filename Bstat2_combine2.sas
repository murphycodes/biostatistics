/**********************************************/
/************* Biostatistics II ***************/
/**************** Spring 2025 *****************/
/************ Combining Data Sets *************/
/**********************************************/

* Download a zip folder with 5 data sets;

* Unzip/extract the folder;

* Create a SAS library that connected to the folder;
Libname combine "C:\Users\bcho1\OneDrive - University of Tennessee\Course_prep\spring2025\SAS_lab\combine_datasets";

* Check data sets in the SAS library if you correctly linked the downloaded folder;


/*@@@@@@@ SAS Exercise 1) Understanding Code for Merging and Stacking Multiple Data Sets@@@@@@@*/


/*** Merging Multiple Data Sets***/

* Copy data sets in the Work library; 
data data1; set combine.data1; run;
data data2; set combine.data2; run;
data data3; set combine.data3; run;

* Check data structure (observations and variables);
proc print data=data1; run;
proc print data=data2; run;
proc print data=data3; run;

* Merge data sets ==> Add more variables for the same observations;
* Two data sets;
data merge1;
merge data1 data2;
by id; 
run;
* Three data sets;
data merge2;
merge data1 data2 data3;
by id; 
run;

* Check merged data sets;
proc print data=merge1; run;
proc print data=merge2; run;

* Sort each data set by "id" variable;
proc sort data=data1; by id; run;
proc sort data=data2; by id; run;
proc sort data=data3; by id; run;

* Merge again using sorted data sets;
* Two data sets;
data merge1;
merge data1 data2;
by id; 
run;
* Three data sets;
data merge2;
merge data1 data2 data3;
by id; 
run;

* Check again merged data sets;
proc print data=merge1; run;
proc print data=merge2; run;


/*** Stacking Multiple Data Sets***/

* Copy data sets in the Work library; 
data north; set combine.north; run;
data south; set combine.south; run;

* Check data structure (observations and variables);
proc print data=north; run;
proc print data=south; run;

* Stack data sets ==> Add more observations (different variables are fine);
data stack1;
	set north south;
run;

* Check a stacked data set;
proc print data=stack1; run;


/*@@@@@@@ SAS Exercise 2) Application: Stacking Multiple Data Sets@@@@@@@*/


**********************************************************************************;
* Download 2019-2023 BRFSS data files from the CDC webpage;
* Create BRFSS folder on your desktop and save the BRFSS data files;
* And then, change the file path in the following libname statement, except the last part "\LLCP2019.xpt""\LLCP2020.xpt""\LLCP2021.xpt";

* 2019 BRFSS, n = 418,268;
libname xptfile xport 'C:\Users\murphy\OneDrive - University of Tennessee\Datasets\BRFSS\LLCP2019.XPT' access=readonly; 
proc copy inlib=xptfile outlib=work;
run;
* 2020 BRFSS, n = 401,958;
libname xptfile xport 'C:\Users\murphy\OneDrive - University of Tennessee\Datasets\BRFSS\LLCP2020.XPT' access=readonly; 
proc copy inlib=xptfile outlib=work;
run;
* 2021 BRFSS, n = 438,693;
libname xptfile xport 'C:\Users\murphy\OneDrive - University of Tennessee\Datasets\BRFSS\LLCP2021.XPT' access=readonly; 
proc copy inlib=xptfile outlib=work;
run;
* 2022 BRFSS, n = 445,132;
libname xptfile xport 'C:\Users\murphy\OneDrive - University of Tennessee\Datasets\BRFSS\LLCP2022.XPT' access=readonly; 
proc copy inlib=xptfile outlib=work;
run;
* 2023 BRFSS, n = 433,323;
libname xptfile xport 'C:\Users\murphy\OneDrive - University of Tennessee\Datasets\BRFSS\LLCP2023.XPT' access=readonly; 
proc copy inlib=xptfile outlib=work;
run;

* Keep only core varaibles for your project;
data BRFSS19; set LLCP2019; 
	keep _SEX _IMPRACE _SMOKER3 _PSU _STSTR _LLCPWT ;
run;

data BRFSS20; set LLCP2020; 
	keep _SEX _IMPRACE _SMOKER3 _PSU _STSTR _LLCPWT ECIGNOW;
run;

data BRFSS21; set LLCP2021; 
	keep _SEX _IMPRACE _SMOKER3 _PSU _STSTR _LLCPWT ECIGNOW1;
run;

data BRFSS22; set LLCP2022; 
	keep _SEX _IMPRACE _SMOKER3 _PSU _STSTR _LLCPWT ECIGNOW2;
run;

data BRFSS23; set LLCP2023; 
	keep _SEX _IMPRACE _SMOKER3 _PSU _STSTR _LLCPWT ECIGNOW1;
run;

* Create an indicator of survey year;
data BRFSS19; set BRFSS19; 
	survey=0;
run;
data BRFSS20; set BRFSS20;
	survey=1;
run;
data BRFSS21; set BRFSS21;
	survey=2;
run;
data BRFSS22; set BRFSS22;
	survey=3;
run;
data BRFSS23; set BRFSS23;
	survey=4;
run;


* Stack BRFSS 2019, 2020, 2021, 2022, and 2023 data sets;
data combinedBRFSS;
	set BRFSS19 BRFSS20 BRFSS21 BRFSS22 BRFSS23;
run;
* N = 2,137,374;

*** Change variable name***;
*Sex;
data combinedBRFSS; set combinedBRFSS;
	if _SEX = 1 then male = 1;
	if _SEX = 2 then male = 0;
run;
*1: male, 0: female;

*RACEETH --> race_eth;
data combinedBRFSS; set combinedBRFSS;
	if _imprace = 1 then race_eth = 0;
	if _imprace = 2 then race_eth = 1;
	if _imprace = 3 then race_eth = 3;
	if _imprace = 4 then race_eth = 3;
	if _imprace = 5 then race_eth = 2;
	if _imprace = 6 then race_eth = 3;
run;
*0: NH-White, 1: NH-Black, 2: Hispanic, 3: NH-Others;

*Current smoking;
data combinedBRFSS; set combinedBRFSS;
	if _SMOKER3 = 1 then c_smoking = 1;
	if _SMOKER3 = 2 then c_smoking = 1;
	if _SMOKER3 = 3 then c_smoking = 0;
	if _SMOKER3 = 4 then c_smoking = 0;
	if _SMOKER3 = 9 then c_smoking = .;
run;
*1: current (every day or some days) smoker, 0: no current smoker (never/former smoker);

*** Change variables***;

* Check differences in variables by survey year;
proc freq data = combinedBRFSS;
	table _SEX male race_eth _smoker3 c_smoking survey;
run;

proc freq data = combinedBRFSS;
	table (male race_eth c_smoking)*survey /chisq;
run;

* Delete any missing observations;
data combinedBRFSS; set combinedBRFSS;
	if male = . | race_eth = . | c_smoking = . then delete;
run;
* n = 2,013,852;

* Create a new weight variable; 
data combinedBRFSS; set combinedBRFSS;
	new_weight = _LLCPWT / 5; * divide by # of combined survey data sets;
run;

*** Conduct planned statistical analysis;
proc surveyfreq data = combinedBRFSS;
	cluster _PSU;
	strata _STSTR;
	weight new_weight;
	table survey * c_smoking / chisq cl row;
run;

proc surveylogistic data = combinedBRFSS;
	class race_eth (ref = '0') survey (ref = '0') / param=ref;
	cluster _PSU;
	strata _STSTR;
	weight new_weight;
	model c_smoking (event = '1') = male race_eth survey;
run;

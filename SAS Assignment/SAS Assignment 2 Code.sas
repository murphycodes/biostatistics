* SAS Assignment 2;

* Create dataset for BRFSS;

libname xptfile xport 'G:\My Drive\Spring 2025\Biostatistics II\Datasets\BRFSS\LLCP2023.XPT' access=readonly; 
proc copy inlib = xptfile outlib = work;
run;

data BRFSS2023; *Copied data; 
set LLCP2023;   *Original data;
run;

* Question 1
** Employment status;

proc freq data = BRFSS2023;
table EMPLOY1;
run;

data BRFSS2023;
set BRFSS2023;
if EMPLOY1 = 1 then employmentStatus = 1; * employed or self employed;
if EMPLOY1 = 2 then employmentStatus = 1;
if EMPLOY1 = 3 then employmentStatus = 0; * unemployed;
if EMPLOY1 = 4 then employmentStatus = 0;
if EMPLOY1 = 5 then employmentStatus = 2; * student/homemaker/retired/unable to work;
if EMPLOY1 = 6 then employmentStatus = 2;
if EMPLOY1 = 7 then employmentStatus = 2;
if EMPLOY1 = 8 then employmentStatus = 2;
if EMPLOY1 = 9 then employmentStatus = 3; * missing/refused;
if EMPLOY1 = '' then employmentStatus = 3;
run;

proc freq data = BRFSS2023;
table employmentStatus;
run;

** Ever tested for HIV? (var = HIVTST7);

proc freq data = BRFSS2023;
table HIVTST7;
run;

data BRFSS2023;
set BRFSS2023;
if HIVTST7 = 1 then testedForHIV = 1; * been tested;
if HIVTST7 = 2 then testedForHIV = 0; * never been tested;
if HIVTST7 = 7 then testedForHIV = 2; * dunno/refused/missing;
if HIVTST7 = 9 then testedForHIV = 2;
if HIVTST7 = '' then testedForHIV = 2;
run;

proc freq data = BRFSS2023;
table testedForHIV;
run;

** How often use seatbelts in car? (var = SEATBELT);

proc freq data = BRFSS2023;
table SEATBELT;
run;

data BRFSS2023;
set BRFSS2023;
if SEATBELT in (1:4) then seatbeltUse = 1; * use seatbelts;
if SEATBELT = 5 then seatbeltUse = 0; * doesn't use seatbelts;
if SEATBELT = 7 then seatbeltUse = 3; * not sure/don't know/missing data/refused;
if SEATBELT = 9 then seatbeltUse = 3;
if SEATBELT = '' then seatbeltUse = 3;
if SEATBELT = 8 then seatbeltUse = 2; * does't drive or ride in car;
run;

proc freq data = BRFSS2023;
table seatbeltUse;
run;

* Question 2;

*** Times fallen within the past 12 months, var = FALL12MN;

data BRFSS2023; 
set BRFSS2023;
if FALL12MN in (1:76) then timesFallen = FALL12MN; * 1 to 76 times;
if FALL12MN = 88 then timesFallen = 0; * never fallen;
if FALL12MN = 77 then timesFallen = .; * don't know;
if FALL12MN = 99 then timesFallen = .; * refused;
if FALL12MN = '' then timesFallen = .; * missing data;
run;

proc univariate data = BRFSS2023;
var FALL12MN timesFallen;
run;

*** Marijuana/hashish usage, var = MARIJAN1;

data BRFSS2023;
set BRFSS2023;
if MARIJAN1 = 88 then cannabisUse = 0; * 0 time;
if MARIJAN1 in (1:30) then cannabisUse = MARIJAN1; * 1 to 30 times;
if MARIJAN1 = 77 then cannabisUse = .; * don't know/not sure;
if MARIJAN1 = 99 then cannabisUse = .; * refused;
run;

proc univariate data = BRFSS2023;
var MARIJAN1 cannabisUse;
run;

* Question 3;

*** var = timesFallen (FALL12MN);

proc univariate data = BRFSS2023 noprint;
histogram timesFallen / normal;
run;

proc univariate data = BRFSS2023 noprint;
histogram cannabisUse / normal;
run;

* Question 4;

*** var = FALL12MN;

data BRFSS2023;
set BRFSS2023;
if FALL12MN in (1:38) then timesFallenStrat = 1; * fell 1 to 38 times;
if FALL12MN in (39:76) then timesFallenStrat = 2; * fell 39 to 76 times;
if FALL12MN = 88 then tunesFallenStrat = .; * never fallen;
if FALL12MN = 77 then tunesFallenStrat = .; * don't know;
if FALL12MN = 99 then tunesFallenStrat = .; * refused;
if FALL12MN = '' then tunesFallenStrat = .; * missing data;
run;

*** var = MARIJAN1;

data BRFSS2023;
set BRFSS2023;
if MARIJAN1 = 88 then cannabisUseStrat = .; * don't use;
if MARIJAN1 = 77 then cannabisUseStrat = .; * don't know/not sure;
if MARIJAN1 = 99 then cannabisUseStrat = .; * refused;
if MARIJAN1 = '' then cannabisUseStrat = .; * missing data;
if MARIJAN1 in (1:10) then cannabisUseStrat = 1; * used cannabis/hashish 1 to 10 days;
if MARIJAN1 in (11:20) then cannabisUseStrat = 2; * used cannabis/hashish 11 to 20 days;
if MARIJAN1 in (21:30) then cannabisUseStrat = 3; * used cannabis/hasish 21 to 30 days;
run;

proc freq data = BRFSS2023;
table cannabisUseStrat;
run;

*********************************
*********************************
**                             **
**  PUBH 532 SAS Assignment 1  **
**                             **
*********************************
*********************************

* Question 1;

libname assign1 'G:\My Drive\Spring 2025\Biostatistics II\SAS Assignments\Assignment 1\YRBS 2023';

proc contents;
run;

* Question 2;

libname assign1 'G:\My Drive\Spring 2025\Biostatistics II\SAS Assignments\Assignment 1\YRBS 2023';

* proc import 
	datafile = 'G:\My Drive\Spring 2025\Biostatistics II\SAS Assignments\Assignment 1\YRBS 2023\XXH2023_YRBS_Data.dat'
	out = assign1.yrbs2023
run;

proc freq data = assign1.yrbs2023;
table Q8;
run;

*Question 3;

proc freq data = assign1.yrbs2023;
table Q25;
run;

* Question 4;

libname xptfile xport 'G:\My Drive\Spring 2025\Biostatistics II\SAS Assignments\Assignment 1\BRFSS 2023\LLCP2023.XPT' access=readonly; 
proc copy inlib=xptfile outlib=work;
run;

data BRFSS2023;
set LLCP2023;
run;

proc contents data = BRFSS2023;
run;

* Question 5;

proc freq data = BRFSS2023;
table CVDINFR4/missing;
run;

* Question 6 - Insurance, var = _HLTHPL1;

proc freq data = BRFSS2023;
table _HLTHPL1/missing;
run;

/* SAS Assignment 6 */
/*  Thomas Murphy  */

/* Merging Datasets */

libname assign 'C:\Users\murphy\OneDrive - University of Tennessee\Spring 2025\Biostatistics II\Assignments\Assignment 6'; run;
data yearOne; set assign.year1; run;
data yearTwo; set assign.year2; run;
data yearThree; set assign.year3; run;

data combinedData; set yearOne yearTwo yearThree; run;

proc freq data = combinedData;
	table c_smoking male race_eth dep child_house survey;
run;

/* Q1 */

proc freq data = combinedData;
	table survey * c_smoking / chisq;
run;

/* Q2 */

proc surveylogistic data = combinedData nomcar varmethod = TAYLOR; 
	class male (ref = "0") race_eth (ref = "0") dep (ref = "0") child_house (ref = "0") survey (ref = "0");
	model c_smoking (event = "1") = male race_eth dep child_house survey;
run;

proc surveylogistic data = combinedData nomcar varmethod = TAYLOR; 
	class male (ref = "0") race_eth (ref = "0") dep (ref = "0") child_house (ref = "0") survey (ref = "1");
	model c_smoking (event = "1") = male race_eth dep child_house survey;
run;

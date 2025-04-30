/* SAS Assignment 8 */

libname assign "C:\Users\murphy\OneDrive - University of Tennessee\Spring 2025\PUBH 531 - Biostatistics II\Assignments\Assignment 8";
data assignData; set assign.assignment8; run;

* Test 1: Model 1 vs. Model 2;
proc logistic data = assignData; 
	model c_ecig (event = "1") = mh_nogood;
run;
* AIC = 2862.104;

proc logistic data = assignData; 
	model c_ecig (event = "1") = ph_nogood;
run;
* AIC = 2904.091;
* Method 1 is better as AIC is smaller;

* Test 2: Model 1 vs. Model 3;
proc logistic data = assignData; 
	model c_ecig (event = "1") = mh_nogood ph_nogood;
run;
* p < 0.001, model 3 is better;

* Test 3: Model 3 vs. Model 4;
proc logistic data = assignData; 
	class race_eth (ref = "0") / param = ref;
	model c_ecig (event = "1") = mh_nogood ph_nogood race_eth;
run;
* p < 0.001, model 4 is better;

* Test 4: Model 4 vs. Model 5;
proc logistic data = assignData;
	class bmi_c (ref = "0") / param = ref;
	model c_ecig (event = "1") = mh_nogood ph_nogood bmi_c;
run;
* Model 4 AIC = 2755.961, Model 5 AIC = 2629.607;
* Model 5 is a better fit due to smaller AIC;

* Test 5: Model 5 vs. Model 6;
proc logistic data = assignData;
	class bmi_c (ref = "0") race_eth (ref = "0") / param = ref;
	model c_ecig (event = "1") = mh_nogood ph_nogood bmi_c race_eth;
run;
* p < 0.001, model 6 fits better;

* Test 6: Model 6 vs. Model 7;
proc logistic data = assignData;
	class bmi_c (ref = "0") race_eth (ref = "0") male (ref = "0") / param = ref;
	model c_ecig (event = "1") = mh_nogood ph_nogood bmi_c race_eth male;
run;
* p = 0.007, model 7 fits better;

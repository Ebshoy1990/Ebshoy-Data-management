* Ps2 - Data management - Spring 2022
* Ebshoy Mikhaeil

clear
version 16
set more off
cd "D:\PhD- Rutgers Camden\Second semester\Data management\Problems sets\Problems set 2" // specifying my working directory 

use "https://docs.google.com/uc?id=1ATOIRJRgt97_DDyEz8gYHeO2uhm0_Tpq&export=download",clear // This is the first part of the latest wave of Egypt labor market panel survey dataset. 

/* The survey is conducted in cooperation between the Economic Research Forum (ERF) and The public statisical agency in Egypt.
Four waves (1998,2006,2012 and 2018) have been conducted so far.
The dataset is publicly available but the researcher needs to submit a request first and it has to be approved by the ERF data team.
The reason for using this dataset: It is a very rich panel dataset with about 3810 variables in the fourth wave. The dataset includes a number of variables on job satisfaction. I will be using these variables to study job satisfaction across different employment sectors in Egypt as part of the empirical paper required for Quantitative methods 2 class.
Link: http://www.erfdataportal.com/index.php/catalog#_r=&collection=LMPS&country=&dtype=&from=1963&page=1&ps=15&sid=&sk=&sort_by=nation&sort_order=&to=2021&topic=&view=s&vk= 
*/

recode sex (1=1) (2=0) // recoding the gender variable 
label define sex 0 "female" 1 "male",replace // modifying the value labels of the gender variable to match the new coding

bysort sex: egen meanyrschool=mean(yrschl) // calculating the average years of school by gender

* generating a dummy variable of whether the repsondent is still studying or not
gen studying = student 
replace studying=1 if studying==1
replace studying=0 if studying==2

save elmps1-ps1,replace

use "https://docs.google.com/uc?id=1_2FTZfFrFcv6LQ1bAR4zFZXTkDDfkrG6&export=download",clear // This is the second part of the survey's fourth wave dataset.

save elmps2-ps1,replace

* doing the first merge 
use elmps1-ps1,clear // The master dataset
merge 1:1 indid hhid using elmps2-ps1 // doing the merge 

save elmpsfirstmerge,replace

use "https://docs.google.com/uc?id=1QtUUGWA2yA2J5ozGlsGnhkkXDyvo1iIB&export=download",clear // Here i'm calling the third part of the dataset 

* doing the second merge: between the first two parts which were merged above and the third part
merge 1:1 indid hhid using elmpsfirstmerge,nogenerate // I put the nogeneratre option because stata showed me an error that the variable _merge was already define, so i suppressed the creation of the merge var of the second merge. 

save elmpsfullmerge,replace

//but merging same data with same data--thats fine, often need to do that, but here we need to merge with some other data, say world bank, egyptian census, etc


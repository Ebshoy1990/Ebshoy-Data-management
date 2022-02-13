* Ps2 - Data management - Spring 2021
* Ebshoy Mikhaeil

clear
version 16
set more off
cd "D:\PhD- Rutgers Camden\Second semester\Data management\Problems sets\Problems set 2" // specifying my working directory 

use "https://docs.google.com/uc?id=1ATOIRJRgt97_DDyEz8gYHeO2uhm0_Tpq&export=download",clear // This is the first part of the latest wave of Egypt labor market panel survey dataset. 

/* The survey is conducted in cooperation between the Economic Research Forum (ERF) and The government statisical agency in Egypt.
Four waves (1998,2006,2012 and 2018) have been conducted so far.
The dataset is publicly available but the researcher needs to submit a request first and it has to be approved by the ERF data team.
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

use "https://docs.google.com/uc?id=1_2FTZfFrFcv6LQ1bAR4zFZXTkDDfkrG6&export=download",clear

save elmps2-ps1,replace

use elmps1-ps1,clear // The master dataset
merge 1:1 indid hhid using elmps2-ps1 // doing the merge 



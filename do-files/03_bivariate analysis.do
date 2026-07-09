*PROJECT: Perceived Social Support & Common Mental Health Disorders among Pregnant and Parenting AGYW

*PURPOSE: BIVARIATE ANALYSIS

*AUTHOR: NITA CLARIS

*DATE: NOVEMBER 2023


***Set the working directory
cd "C:\STATA DATASETS"

***load the data
use "PMH_CLEAN_2.dta", clear

*****Generate the study arm variable 

encode EVERPREGNANT,gen(studyarm)

*****************LEVELS OF CMD AMONG PARENTING AND NON PARENTING ***************

// install table1_mc
ssc install table1_mc

// now specify things by "the StudyArm"
table1_mc, by(StudyArm) ///
vars( ///
PTSD cat %4.0f \ ///
GAD_Score cate %4.0f \ ///
Depression_Score cate %4.0f \ ///
) ///
onecol test statistic total(before) ///
saving("CMD by Study Arm.xlsx", replace)


***************************CMD BY DEMOGRAPHICS**********************************
********************************************************************************


****************SOCIO-DEMOGRAPHIC DETERMINANTS OF DEPRESSION********************

// now specify things by depression

table1_mc, by(Depressed_Score) ///
vars( ///
studyarm cat %4.0f \ ///
age contn %4.0f \ ///
Mother_Age cate %4.0f \ ///
MaritalStatus_new cat %4.0f \ ///
MarriedAge cat %4.0f \ ///
Education_level cat %4.0f \ ///
Occupation_Status cat  %4.0f \ ///
MentalIllness cate  %4.0f \ ///
Loss cat %4.0f \ ///
) ///
onecol test statistic total(before) ///
saving("depression_demographics.xlsx", replace)

*****************SOCIO-DEMOGRAPHIC DETERMINANTS OF ANXIETY**********************

// now specify things by anxiety
table1_mc, by(GAD_Score) ///
vars( ///
studyarm cat %4.0f \ ///
age contn %4.0f \ ///
Mother_Age cate %4.0f \ ///
MaritalStatus_new cat %4.0f \ ///
MarriedAge cat %4.0f \ ///
Education_level cat %4.0f \ ///
Occupation_Status cat  %4.0f \ ///
MentalIllness cate  %4.0f \ ///
Loss cat %4.0f \ ///
) ///
onecol test statistic total(before) ///
saving("anxiety_demographics.xlsx", replace)

*****************SOCIO-DEMOGRAPHIC DETERMINANTS OF PTSD*************************

// now specify things by ptsd
table1_mc, by(PTSD) ///
vars( ///
studyarm cat %4.0f \ ///
age contn %4.0f \ ///
Mother_Age cate %4.0f \ ///
MaritalStatus_new cat %4.0f \ ///
MarriedAge cat %4.0f \ ///
Education_level cat %4.0f \ ///
Occupation_Status cat  %4.0f \ ///
MentalIllness cate  %4.0f \ ///
Loss cat %4.0f \ ///
) ///
onecol test statistic total(before) ///
saving("ptsd_demographics.xlsx", replace)



save PMH_CLEAN_Final.dta,replace

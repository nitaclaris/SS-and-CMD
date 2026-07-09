*PROJECT: Perceived Social Support & Common Mental Health Disorders among Pregnant and Parenting AGYW

*PURPOSE: MODIFIED POISSON REGRESSION

*AUTHOR: NITA CLARIS

*DATE: NOVEMBER 2023


***Set the working directory
cd "C:\Users\Nita\OneDrive\Desktop\PMH Datasets\STATA DATASETS"

***load the data
use "PMH_CLEAN_Final.dta", clear


local Factors seekhelpreligion_leaders discuss_mental_health neg_preg_reaction postive_reaction_to_baby isolatedfamactivities restriction_to_cook decisionmadeforyou lack_of_interaction seeking_help beliefs_and_practices forced_mirrage husband_support more_prayerful child_before_mirrage forced_sex

foreach var in `Factors'{
  encode `var', gen (f_`var') 
}

// set the file to write the output/Do the layout /


putexcel set "C:\Users\Nita\OneDrive\Desktop\Manuscript\Inferential.xls", replace  

putexcel A1 = "The Role of Social Support on the Mental Health of Adolescent Girls and Young Women."
putexcel C2 =  "N"
putexcel D2 =  "n"
putexcel E2 =  "Row %"
putexcel F2 =  "OR(95%CI)"
putexcel G2 =  "p value"
putexcel H2 =  "aOR(95% CI)"
putexcel I2 =  "p value"


local current_row=4

local row = `current_row'

// The overall denominator 
count 
local denominator_overall = r(N)


foreach var of varlist  SocialSupport_Score studyarm Mother_Age MentalIllness f_seekhelpreligion_leaders f_neg_preg_reaction f_lack_of_interaction f_forced_mirrage {

	
	levelsof `var',local(covariates)
	local varlbl: var label `var'

	
	
foreach item of local covariates {
local item_label : label (`var') `item'

di "`varlbl'"
	
	

	* The proportions for the covariates 
	
	count if `var'==`item'  
	local numerator = `r(N)'
	local percent_numerator: display %3.2f (`numerator'/`denominator_overall')*100
	
	
	
	count if `var'==`item'  & Depressed_Score==1
	local outcome_numerator = `r(N)'
	local percent_outcome: display %3.2f (`outcome_numerator'/`numerator')*100


	* poisson Regression 
	glm  Depressed_Score  i.`var',family(poisson) link(log) vce(robust) eform   // Unadjusted ORs 
	matrix overall = r(table)
	matrix list overall
	di overall[1,1]
	local odss_overall: display %3.2f (overall[1,`item' +1])
		 if `odss_overall'== 1 {									
								local odss_overall "1"									
								}
								else {
								local odss_overall: display %3.2f (overall[1,`item' +1])
								}
	
	local ll_overall : display %3.2f (overall[5,`item' +1])
	
		 if `ll_overall'== . {									
								local ll_overall " " 									
								}
								else {
					local ll_overall : display %3.2f (overall[5,`item' +1])
								}
	

	local ul_overall : display %3.2f (overall[6,`item'+1])
	
			 if `ul_overall'== . {									
								local ul_overall " " 									
								}
								else {
					local ul_overall : display %3.2f (overall[6,`item' +1])
								}
	

	local pvalue : display %5.3f (overall[4,`item'+1])
	
											if `pvalue'<0.001{
											local pvalue <0.001
										}
										else{
											local pvalue: display %5.3f `pvalue'
										}

		
										else if `pvalue'==. {
											local pvalue " "
										}
										else{
											local pvalue: display %5.3f `pvalue'
										}

	
		

	* Full adjusted 
 glm  Depressed_Score b1.SocialSupport_Score i.studyarm i.Mother_Age i.MentalIllness i.f_seekhelpreligion_leaders i.f_forced_sex  i.f_lack_of_interaction, family(poisson) link(log) vce(robust) eform
	
	matrix adjafull = r(table)
	matrix list adjafull
	di adjafull[1,1]
	local odss_adjfull: display %3.2f (adjafull[1,`item' +1])
		 if `odss_adjfull'== 1 {									
								local odss_adjfull "1"									
								}
								else {
								local odss_adjfull: display %3.2f (adjafull[1,`item' +1])
								}
	
	local ll_adjfull : display %3.2f (adjafull[5,`item' +1])
	
		 if `ll_adjfull'== . {									
								local ll_adjfull " " 									
								}
								else {
					local ll_adjfull : display %3.2f (adjafull[5,`item' +1])
								}
	

	local ul_adjfull : display %3.2f (adjafull[6,`item'+1])
	
			 if `ul_adjfull'== . {									
								local ul_adjfull " " 									
								}
								else {
					local ul_adjfull : display %3.2f (adjafull[6,`item' +1])
								}
	

	local pvalue2 : display %5.3f (adjafull[4,`item'+1])
	
											if `pvalue2'<0.001{
											local pvalue2 <0.001
										}
										else{
											local pvalue2: display %5.3f `pvalue2'
										}

		
										else if `pvalue2'==. {
											local pvalue2 " "
										}
										else{
											local pvalue2: display %5.3f `pvalue2'
										}

										
	if `item'==1 {
	putexcel A`row'= "`varlbl'"
	}
	 
	putexcel B`row'= "`item_label'" 
	putexcel C`row'=`numerator' 
	putexcel D`row'=`outcome_numerator'
	putexcel E`row'=  `percent_outcome'
	putexcel F`row' = "`odss_overall'(`ll_overall'-`ul_overall')" 
	putexcel G`row' = "`pvalue'" 

	putexcel H`row'="`odss_adjfull'(`ll_adjfull'-`ul_adjfull')"
	putexcel I`row'= "`pvalue2'"
	local row = `row'+1
	
	}
	}
* 

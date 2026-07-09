*PROJECT: Perceived Social Support & Common Mental Health Disorders among Pregnant and Parenting AGYW

*PURPOSE: Data Cleaning & manipulation

*AUTHOR: NITA CLARIS

*DATE: NOVEMBER 2023


***Set the working directory
cd "C:\STATA DATASETS"

***load the data
use "PMH_CLEAN.dta", clear


***keep only the variables needed for this analysis 

keep PTID  PMHPTID DATEOFENROLLMENT STATUS note_ptid visit_date  EVERPREGNANT STAFF CODE dob_choice age marital_status polygamous_family married_age level_of_education level_of_education_spouse most_time_doing most_time_doing_spouse no_of_pregnancies no_of_live_births baby_age age_in_months age_in_years ChIldren_living_with_you baby_breastfeeding planned_pregnancy birth_place birth_place_other during_pregnancy other_during_pregnancy describe_pegnancy baby_treatment child_gender health_care_provider_support primary_care_giver tribe religion household_size caring_for_baby other_caring_for_baby occupation mental_illness_problems suffered_loss note_D able_to_laugh enoyment_to_things blamed_yourself anxious_worried felt_scared things_getting_on_top unhappy_not_sleeping sad_miserable unhappy_been_crying thought_of_harming_self group_section_Enote_e note_sectionF note_F seek_help_religion_leaders discuss_mental_health negative_pregnancy_reaction_by_f postive_reaction_to_baby isolated_from_family_activities restriction_to_cook decisions_made_on_your_behalf lack_of_interaction seeking_help beliefs_and_practices forced_mirrage husband_support more_prayerful child_before_mirrage forced_sex birth_and_parenting note_N special_person_around_n special_person_share_joy_with family_helps_n emortional_help_n special_person_source_of_help friends_try_to_help_n count_on_friends_n talk_about_problems_n friends_share_joys_n special_person_who_cares_n family_willing_to_help_n talk_about_problems_w_friends metainstanceID  little_interest feeling_down trouble_sleeping tired note_g poor_appetite feeling_bad_about_self trouble_concentrating speaking_slowly death_thoughts problems_made_it_hard_sectionG note_sectionH note_h partner_physically_hurt_you partner_insulted_you partner_threatened_you partner_screamed_at_you note_sectionI note_I feeling_nervous_anxious uncontroled_worrying worrying_to_much_about_things trouble_relaxing2 restless easily_annoyed_irritable feeling_afraid_anout_something_a problems_made_it_hard_sectionI no_of_pregnancies marital_status


////////////////////SOCIO-DEMOGRAPHIC FACTORS //////////////////////////////////

*age
recode age (16/20=1 "<=20") (20/24=2 "20-24"), gen(Mother_Age)
label var Mother_Age "Mother's Age Category" 

tab Mother_Age

*marital status
recode Marital_Status (0 2=1 "Single/Ever Married") (1=2 "Married/Living Together with Partner"),gen (MaritalStatus_new)
label var MaritalStatus_new "Marital_Status" 

tab MaritalStatus_new

*married age
recode married_age (16/20=1 "<=20") (20/24=2 "20-24"), gen(MarriedAge)
label var MarriedAge "At what age were you married?" 

tab MarriedAge

*no of pregnancies
recode no_of_pregnancies (0=1 "0") (1=2 "1-2") (2 3 4=3 ">=2"),gen (No_of_Pregnancies)
label var No_of_Pregnancies "How many pregnancies have you had?" 

tab No_of_Pregnancies 

*no of livebirths
recode no_of_live_births (0 =1 "0") (1 2=2 "1-2") (3=3 ">=2"),gen (No_of_Livebirths)
label var No_of_Livebirths "How many livebirths have you had?" 

tab No_of_Livebirths 

******Convert string vars to categorical numerical vars

encode planned_pregnancy, gen(Planned_preg)
*modify labels  
tab Planned_preg
label var Planned_preg Planned_preg
label define Planned_preg 1 "No" 2 "Yes", modify
label values Planned_preg  Planned_preg*

encode occupation,gen (Occupation)
*recode the values
recode Occupation (1 2 4=1 "Skilled") (3 5 6=2 "Unskilled") ,gen (Occupation_Status)
label var Occupation_Status "What is your Occupation?" 
tab Occupation_Status

encode child_gender,gen (Child_Gender)
encode level_of_education_spouse ,gen(Spouse_education_level)
encode most_time_doing ,gen(Spend_time)
encode religion ,gen(Religion)
encode suffered_loss ,gen(Loss)
encode mental_illness_problems ,gen(MentalIllness)
encode child_before_mirrage, gen (Child_before_marriage)


***********Merge with another dataset containing more demographic information***
merge 1:1 PTID using "C:\STATA DATASETS\Demographics.dta"



**save the dataset
save "PMH_CLEAN_1.dta", replace



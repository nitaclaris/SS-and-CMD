*PROJECT: Perceived Social Support & Common Mental Health Disorders among Pregnant and Parenting AGYW

*PURPOSE: Generate Working variables

*AUTHOR: NITA CLARIS

*DATE: NOVEMBER 2023


***Set the working directory
cd "C:\Users\Nita\OneDrive\Desktop\PMH Datasets\STATA DATASETS"

***load the data
use "PMH CLEAN 11 NOV 2023_1.dta", clear


********************************************************************************
**************************WORKING VARIABLES*************************************


///////////////////////////Perceived Social Support Levels//////////////////////

*************FAMILY*************

local family  family_helps_n emortional_help_n talk_about_problems_n family_willing_to_help_n

egen Fam=rowtotal(family_helps_n emortional_help_n talk_about_problems_n family_willing_to_help_n)

gen Fam_sup=Fam/4

tab Fam_sup

recode Fam_sup (1/2.9=1 "Low Family Support") (3/5.09=2 "Moderate Family Support") (5.1/7=3 "High Family Support"),gen (FamilySupport_Levels)

tab FamilySupport_Levels

************FRIENDS**************

local friends friends_try_to_help_n count_on_friends_n friends_share_joys_n talk_about_problems_w_friends

egen Friends=rowtotal(friends_try_to_help_n count_on_friends_n friends_share_joys_n talk_about_problems_w_friends)

gen Friend_sup=Friends/4

tab Friend_sup

recode Friend_sup (1/2.9=1 "Low Friend Support") (3/5.09=2 "Moderate Friend Support") (5.1/7=3 "High Friend Support"),gen (FriendSupport_Levels)

tab FriendSupport_Levels

************SIGNIFICANT OTHER**************
local sig_other special_person_around_n special_person_share_joy_with special_person_source_of_help special_person_who_cares_n

egen sig_other=rowtotal(special_person_around_n special_person_share_joy_with special_person_source_of_help special_person_who_cares_n)

gen Spouse_sup=sig_other/4

tab Spouse_sup

recode Spouse_sup (1/2.9=1 "Low Spouse Support") (3/5.09=2 "Moderate Spouse Support") (5.1/7=3 "High Spouse Support"),gen (SpouseSupport_Levels)

tab SpouseSupport_Levels


*********************SOCIAL SUPPORT SCORE VARIABLE******************************

local myvars special_person_around_n special_person_share_joy_with family_helps_n emortional_help_n special_person_source_of_help friends_try_to_help_n count_on_friends_n talk_about_problems_n friends_share_joys_n special_person_who_cares_n family_willing_to_help_n talk_about_problems_w_friends

foreach var in `myvars'{
  gen s_`var'=0 if `var'==1 | `var'==2 | `var'==3| `var'==4
   replace s_`var'=1 if `var'==5 | `var'==6 | `var'==7
}

egen social_support=rowtotal(s_special_person_around_n - s_talk_about_problems_w_friends)

gen SocialSupport=social_support/12


recode social_support (6/max=1 "Yes") (min/5=0 "No"), gen(SocialSupport_Score)
label var SocialSupport_Score "Do you receive Social Support?" 

tab SocialSupport_Score


////////////////////////////////////////////////////////////////////////////////
//////////////////////OUTCOME VARIABLES/////////////////////////////////////////


************************************DEPRESSION**********************************


*******Information collected using PHQ-9 test

local Dep little_interest feeling_down trouble_sleeping tired poor_appetite feeling_bad_about_self trouble_concentrating speaking_slowly death_thoughts 

egen Depressed=rowtotal(little_interest feeling_down trouble_sleeping tired poor_appetite feeling_bad_about_self trouble_concentrating speaking_slowly death_thoughts)

/*
0 – 4	None-minimal	
5 – 9	Mild	
10 – 14	Moderate	
15 – 19	Moderately Severe
20 – 27	Severe
*/
recode Depressed (0/4=1 "None") (5/9=2 "Mild Depression") (10/14=3 "Moderate Depression") (15/19=4 "Moderately Severe Depression") (20/max=5 "Severe Depression"), gen(Depression_Score)
label var Depression_Score "Do you feel Depressed?" 

tab Depression_Score

**********************GENERALIZED ANXIETY DISORDER******************************

*******Information collected using GAD-7 Scale test

local anxiety  feeling_nervous_anxious uncontroled_worrying worrying_to_much_about_things trouble_relaxing2 restless easily_annoyed_irritable feeling_afraid_anout_something_a 

egen GAD= rowtotal(feeling_nervous_anxious uncontroled_worrying worrying_to_much_about_things trouble_relaxing2 restless easily_annoyed_irritable feeling_afraid_anout_something_a)

/*Score 0-4: Minimal Anxiety
Score 5-9: Mild Anxiety
Score 10-14: Moderate Anxiety
Score greater than 15: Severe Anxiety
*/

recode GAD (0/4=1 "Minimal Anxiety")(5/9=2 "Mild Anxiety")(10/14=3 "Moderate Anxiety")(15/max=4 "Severe Anxiety"), gen(GAD_Score)
label var GAD_Score "General anxiety disorder level"
	
tab GAD_Score

******************************PTSD**********************************************

*******Information collected using Havard Trauma Questionnaire test 

local Trauma hurtful_memories event_rehappening recurrent_nightmares feeling_detached lack_of_emortions feeling_jumpy difficulty_concentrating trouble_sleeping_j feeling_on_guard feeling_irritable traumatic_remind hurtful_parts less_interest feeling_of_no_future traumatic_feelings traumatic_event_reminder_shock less_skills having_difficulty feeling_exhausted body_pain lack_of_emortions_j poor_memory memory_loss difficulty_paying_attention split_into_two_people feeling_unable blaming_yourself felling_guilty without_Hope feeling_ashamed people_dont_understand felling_others_hostile no_one_to_rely feeling_betrayed feeling_humiliated lack_of_trust feeling_powerless thinking_why_me onlyone_suffered need_to_revenge

egen Trauma=rowtotal ( hurtful_memories event_rehappening recurrent_nightmares feeling_detached lack_of_emortions feeling_jumpy difficulty_concentrating trouble_sleeping_j feeling_on_guard feeling_irritable traumatic_remind hurtful_parts less_interest feeling_of_no_future traumatic_feelings traumatic_event_reminder_shock less_skills having_difficulty feeling_exhausted body_pain lack_of_emortions_j poor_memory memory_loss difficulty_paying_attention split_into_two_people feeling_unable blaming_yourself felling_guilty without_Hope feeling_ashamed people_dont_understand felling_others_hostile no_one_to_rely feeling_betrayed feeling_humiliated lack_of_trust feeling_powerless thinking_why_me onlyone_suffered need_to_revenge)


gen Trauma_score=Trauma/40
tab Trauma_score

gen PTSD=0 if Trauma_score>=2.5
replace PTSD=1 if Trauma_score < 2.5


label variable PTSD PTSD
label define PTSD 0 "Postive" 1 "Negative"
label values PTSD PTSD 

tab PTSD

********************************************************************************

save PMH CLEAN 11 NOV 2023_2.dta

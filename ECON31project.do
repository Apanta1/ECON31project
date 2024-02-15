clear
set more off
capture {
cd "/Users/apanta1/Documents/ECON 31/FINAL PROJECT"
log close
} 

log using PS_3.log, replace

// Load data
import delimited "/Users/apanta1/Documents/ECON 31/FINAL PROJECT/Projectdata.csv", clear


rename onascalefrom15towhatextenthasthe career_score
rename onascalefrom15howwouldyoudescrib personality_score
rename onascalefrom15howmuchdoyourfamil family_score
rename areuaninternationalstudent international
rename currentmajorprimarymajor major
rename howmanytimeshaveyouchangedyourma major_change

gen international_num = 1
replace international_num = 0 if international == "No"

gen male_num = 0
replace male_num = 1 if gender == "Male"

gen female_num = 0
replace female_num = 1 if gender == "Female"

gen non_binary_num = 1
replace non_binary_num = 0 if gender == "Male"
replace non_binary_num = 0 if gender == "Male"

ttest career_score, by (international_num)
/* fail to reject the null hypothesis here as both
groups (domestic and international) are no different when it
comes to career concerns */

ttest family_score, by (international_num)
/* fail to reject the null hypothesis here as both
groups (domestic and international) are no different when it
comes to family's influence in major*/


 ttest personality_score, by (international_num)
 /* fail to reject the null hypothesis here as both
groups (domestic and international) are no different when it
comes to personality*/


ttest career_score, by (female_num)
/* fail to reject the null hypothesis here as both
groups (female and non_female) are no different when it
comes to career concerns */

ttest family_score, by (female_num)
/* fail to reject the null hypothesis here as both
groups (female and non_female) are no different when it
comes to family's influence in major */

ttest personality_score, by (female_num)
/* fail to reject the null hypothesis here as both
groups (female and non_female) are no different when it
comes to personality */


/*testing if career_score, personality_score and family_score
are different for seniors*/
gen senior = 0
replace senior = 1 if classyear == 2024

ttest career_score, by (senior)
ttest family_score, by (senior)
ttest personality_score, by (senior)

//fail to reject all three null hypothesis

/*testing if career_score, personality_score and family_score
are different for first_year*/
gen first_year = 0
replace first_year = 1 if classyear == 2027

ttest career_score, by (first_year)
ttest family_score, by (first_year)
ttest personality_score, by (first_year)

//fail to reject all three null hypothesis


/*testing if career_score, personality_score and family_score
are different for natural_science majors*/
gen natural_science = 0
replace natural_science = 1 if division == "NSE"

ttest career_score, by (natural_science)
ttest family_score, by (natural_science)

// fail to reject above two hypothesis

ttest personality_score, by (natural_science)
// we can successfully reject the hypothesis
//successsss


/*testing if career_score and family_score
are different for introvert*/
gen introvert  = 0
replace introvert = 1 if personality_score < 3

ttest career_score, by (introvert)
ttest family_score, by (introvert)
// fail to reject both tests

/*testing if career_score and family_score
are different for extrovert*/
gen extrovert  = 0
replace extrovert = 1 if personality_score > 3

ttest career_score, by (extrovert)
ttest family_score, by (extrovert)
// fail to reject both tests

gen very_introvert  = 0
replace very_introvert = 1 if personality_score == 1

ttest career_score, by (very_introvert)
/*successss
means significant difference in career scores of
very introvert and non very introvert*/

ttest family_score, by (very_introvert)
// fail to reject tests

// generating a varaible for upper classyear students who
// have not changed their major
gen uppclass_change = 0
replace uppclass_change = 1 if (classyear < 2027 & major_change != "0")

ttest career_score, by (uppclass_change)
ttest family_score, by (uppclass_change)
ttest personality_score, by (uppclass_change)
//all tests failed


ttest natural_science, by (international_num)
//above test failed


/*testing if career_score, personality_score and family_score
are different for humanities majors*/
gen humanities = 0
replace humanities = 1 if division == "HU"

ttest career_score, by (humanities)
ttest family_score, by (humanities)
ttest personality_score, by (humanities)


//all tests failed

/*testing if career_score, personality_score and family_score
are different for social_science majors*/
gen social_science = 0
replace social_science = 1 if division == "SS"

ttest career_score, by(social_science)
ttest family_score, by(social_science)

////////////////////////////////////
ttest personality_score, by(social_science)
// we can successfully reject the null hypothesis here


ttest social_science, by(very_introvert)
ttest social_science, by(female_num)

ttest natural_science, by(female_num)

ttest natural_science, by(international_num)

gen high_career_inf = 0
replace high_career_inf =1 if career_score > 3

ttest social_science, by(high_career_inf)
ttest natural_science, by(high_career_inf)

gen low_career_inf = 0
replace low_career_inf =1 if career_score < 3

ttest social_science, by(low_career_inf)
ttest natural_science, by(low_career_inf)

gen high_family_inf = 0
replace high_family_inf =1 if family_score > 2
ttest social_science, by(high_family_inf)
ttest natural_science, by(high_family_inf)


regress personality_score natural_science social_science humanities
// the varaibles are not statistically significant


gen high_mjr_change = 0
replace high_mjr_change = 1 if (major_change != "0" & major_change != "1")


ttest career_score, by (high_mjr_change)
ttest family_score, by (high_mjr_change)
ttest personality_score, by (high_mjr_change)
ttest natural_science, by(high_mjr_change)
ttest social_science, by(high_mjr_change)
ttest female_num, by(high_mjr_change)
















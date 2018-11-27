
var/list/first_names_male = file2list("config/names/first_male.txt")
var/list/first_names_female = file2list("config/names/first_female.txt")
var/list/last_names = file2list("config/names/last.txt")

var/list/first_names_male_pirate = file2list("config/names/first_male_pirate.txt")
var/list/first_names_female_pirate = file2list("config/names/first_female_pirate.txt")
var/list/last_names_pirate = file2list("config/names/last_pirate.txt")

var/list/first_names_male_english = file2list("config/names/first_male_english.txt")
var/list/first_names_female_english = file2list("config/names/first_female_english.txt")
var/list/last_names_english = file2list("config/names/last_english.txt")

var/list/first_names_male_french = file2list("config/names/first_male_french.txt")
var/list/first_names_female_french = file2list("config/names/first_female_french.txt")
var/list/last_names_french = file2list("config/names/last_french.txt")

var/list/first_names_male_portuguese = file2list("config/names/first_male_portuguese.txt")
var/list/first_names_female_portuguese = file2list("config/names/first_female_portuguese.txt")
var/list/last_names_portuguese = file2list("config/names/last_portuguese.txt")

var/list/first_names_male_spanish = file2list("config/names/first_male_spanish.txt")
var/list/first_names_female_spanish = file2list("config/names/first_female_spanish.txt")
var/list/last_names_spanish = file2list("config/names/last_spanish.txt")

var/list/first_names_male_dutch = file2list("config/names/first_male_dutch.txt")
var/list/first_names_female_dutch = file2list("config/names/first_female_dutch.txt")
var/list/last_names_dutch = file2list("config/names/last_dutch.txt")

var/list/first_names_male_carib = file2list("config/names/first_carib.txt")
var/list/first_names_female_carib = file2list("config/names/first_carib.txt")
var/list/last_names_carib = file2list("config/names/last_carib.txt")

var/list/verbs = file2list("config/names/verbs.txt")
var/list/adjectives = file2list("config/names/adjectives.txt")

var/list/first_names_male_greek = file2list("config/names/first_male_greek.txt")		//Add greek names to names vars

var/list/first_names_male_arab = file2list("config/names/first_male_arab.txt")		//Add greek names to names vars


var/list/first_names_male_roman = file2list("config/names/first_male_roman.txt")
var/list/middle_names_roman = file2list("config/names/middle_roman.txt")                 //Add roman names to names vars
var/list/last_names_roman = file2list("config/names/last_roman.txt")
/* NOT USED FOR NOW!
var/list/country_names = file2list("config/names/countries.txt")
var/civname_a = pick(country_names)
var/civname_b = pick(country_names-civname_a)
var/civname_c = pick(country_names-civname_a-civname_b)
var/civname_d = pick(country_names-civname_a-civname_b-civname_c)
var/civname_e = pick(country_names-civname_a-civname_b-civname_c-civname_d)
var/civname_f = pick(country_names-civname_a-civname_b-civname_c-civname_d-civname_e)
var/list/civnames = list(civname_a,civname_b,civname_c,civname_d,civname_e,civname_f)
*/
var/civname_a = "Redland" //red
var/civname_b = "Greenville" //green
var/civname_c = "Blueport" //blue
var/civname_d = "Yellowdale" //yellow
var/civname_e = "Whitetown" //white
var/civname_f = "Blackrock" //black

//loaded on startup because of "
//would include in rsc if ' was used

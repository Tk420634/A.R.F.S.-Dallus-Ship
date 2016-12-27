//This is a department
var/const/ENGSEC			=(1<<0)
//This is the jobs within said department, add a number to the last ones 1<<# to add another job.
var/const/CAPTAIN			=(1<<0)
var/const/LIEUTENANT		=(1<<1)
var/const/HOS				=(1<<2)
var/const/WARDEN			=(1<<3)
var/const/DETECTIVE			=(1<<4)
var/const/OFFICER			=(1<<5)
var/const/CHIEF				=(1<<6)
var/const/ENGINEER			=(1<<7)
var/const/ATMOSTECH			=(1<<8)
var/const/ROBOTICIST		=(1<<9)
var/const/AI				=(1<<10)
var/const/CYBORG			=(1<<11)
var/const/SECSEC			=(1<<12)
var/const/SECTRAIN			=(1<<13)
var/const/JUNTECH			=(1<<14)
var/const/XENOBIO			=(1<<15)

var/const/MEDSCI			=(1<<1)

var/const/RD				=(1<<0)
var/const/SCIENTIST			=(1<<1)
var/const/CHEMIST			=(1<<2)
var/const/CMO				=(1<<3)
var/const/DOCTOR			=(1<<4)
var/const/GENETICIST		=(1<<5)
var/const/VIROLOGIST		=(1<<6)
var/const/NURSE				=(1<<7)
var/const/LABASS			=(1<<8)

var/const/CIVILIAN			=(1<<2)

//var/const/HOP				=(1<<0)
var/const/BARTENDER			=(1<<0)
var/const/BOTANIST			=(1<<1)
var/const/COOK				=(1<<2)
var/const/JANITOR			=(1<<3)
var/const/LIBRARIAN			=(1<<4)
//var/const/QUARTERMASTER	=(1<<6)
var/const/COP				=(1<<5)
var/const/CARGOTECH			=(1<<6)
var/const/MINER				=(1<<7)
var/const/LAWYER			=(1<<8)
var/const/CHAPLAIN			=(1<<9)
var/const/CLOWN				=(1<<10)
var/const/MIME				=(1<<11)
var/const/ASSISTANT			=(1<<12)
var/const/BRIDGE_OFFICER	=(1<<13)
var/const/PASSENGER			=(1<<14)
var/const/DEFAT				=(1<<15)

//ENTERTAINERS Clowns, mimes, etc
var/const/ENTERTAINER =(1<<2)

var/list/assistant_occupations = list(
	"Assistant",
	"Atmospheric Technician",
	"Cargo Technician",
	"Chaplain",
	"Lawyer",
	"Librarian",
	"Security Secretary",
)


var/list/command_positions = list(
	"Captain",
	//"Head of Personnel",
	"Lieutenant",
	"Head of Security",
	"Chief Engineer",
	"Research Director",
	"Chief Medical Officer",
	"Chief of Personnel",
)


var/list/engineering_positions = list(
	"Chief Engineer",
	"Station Engineer",
	"Atmospheric Technician",
	"Junior Technician",
)


var/list/medical_positions = list(
	"Chief Medical Officer",
	"Medical Doctor",
	"Geneticist",
	"Virologist",
	"Chemist",
)


var/list/science_positions = list(
	"Research Director",
	"Scientist",
	"Roboticist",
	"Xenobiologist",
	"Laboratory Assistant",
)


var/list/supply_positions = list(
	//"Head of Personnel",
	//"Quartermaster",
	"Cargo Technician",
	"Shaft Miner",
)


var/list/civilian_positions = list(
	"Chief of Personnel",
	"Bartender",
	"Botanist",
	"Cook",
	"Janitor",
	"Librarian",
	"Lawyer",
	"Chaplain",
	"Assistant",
	"Bridge Officer",
	"Passenger",
	"Defense Attorney",
	"Clown",
	"Mime",
	//"Prisoner",
)

var/list/entertainers = list(
	"Clown",
	"Mime",
)

var/list/security_positions = list(
	"Head of Security",
	"Warden",
	"Detective",
	"Security Officer",
	"Security Trainee",
)


var/list/nonhuman_positions = list(
	"AI",
	"Cyborg",
	"pAI",
)


/proc/guest_jobbans(job)
	return ((job in command_positions) || (job in nonhuman_positions) || (job in security_positions) || (job in entertainers))



//this is necessary because antags happen before job datums are handed out, but NOT before they come into existence
//so I can't simply use job datum.department_head straight from the mind datum, laaaaame.
/proc/get_department_heads(var/job_title)
	if(!job_title)
		return list()

	for(var/datum/job/J in SSjob.occupations)
		if(J.title == job_title)
			return J.department_head //this is a list

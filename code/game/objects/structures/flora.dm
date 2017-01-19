/obj/structure/flora
	burn_state = 0 //Burnable
	burntime = 30

//trees
/obj/structure/flora/tree
	name = "tree"
	anchored = 1
	density = 1
	pixel_x = -16
	layer = 9

/obj/structure/flora/tree/pine
	name = "pine tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_1"

/obj/structure/flora/tree/pine/New()
	icon_state = "pine_[rand(1, 3)]"
	..()

/obj/structure/flora/tree/pine/xmas
	name = "xmas tree"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "pine_c"

/obj/structure/flora/tree/pine/xmas/New()
	..()
	icon_state = "pine_c"

/obj/structure/flora/tree/dead
	icon = 'icons/obj/flora/deadtrees.dmi'
	icon_state = "tree_1"

/obj/structure/flora/tree/festivus
	name = "festivus pole"
	icon = 'icons/obj/flora/pinetrees.dmi'
	icon_state = "festivus_pole"
	desc = "During last year's Feats of Strength the Research Director was able to suplex this passing immobile rod into a planter."

/obj/structure/flora/tree/dead/New()
	icon_state = "tree_[rand(1, 6)]"
	..()


//grass
/obj/structure/flora/grass
	name = "grass"
	icon = 'icons/obj/flora/snowflora.dmi'
	anchored = 1
	gender = PLURAL	//"this is grass" not "this is a grass"

/obj/structure/flora/grass/brown
	icon_state = "snowgrass1bb"

/obj/structure/flora/grass/brown/New()
	icon_state = "snowgrass[rand(1, 3)]bb"
	..()


/obj/structure/flora/grass/green
	icon_state = "snowgrass1gb"

/obj/structure/flora/grass/green/New()
	icon_state = "snowgrass[rand(1, 3)]gb"
	..()

/obj/structure/flora/grass/both
	icon_state = "snowgrassall1"

/obj/structure/flora/grass/both/New()
	icon_state = "snowgrassall[rand(1, 3)]"
	..()

/obj/structure/flora/grass/fallleaves
	icon_state = "fallleaves"


//bushes
/obj/structure/flora/bush
	name = "bush"
	icon = 'icons/obj/flora/snowflora.dmi'
	icon_state = "snowbush1"
	anchored = 1

/obj/structure/flora/bush/New()
	icon_state = "snowbush[rand(1, 6)]"
	..()

//newbushes

/obj/structure/flora/ausbushes
	name = "bush"
	icon = 'icons/obj/flora/ausflora.dmi'
	icon_state = "firstbush_1"
	anchored = 1

/obj/structure/flora/ausbushes/New()
	if(icon_state == "firstbush_1")
		icon_state = "firstbush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/reedbush
	icon_state = "reedbush_1"

/obj/structure/flora/ausbushes/reedbush/New()
	icon_state = "reedbush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/leafybush
	icon_state = "leafybush_1"

/obj/structure/flora/ausbushes/leafybush/New()
	icon_state = "leafybush_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/palebush
	icon_state = "palebush_1"

/obj/structure/flora/ausbushes/palebush/New()
	icon_state = "palebush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/stalkybush
	icon_state = "stalkybush_1"

/obj/structure/flora/ausbushes/stalkybush/New()
	icon_state = "stalkybush_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/grassybush
	icon_state = "grassybush_1"

/obj/structure/flora/ausbushes/grassybush/New()
	icon_state = "grassybush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/fernybush
	icon_state = "fernybush_1"

/obj/structure/flora/ausbushes/fernybush/New()
	icon_state = "fernybush_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/sunnybush
	icon_state = "sunnybush_1"

/obj/structure/flora/ausbushes/sunnybush/New()
	icon_state = "sunnybush_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/genericbush
	icon_state = "genericbush_1"

/obj/structure/flora/ausbushes/genericbush/New()
	icon_state = "genericbush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/pointybush
	icon_state = "pointybush_1"

/obj/structure/flora/ausbushes/pointybush/New()
	icon_state = "pointybush_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/lavendergrass
	icon_state = "lavendergrass_1"

/obj/structure/flora/ausbushes/lavendergrass/New()
	icon_state = "lavendergrass_[rand(1, 4)]"
	..()

/obj/structure/flora/ausbushes/ywflowers
	icon_state = "ywflowers_1"

/obj/structure/flora/ausbushes/ywflowers/New()
	icon_state = "ywflowers_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/brflowers
	icon_state = "brflowers_1"

/obj/structure/flora/ausbushes/brflowers/New()
	icon_state = "brflowers_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/ppflowers
	icon_state = "ppflowers_1"

/obj/structure/flora/ausbushes/ppflowers/New()
	icon_state = "ppflowers_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/sparsegrass
	icon_state = "sparsegrass_1"

/obj/structure/flora/ausbushes/sparsegrass/New()
	icon_state = "sparsegrass_[rand(1, 3)]"
	..()

/obj/structure/flora/ausbushes/fullgrass
	icon_state = "fullgrass_1"

/obj/structure/flora/ausbushes/fullgrass/New()
	icon_state = "fullgrass_[rand(1, 3)]"
	..()

/obj/structure/flora/kirbyplants
	name = "potted plant"
	icon = 'icons/obj/flora/plants.dmi'
	icon_state = "plant-01"

/obj/structure/flora/kirbyplants/dead
	name = "RD's potted plant"
	desc = "A gift from the botanical staff, presented after the RD's reassignment. There's a tag on it that says \"Y'all come back now, y'hear?\"\nIt doesn't look very healthy..."
	icon_state = "plant-25"

/obj/structure/flora/kirbyplants/applebush
	name = "An Apple Bush"
	desc = "Thats a plant."
	icon_state = "applebush"

/obj/structure/flora/kirbyplants/plant1
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-01"

/obj/structure/flora/kirbyplants/plant2
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-02"

/obj/structure/flora/kirbyplants/plant3
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-03"

/obj/structure/flora/kirbyplants/plant4
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-04"

/obj/structure/flora/kirbyplants/plant5
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-05"

/obj/structure/flora/kirbyplants/plant6
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-06"

/obj/structure/flora/kirbyplants/plant7
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-07"

/obj/structure/flora/kirbyplants/plant8
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-08"

/obj/structure/flora/kirbyplants/plant9
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-09"

/obj/structure/flora/kirbyplants/plant10
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-10"

/obj/structure/flora/kirbyplants/plant11
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-11"

/obj/structure/flora/kirbyplants/plant12
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-12"

/obj/structure/flora/kirbyplants/plant13
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-13"

/obj/structure/flora/kirbyplants/plant14
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-14"

/obj/structure/flora/kirbyplants/plant15
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-15"

/obj/structure/flora/kirbyplants/plant16
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-16"

/obj/structure/flora/kirbyplants/plant17
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-17"

/obj/structure/flora/kirbyplants/plant18
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-18"

/obj/structure/flora/kirbyplants/plant19
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-19"

/obj/structure/flora/kirbyplants/plant20
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-20"

/obj/structure/flora/kirbyplants/plant21
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-21"

/obj/structure/flora/kirbyplants/plant22
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-22"

/obj/structure/flora/kirbyplants/plant23
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-23"

/obj/structure/flora/kirbyplants/plant24
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-24"

/obj/structure/flora/kirbyplants/plant25
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-25"

/obj/structure/flora/kirbyplants/plant26
	name = "An eyeball plant"
	desc = "Thats a plant. It has what looks like an eye. OH GOD ITS LOOKING AT ME!"
	icon_state = "plant-26"

/obj/structure/flora/kirbyplants/plant27
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-27"

/obj/structure/flora/kirbyplants/plant28
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-28"

/obj/structure/flora/kirbyplants/plant29
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-29"

/obj/structure/flora/kirbyplants/plant30
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-30"

/obj/structure/flora/kirbyplants/plant31
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-31"

/obj/structure/flora/kirbyplants/plant32
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-32"

/obj/structure/flora/kirbyplants/plant33
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-33"

/obj/structure/flora/kirbyplants/plant34
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-34"

/obj/structure/flora/kirbyplants/plant35
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-35"

/obj/structure/flora/kirbyplants/plant36
	name = "A plant"
	desc = "Thats a plant."
	icon_state = "plant-36"

/obj/structure/flora/kirbyplants/deadplant
	name = "A dead plant"
	desc = "Thats a plant. Its dead."
	icon_state = "plant-dead"

/obj/structure/flora/kirbyplants/cornstalk1
	name = "A cornstalk"
	desc = "corny"
	icon_state = "cornstalk1"

/obj/structure/flora/kirbyplants/cornstalk2
	name = "A cornstalk"
	desc = "corny"
	icon_state = "cornstalk2"

/obj/structure/flora/kirbyplants/cornstalk3
	name = "A cornstalk"
	desc = "corny"
	icon_state = "cornstalk3"

/obj/structure/flora/kirbyplants/scatteredstraw
	name = "straw"
	desc = "straw scattered on the ground"
	icon_state = "strawscattered"

/obj/structure/flora/kirbyplants/scatteredstraw2
	name = "straw"
	desc = "straw scattered on the ground"
	icon_state = "strawscattered2"

/obj/structure/flora/kirbyplants/scatteredstraw3
	name = "straw"
	desc = "straw scattered on the ground"
	icon_state = "strawscattered3"

/obj/structure/flora/kirbyplants/scatteredstrawedge
	name = "straw"
	desc = "straw scattered on the ground"
	icon_state = "strawscatterededge"

/obj/structure/flora/kirbyplants/stump1
	name = "A Stump"
	desc = "Its very stump like in both form and function"
	icon_state = "stump1"

/obj/structure/flora/kirbyplants/stump2
	name = "A Stump"
	desc = "Its very stump like in both form and function"
	icon_state = "stump2"

/obj/structure/flora/kirbyplants/strawbail1
	name = "straw bale"
	desc = "A bale of straw"
	icon_state = "strawbale1"

/obj/structure/flora/kirbyplants/strawbail2
	name = "straw bale"
	desc = "two bales of straw"
	icon_state = "strawbale2"

/obj/structure/flora/kirbyplants/strawbail3
	name = "straw bale"
	desc = "three bales of straw"
	icon_state = "strawbale3"

/obj/structure/flora/kirbyplants/gravestone
	name = "A gravestone"
	desc = "A chipped granite tombstone."
	icon_state = "gravestone"

//a rock is flora according to where the icon file is
//and now these defines
/obj/structure/flora/rock
	name = "rock"
	desc = "a rock"
	icon_state = "rock1"
	icon = 'icons/obj/flora/rocks.dmi'
	anchored = 1
	burn_state = -1 //Not Burnable

/obj/structure/flora/rock/New()
	..()
	icon_state = "rock[rand(1,5)]"

/obj/structure/flora/rock/pile
	name = "rocks"
	desc = "some rocks"
	icon_state = "rockpile1"

/obj/structure/flora/rock/pile/New()
	..()
	icon_state = "rockpile[rand(1,5)]"
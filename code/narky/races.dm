datum
	species
		//specflags = list(EYECOLOR,HAIR,FACEHAIR,LIPS)
		var/generic="something"
		var/adjective="unknown"
		var/restricted=0 //Set to 1 to not allow anyone to choose it, 2 to hide it from the DNA scanner, and text to restrict it to one person
		var/tail=0
		var/taur=0
		var/baseicon = 'icons/mob/races/human.dmi'
		human
			generic="human"
			adjective="ordinary"
			taur="horse"
			baseicon = 'icons/mob/races/human.dmi'
		abductor
			//name="abductor"
			id="abductor"
			generic="abductor"
			adjective="spooky"
			restricted=2
			baseicon = 'icons/mob/races/abductor.dmi'
		absol
			name="absol"
			say_mod = "growls"
			id="absol"
			generic="spooky"
			adjective="doom"
			attack_verb = "headbutt"
			attack_sound = 'sound/effects/bang.ogg'
			restricted = "Chokin and Tokin"
			tail=1
			baseicon = 'icons/mob/races/absol.dmi'
		ailurus
			name="red panda"
			id="ailurus"
			say_mod = "chitters"
			generic="ailurus"
			adjective="cuddly"
			tail=1
			baseicon = 'icons/mob/races/ailurus.dmi'
		alien
			name="alien"
			id="alien"
			say_mod="hisses"
			generic="xeno"
			adjective="phallic"
			tail=1
			baseicon = 'icons/mob/races/alien.dmi'
		/* armadillo
			name="armadillo"
			id="armadillo"
			say_mod = "drawls"
			generic = "cingulate" // Superorder Xenarthra, Order Cingulata
			adjective = "protected"
			tail=1
			attack_verb = "noms"
			attack_sound = 'sound/weapons/bite.ogg' */
			attack_verb = "nom" // apparently attack verbs are just the verb, no S. shrug
			attack_sound = 'sound/weapons/bite.ogg'
		anubis
			name="anubis"
			id="anubis"
			say_mod = "intones"
			generic="jackal" // mmm...jackal or canine? i'll leave it for now
			adjective="cold"
			attack_verb = "claw"
			baseicon = 'icons/mob/races/anubis.dmi'
		avali
			name="avali"
			id="avali"
			generic="feathery rat thing"
			adjective="weird"
			tail=1
			say_mod = "squaks"
			baseicon = 'icons/mob/races/avali.dmi'
			attack_verb = "scratch"
		bat
			name="bat"
			id="bat"
			generic="black as the night"
			adjective="squeaky"
			tail=1
			say_mod = "sonars"
			baseicon = 'icons/mob/races/bat.dmi'
		bee
			name="bee"
			id="bee"
			say_mod = "buzzes"
			generic="insect"
			adjective="stingy"
			eyes="motheyes"
			baseicon = 'icons/mob/races/bee.dmi'
		beaver
			name="beaver"
			id="beaver"
			say_mod = "chitters"
			generic="rodent"
			adjective="damnable"
			tail=1
			attack_verb = "tailslap"
			attack_sound = 'sound/items/dodgeball.ogg'
			baseicon = 'icons/mob/races/beaver.dmi'

		beholder
			name="beholder"
			id="beholder"
			say_mod = "jibbers"
			generic="body part"
			adjective="all-seeing"
			tail=0
			attack_verb = "visually assault"
			attack_sound = 'sound/magic/MM_Hit.ogg' // MAGIC MISSILE! MAGIC MISSILE!
			baseicon = 'icons/mob/races/beholder.dmi'
		boar
			name="boar"
			id="boar"
			say_mod = "grunts"
			generic="pig"
			adjective="wild and curly"
			tail=1
			baseicon = 'icons/mob/races/boar.dmi'
		capra
			name="caprine"
			id="capra"
			generic="goat"
			adjective="irritable"
			say_mod = "bleats"
			baseicon = 'icons/mob/races/capra.dmi'

		carno
			name="carno"
			id="carno"
			generic="red dino"
			adjective="irritable"
			say_mod = "roar"
			attack_verb = "bites"
			tail = 1
			attack_sound = 'sound/weapons/bite.ogg'
			baseicon = 'icons/mob/races/carno.dmi'
		carp
			name="carp"
			id="carp"
			say_mod = "glubs"
			generic = "abomination"
			adjective = "violently fishy"
			tail=1
			eyes = "carpeyes"
			attack_verb = "nom"
			attack_sound = 'sound/weapons/bite.ogg'
			baseicon = 'icons/mob/races/carp.dmi'

		ceratotaur
			name="ceratotaur"
			id="ceratotaur"
			generic="yellow bannana dino"
			adjective="angry"
			say_mod = "roars"
			attack_verb = "bite"
			attack_sound = 'sound/weapons/bite.ogg'
			tail=1
			baseicon = 'icons/mob/races/ceratotaur.dmi'

		chicken
			name="chicken"
			id="chicken"
			say_mod = "clucks"
			generic="bird"
			adjective="coward"
			tail=1
			attack_verb = "whack"
			baseicon = 'icons/mob/races/chicken.dmi'
		corgi
			name="corgi"
			id="corgi"
			say_mod ="yaps"
			generic="canine"
			adjective="corgalicious"
			tail=1
			baseicon = 'icons/mob/races/corgi.dmi'
		corvid
			name="corvid"
			id="corvid"
			say_mod = "caws"
			generic="bird"
			adjective="mask-piercing"
			tail=1
			attack_verb = "whack"
			baseicon = 'icons/mob/races/corvid.dmi'
		cow
			name="cow"
			id="cow"
			say_mod = "moos"
			generic="bovine"
			adjective="wise"
			tail=1
			taur=1
			baseicon = 'icons/mob/races/cow.dmi'
		coyote
			name="coyote"
			id="coyote"
			say_mod = "yips"
			generic="canine"
			adjective="mangy"
			tail=1
			baseicon = 'icons/mob/races/coyote.dmi'
		crocodile
			name="crocodile"
			say_mod = "growls"
			id="croc"
			generic="water reptile"
			adjective="scaled"
			tail=1
			baseicon = 'icons/mob/races/crocodile.dmi'
		dalmatian
			name="dalmatian"
			id="dalmatian"
			say_mod = "ruffs"
			generic="canine"
			adjective="spotty"
			tail=1
			baseicon = 'icons/mob/races/dalmatian.dmi'
		datashark
			name="datashark"
			id="datashark"
			generic="data"
			adjective="virus-y"
			attack_verb = "bite"
			attack_sound = 'sound/weapons/bite.ogg'
			restricted = "Ruby Flamewing"
			tail=1
			baseicon = 'icons/mob/races/datashark.dmi'
		deer
			name="deer"
			id="deer"
			say_mod = "grunts"
			generic = "cervid"
			adjective = "skittish"
			tail=1 // that's better
			attack_verb = "gore"
			attack_sound = 'sound/weapons/bladeslice.ogg'
			baseicon = 'icons/mob/races/deer.dmi'
		drake
			name="drake"
			id="drake"
			say_mod = "growls"
			generic = "reptile"
			adjective = "frilly"
			tail=1 // i'd use lizard tails but drakes have frills included on the icons
			taur=1
			baseicon = 'icons/mob/races/drake.dmi'
		drider
			name="drider"
			id="drider"
			say_mod = "chitters"
			generic="humanoid"
			adjective="big and hairy"
			taur=1
			tail=1
			eyes="spidereyes"
			baseicon = 'icons/mob/races/drider.dmi'
		eevee
			name="eevee"
			say_mod = "yaps"
			id="eevee"
			generic="fluffy"
			adjective="fluffy"
			attack_verb = "tailwhip"
			restricted = "ThingPony"
			tail=1
			baseicon = 'icons/mob/races/eevee.dmi'
		elephant
			name="elephant"
			say_mod = "trumpets"
			id="elephant"
			generic="fat"
			adjective="big"
			attack_verb = "trunk slap"
			tail=1
			baseicon = 'icons/mob/races/elephant.dmi'
		flareon
			name="flareon"
			say_mod = "roars"
			id="flareon"
			generic="burny"
			adjective="burny"
			attack_verb = "tackle"
			tail=1
			baseicon = 'icons/mob/races/flareon.dmi'
		fennec
			name="fennec"
			say_mod = "yips"
			id="fennec"
			generic="vulpine"
			adjective="foxy"
			tail=1
			baseicon = 'icons/mob/races/fennec.dmi'
		fox
			name="fox"
			id="fox"
			say_mod = "geckers"
			generic="vulpine"
			adjective="foxy" // open and shut with this one, huh
			tail=1
			taur=1
			baseicon = 'icons/mob/races/fox.dmi'
		glaceons
			name="shiny glaceon"
			id="glaceons"
			generic="vulpine"
			adjective="glowing"
			attack_verb = "tackles"
			say_mod = "chimes"
			restricted = "Alex123890"
			tail=1
			baseicon = 'icons/mob/races/glaceons.dmi'
		glaceon
			name="glaceon"
			id="glaceon"
			generic="vulpine"
			adjective="glowing"
			attack_verb = "tackles"
			say_mod = "chimes"
			tail=1
			baseicon = 'icons/mob/races/glaceon.dmi'
		grovyle
			name="grovyle"
			id="grovyle"
			generic="poke-y"
			adjective="glowing"
			attack_verb = "slashes"
			say_mod = "growls"
			restricted = "KriegsmarineOffizier"
			tail=1
			baseicon = 'icons/mob/races/grovyle.dmi'
		glowfen
			name="glowfen"
			id="glowfen"
			generic="vulpine"
			adjective="glowing"
			tail=1
			baseicon = 'icons/mob/races/glowfen.dmi'

		gremlin
			name="gremlin"
			id="gremlin"
			generic="creature"
			tail=1
			attack_verb = "thwack"
			baseicon = 'icons/mob/races/gremlin.dmi'

		gria
			name="gria"
			id="gria"
			generic="reptile"
			adjective="scaled"
			tail=1
			attack_verb = "claw"
			attack_sound = 'sound/weapons/bladeslice.ogg'
			baseicon = 'icons/mob/races/gria.dmi'
		hawk
			name="hawk"
			id="hawk"
			say_mod = "chirps"
			generic="bird"
			adjective="feathery"
			tail=1
			attack_verb = "whack"
			baseicon = 'icons/mob/races/hawk.dmi'

		hippo
			name="hippo"
			id="hippo"
			say_mod = "grunts"
			generic="hippo"
			adjective="buoyant"
			tail=1
/*
		hummingbird
			name="hummingbird"
			id="hummingbird"
			generic="colourful avian"
			adjective="fluttery"
			tail=0
			say_mod = "hums"
			baseicon = 'icons/mob/races/hummingbird.dmi'
*/
		husky
			name="husky"
			id="husky"
			say_mod = "arfs"
			generic="canine"
			adjective="derpy"
			tail=1
			taur=1
			baseicon = 'icons/mob/races/husky.dmi'
		hyena
			name="hyena"
			id="hyena"
			say_mod = "giggles"
			generic="canine"
			adjective="funny"
			tail=1
			attack_verb = "chomp"
			attack_sound = 'sound/weapons/bite.ogg'
			baseicon = 'icons/mob/races/hyena.dmi'

		jackalope
			name="jackalope"
			id="jackalope"
			say_mod = "squeals"
			generic="leporid"
			adjective="hoppy and horny" //hue
			attack_verb = "kick"
			tail=1
			baseicon = 'icons/mob/races/jackalope.dmi'

		jelly
			name="jelly"
			id="jelly"
			generic="jelly"
			adjective="jelly"
			say_mod = "jiggles"
			baseicon = 'icons/mob/races/jelly.dmi'
		kangaroo
			name="kangaroo"
			id="kangaroo"
			generic="marsupial"
			say_mod = "grunts"
			adjective="bouncy"
			tail=1
			attack_verb = "kick"
			baseicon = 'icons/mob/races/kangaroo.dmi'
		kitsune
			name="kitsune"
			id="kitsune"
			say_mod = "singsongs"
			generic="vulpine"
			adjective="weaboo" // open and shut with this one, huh
			tail=1
			baseicon = 'icons/mob/races/kitsune.dmi'
		lab
			name="lab"
			id="lab"
			say_mod = "yaps"
			generic="canine"
			adjective="sleek"
			tail=1
			taur=1
			baseicon = 'icons/mob/races/lab.dmi'
		lugia
			name="lugia"
			id="lugia"
			say_mod = "chrips"
			generic="leg poke"
			attack_verb = "areoblast"
			adjective="fancy"
			tail=1
			baseicon = 'icons/mob/races/lugia.dmi'
		leporid
			name="leporid"
			id="leporid"
			say_mod = "squeals"
			generic="leporid"
			adjective="hoppy"
			tail=1
			attack_verb = "kick"
			baseicon = 'icons/mob/races/leporid.dmi'
		lizard
			name="lizard"
			id="lizard"
			say_mod = "hisses"
			generic="reptile"
			adjective="scaled"
			taur="naga"
			tail=1
			baseicon = 'icons/mob/races/lizard.dmi'
		murid // these are rodents like mice and rats, iska is dumb. c: ~Tk
			name="murid"
			id="murid"
			say_mod = "squeaks"
			generic="rodent"
			adjective="squeaky"
			tail=1
			baseicon = 'icons/mob/races/murid.dmi'
		ming
			name="ming"
			say_mod = "sultrily growls"
			id="ming"
			generic="vulpine"
			adjective="sultry"
			attack_verb = "claw"
			restricted = "Tk420634"
			tail=1
			baseicon = 'icons/mob/races/ming.dmi'
		moth
			name="moth"
			id="moth"
			say_mod = "kazoos"
			generic="insect"
			adjective="fluttery"
			eyes="motheyes" // this SHOULD work after i've updated human_face.dmi -- iska
			baseicon = 'icons/mob/races/moth.dmi'

		mushman
			name="mushroom"
			id="fung"
			generic="fungi"
			adjective="sporey"
			say_mod = "mushes"
			baseicon = 'icons/mob/races/fung.dmi'
			tail=0

		monkey
			name="monkey"
			id="monkey"
			generic="monkies"
			adjective="jungle furry"
			say_mod = "chimpers"
			tail=0
			baseicon = 'icons/mob/races/monkey.dmi'
		naga
			name="naga"
			id="naga"
			generic="humanoid"
			adjective="noodly"
			taur=1
			tail=1
			baseicon = 'icons/mob/races/naga.dmi'
		otter
			name="otter"
			id="otter"
			say_mod = "squeaks"
			generic="mustelid"
			adjective="slim"
			tail=1
			baseicon = 'icons/mob/races/otter.dmi'
		orca
			name="orca"
			id="orca"
			say_mod = "bubbles"
			generic="fat"
			adjective="not a whale"
			tail=1
			baseicon = 'icons/mob/races/orca.dmi'
		otusian
			name="otusian"
			id="otie"
			say_mod ="growls"
			generic="feline-canine"
			adjective="chunky" // ??? are otusians fat????
			tail=1
			taur=1
			baseicon = 'icons/mob/races/otie.dmi'
		panda
			name="panda"
			id="panda"
			say_mod = "murps"
			generic="fuzzy"
			adjective="blacknwhite"
			tail=1
			baseicon = 'icons/mob/races/panda.dmi'
		panther
			name="panther"
			id="panther"
			generic="feline"
			adjective="furry"
			tail=1
			taur=1
			attack_verb = "claw"
			attack_sound = 'sound/weapons/bladeslice.ogg'
			say_mod = "growls"
			baseicon = 'icons/mob/races/panther.dmi'
		pig
			name="pig"
			id="pig"
			generic="pig"
			adjective="curly"
			tail=1
			say_mod = "oinks"
			baseicon = 'icons/mob/races/pig.dmi'
		plant
			name="plant"
			id="pod"
			generic="plant"
			adjective="leafy"
			baseicon = 'icons/mob/races/pod.dmi'
		porcupine
			name="porcupine"
			id="porcupine"
			say_mod = "snuffles"
			generic = "rodent"
			adjective = "quilly"
			tail=1
			attack_verb = "quill-whack"
			attack_sound = 'sound/weapons/slash.ogg'
			baseicon = 'icons/mob/races/porcupine.dmi'
		possum
			name="possum"
			id="possum"
			say_mod = "chitters"
			generic = "marsupial"
			adjective = "rumaging"
			tail=1
			attack_verb = "nom"
			attack_sound = 'sound/weapons/bite.ogg'
			baseicon = 'icons/mob/races/possum.dmi'

		pug
			name="pug"
			id="pug"
			generic="Squashed Face"
			adjective="Adorable"
			say_mod = "borks"
			tail=0
			baseicon = 'icons/mob/races/pug.dmi'
		penguin
			name="penguin"
			id="penguin"
			generic="flightless bird"
			adjective="waddly"
			say_mod = "chirps"
			tail=0
			baseicon = 'icons/mob/races/penguin.dmi'
		raccoon
			name="raccoon"
			id="raccoon"
			say_mod="churrs"
			generic="procyonid" // Family Procyonidae
			adjective="stripy"
			tail=1
			baseicon = 'icons/mob/races/raccoon.dmi'
		renamon
			name="renamon"
			id="renamon"
			say_mod = "yips"
			generic = "digivulp"
			adjective = "digital"
			tail=1
			attack_verb = "claw"
			attack_sound = 'sound/weapons/slash.ogg'
			baseicon = 'icons/mob/races/renamon.dmi'
		robot
			name="robot"
			id="robot"
			say_mod = "beeps"
			generic = "metal"
			adjective = "creaky"
			tail=1
			attack_verb = "borg"
			attack_sound = "sound/weaons/robot_attack_noise.ogg"
			baseicon = 'icons/mob/races/robot.dmi'
		roorat
			name="kangaroo rat"
			id="roorat"
			generic="Heteromyidae" // ...marsupial rat?  Have you tried a google search?  They're a real thing.
			adjective="bouncy"
			tail=1
			attack_verb = "kick"
			say_mod = "squeak"
			baseicon = 'icons/mob/races/roorat.dmi'
/*
		runac //Working on this for Runac
			name="runac"
			id="runac"
			generic="vulpine"
			adjective="glowing"
			tail=1
			baseicon = 'icons/mob/races/runac.dmi'

		saltman
			name="salt"
			id="salt"
			generic="NaCl"
			adjective="salty"
			restricted=2
			say_mod = "bitches"
*/
		seaslug
			name="sea slug"
			id="seaslug"
			generic="slug"
			adjective="salty"
			tail=1
			attack_verb = "smack"
			say_mod = "cucumbers"
			baseicon = 'icons/mob/races/seaslug.dmi'

		sergal
			name="sergal"
			id="sergal"
			say_mod = "growls"
			generic="alienmonster"
			adjective="lewd"
			tail=1
			baseicon = 'icons/mob/races/sergal.dmi'
		shark
			name="shark"
			id="shark"
			generic="selachimorph" // Superorder Selachimorpha
			adjective="fishy"
			tail=1
			baseicon = 'icons/mob/races/shark.dmi'
		shepherd
			name="shepherd"
			id="shepherd"
			say_mod = "barks"
			generic="canine"
			adjective="happy"
			tail=1
			taur=1
			baseicon = 'icons/mob/races/shepherd.dmi'
		skunk
			name="skunk"
			id="skunk"
			say_mod = "snuffles"
			generic="mephit"
			adjective="stinky"
			tail=1
			taur=1
			baseicon = 'icons/mob/races/skunk.dmi'
		slime
			name="slime"
			id="slime"
			say_mod = "blurbles"
			generic="slime"
			adjective="slimy"
			baseicon = 'icons/mob/races/slime.dmi'
		smilodon
			name="smilodon"
			id="smilodon"
			say_mod = "growls"
			generic="smilodon"
			adjective="toothy"
			tail=1
			baseicon = 'icons/mob/races/smilodon.dmi'
		shihtzu
			name="shihtzu"
			id="shihtzu"
			say_mod = "barks"
			generic="fluffy"
			adjective="best pooch"
			tail=1
			baseicon = 'icons/mob/races/shihtzu.dmi'
		stitch
			name ="stitch"
			id = "stitch"
			say_mod = "barks"
			generic = "space alien"
			adjective = "Evil"
			tail =1
			attack_verb = "scratch"
			attack_sound = 'sound/weapons/slash.ogg'
			baseicon = 'icons/mob/races/stitch.dmi'

		snarby
			name="snarby"
			id="snarby"
			generic="beast"
			say_mod = "snarls"
			adjective="snippy and snarly"
			tail=1
			attack_verb = "chomp"
			attack_sound = 'sound/weapons/bite.ogg'
			eyes = "snarbyeyes"
			baseicon = 'icons/mob/races/snarby.dmi'

		stego
			name="stego"
			id="stego"
			say_mod = "grunts"
			generic="platey"
			adjective="dead dino"
			tail=1
			attack_verb = "tail spike"
			baseicon = 'icons/mob/races/stego.dmi'

		squirrel
			name="squirrel"
			id="squirrel"
			say_mod = "chitters"
			generic="rodent"
			adjective="nutty"
			tail=1
			baseicon = 'icons/mob/races/squirrel.dmi'
		tajaran
			name="tajaran"
			id="tajaran"
			generic="feline"
			say_mod = "growls"
			adjective="furry"
			tail=1
			taur=1
			attack_verb = "claw"
			attack_sound = 'sound/weapons/bladeslice.ogg'
			baseicon = 'icons/mob/races/tajaran.dmi'
		tiger
			name="tiger"
			id="tiger"
			generic="feline"
			say_mod = "growls"
			adjective="furry"
			tail=1
			attack_verb = "claw"
			attack_sound = 'sound/weapons/bladeslice.ogg'
			baseicon = 'icons/mob/races/tiger.dmi'
		turtle
			name="turtle"
			id="turtle"
			say_mod = "hisses"
			generic="reptile"
			adjective="hard-shelled"
			tail=1
			baseicon = 'icons/mob/races/turtle.dmi'
		ursine
			name="bear"
			id="ursine"
			generic="ursine"
			adjective="husky"
			say_mod = "grunts"
			tail=1
			attack_verb = "claw"
			attack_sound = 'sound/weapons/bladeslice.ogg'
			baseicon = 'icons/mob/races/ursine.dmi'
		vulture
			name="vulture"
			id="vulture"
			generic="evil"
			adjective="rotten"
			tail=1
			baseicon = 'icons/mob/races/vulture.dmi'
		wolf
			name="wolf"
			id="wolf"
			say_mod = "howls"
			generic="canine"
			adjective="shaggy"
			tail=1
			taur=1
			baseicon = 'icons/mob/races/wolf.dmi'
		zigzagoon
			name="zigzagoon"
			id="zigzagoon"
			say_mod = "zigs"
			generic="pokémon"
			adjective="curious"
			tail=1
			baseicon = 'icons/mob/races/zigzagoon.dmi'
		narky
			name="narwhal kitty"
			id="narky"
			say_mod="NYARS"
			generic="abomination"
			adjective="fucking awful snowflake"
			restricted=2
			tail=1
			taur=1
			attack_verb = "nipplewhack"
			baseicon = 'icons/mob/races/narky.dmi'


		fly
			//name="fly"
			generic="insect"
			adjective="buzzy"
			restricted=1
			baseicon = 'icons/mob/races/fly.dmi'

		skeleton
			//name="skeleton"
			generic="human"
			adjective="very boney"
			restricted=2
			attack_verb = "bone"
			baseicon = 'icons/mob/races/human.dmi'
		cosmetic_skeleton
			//name="skeleton"
			generic="skeleton"
			adjective="boney"
			restricted=2
			attack_verb = "bone"
			baseicon = 'icons/mob/races/human.dmi'
		shadow
			//name="shadow"
			generic="darkness"
			adjective="shady" // Jokes
			restricted=2
			baseicon = 'icons/mob/races/human.dmi'
		golem
			//name="golem"
			generic="golem"
			adjective="rocky"
			restricted=2
			baseicon = 'icons/mob/races/human.dmi'
		golem/adamantine
			//name="adamantine"
			generic="golem"
			adjective="rocky"
			restricted=2
			baseicon = 'icons/mob/races/human.dmi'
		zombie
			//name="zombie"
			id="zombie"
			generic="undead"
			adjective="rotten"
			restricted=2
			baseicon = 'icons/mob/races/human.dmi'
		cosmetic_zombie // considering renaming to zombie/cosmetic
			//name="zombie"
			id="zombie"
			generic="undead"
			adjective="particularly rotten"
			restricted=2
			baseicon = 'icons/mob/races/human.dmi'
		plasmaman
			//name="Plasmabone"
			id="plasmaman"
			generic="plasmaman"
			adjective="toxic"
			restricted=2 // don't comment these out if you don't want the world to burn
			baseicon = 'icons/mob/races/human.dmi'
		plasmaman/skin
			//name="Skinbone"
			id="plasmaman"
			generic="plasmaman"
			adjective="toxic"
			restricted=2 // but if you do want the world to burn then please, by all means
			baseicon = 'icons/mob/races/human.dmi'

	// I WANT DIS SPRITE SHEET SO I CAN ADD IT IN - Jonathan
	/*
		pepsiman
			//name="PEPSI MAAAAAN"
			id="PEPSIMAAAN"
			generic="beverage"
			adjective="refreshing"
			restricted=2 // don't want half the station to be running around with soda cans on their heads
	*/



		cutebold
			name="cutebold"
			id="cutebold"
			say_mod = "yips"
			generic = "kobo"
			adjective = "cute"
			tail=1
			attack_verb = "nom"
			attack_sound = 'sound/weapons/bite.ogg'
			baseicon = 'icons/mob/races/cutebold.dmi'
		pony // of the "my little" variety
			name="pony"
			id="pony"
			generic="equine"
			adjective="little"
			tail=1
			attack_verb= "kick"
			baseicon = 'icons/mob/races/pony.dmi'
		hylotl
			name="hylotl"
			id="hylotl"
			say_mod = "glubs"
			generic="amphibian"
			adjective="fishy"
			tail=0
			eyes="jelleyes"
			baseicon = 'icons/mob/races/hylotl.dmi'
/*var/list/kpcode_race_list

proc/kpcode_race_genlist()
	if(!kpcode_race_list)
		var/paths = typesof(/datum/species)
		kpcode_race_list = new/list()
		for(var/path in paths)
			var/datum/species/D = new path()
			if(D.name!="undefined")
				kpcode_race_list[D.name] = D*/

proc/kpcode_race_getlist(var/restrict=0)
	var/list/race_options = list()
	for(var/r_id in species_list)
		var/datum/species/R = kpcode_race_get(r_id)
		if(!R.restricted||R.restricted==restrict)
			race_options[r_id]=kpcode_race_get(r_id)
	return race_options

proc/kpcode_race_get(var/name="human")
	name=kpcode_race_san(name)
	if(!name||name=="") name="human"
	if(species_list[name])
		var/type_to_use=species_list[name]
		var/datum/species/return_this=new type_to_use()
		return return_this
	else
		return kpcode_race_get()

proc/kpcode_race_san(var/input)
	if(!input)input="human"
	if(istype(input,/datum/species))
		input=input:id
	return input

proc/kpcode_race_restricted(var/name="human")
	name=kpcode_race_san(name)
	if(kpcode_race_get(name))
		var/datum/species/D=kpcode_race_get(name)
		return D.restricted
	return 2

proc/kpcode_race_tail(var/name="human")
	name=kpcode_race_san(name)
	if(kpcode_race_get(name))
		var/datum/species/D=kpcode_race_get(name)
		return D.tail
	return 0

proc/kpcode_race_taur(var/name="human")
	name=kpcode_race_san(name)
	if(kpcode_race_get(name))
		var/datum/species/D=kpcode_race_get(name)
		if(D.taur==1)
			return D.id
		return D.taur
	return 0

proc/kpcode_race_generic(var/name="human")
	name=kpcode_race_san(name)
	if(kpcode_race_get(name))
		var/datum/species/D=kpcode_race_get(name)
		return D.generic
	return 0

proc/kpcode_race_adjective(var/name="human")
	name=kpcode_race_san(name)
	if(kpcode_race_get(name))
		var/datum/species/D=kpcode_race_get(name)
		return D.adjective
	return 0

proc/kpcode_get_generic(var/mob/living/M)
	if(istype(M,/mob/living/carbon/human))
		if(M:dna)
			return kpcode_race_generic(M:dna:mutantrace())
		else
			return kpcode_race_generic("human")
	if(istype(M,/mob/living/carbon/monkey))
		return "monkey"
	if(istype(M,/mob/living/carbon/alien))
		return "xeno"
	if(istype(M,/mob/living/simple_animal))
		return M.name
	return "something"

proc/kpcode_get_adjective(var/mob/living/M)
	if(istype(M,/mob/living/carbon/human))
		if(M:dna)
			return kpcode_race_adjective(M:dna:mutantrace())
		else
			return kpcode_race_adjective("human")
	if(istype(M,/mob/living/carbon/monkey))
		return "cranky"
	if(istype(M,/mob/living/carbon/alien))
		return "alien"
	if(istype(M,/mob/living/simple_animal))
		return "beastly"
	return "something"


/*var/list/mutant_races = list(
	"human",
	"fox",
	"fennec",
	"lizard",
	"tajaran",
	"panther",
	"husky",
	"squirrel",
	"otter",
	"murid",
	"leporid",
	"ailurus",
	"shark",
	"hawk",
	"jelly",
	"slime",
	"plant",
	)*/

var/list/mutant_tails = list(
	"none"=0,
	"tajaran"="tajaran",
	"neko"="neko",
	"dog"="lab",
	"wolf"="wolf",
	"fox"="fox",
	"mouse"="murid",
	"leporid"="leporid",
	"panda"="ailurus",
	"pig"="pig",
	"cow"="cow",
	"kangaroo"="kangaroo",
	"kangaroo"="kangaroo",
	"pony"="pony",
	"lizard"="lizard",
	"cyborg"="cyborg",
	"panda" = "panda",
	"carp" = "carp",
	"bee" = "bee",
	"succubus" = "succubus",
	"deathclaw" = "deathclaw",
	"doublefoxtail" = "doublefoxtail",
	"elephant" = "elephant"
	)

var/list/mutant_wings = list(
	"none"=0,
	"bat"="bat",
	"feathery"="feathery",
	"moth"="moth",
	"fairy"="fairy",
	"tentacle"="tentacle",
	"humming"="humming",
	"succubus" = "succubus",
	"bee" = "bee",
	"angel" = "angel",
	"smallfairy" = "smallfairy",
	"monarch" = "monarch",
	"swallowtail" = "swallowtail"
	)

var/list/cock_list = list(
	"human",
	"canine",
	"feline",
	"reptilian",
	"equine",
	"mega")


proc/kpcode_hastail(var/S)
	//switch(S)
		//if("jordy","husky","squirrel","lizard","narky","tajaran","otter","murid","fox","fennec","wolf","leporid","shark","panther","ailurus","glowfen","hawk")
	if(kpcode_race_tail(S)==1)
		return S
	if(kpcode_race_tail(S))
		return kpcode_race_tail(S)
		/*if("neko")
			return "tajaran"
		if("mouse")
			return "murid"
		if("panda")
			return "ailurus"*/
	if(S in mutant_tails)
		return mutant_tails[S]
	return 0

proc/kpcode_cantaur(var/S)
	return kpcode_race_taur(S)

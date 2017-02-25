

// ***********************************************************
// Candy! Delicious and sugary candy!
// Separated for organization and such
// ***********************************************************

//Candy / Candy Ingredients
//Subclass so we can pass on values
/obj/item/weapon/reagent_containers/food/snacks/candy
	name = "generic candy"
	desc = "It's placeholder flavored. This shouldn't be seen."
	icon = 'icons/obj/food/candy.dmi'
	icon_state = "candy"

/obj/item/weapon/reagent_containers/food/snacks/candy/New()
		..()

// ***********************************************************
// Candy Ingredients / Flavorings / Byproduct
// ***********************************************************

/obj/item/weapon/reagent_containers/food/snacks/chocolatebar
	name = "Chocolate Bar"
	desc = "Such sweet, fattening food."
	icon_state = "chocolatebar"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/chocolatebar/New()
	..()
	reagents.add_reagent("nutriment", 2)
	reagents.add_reagent("chocolate",4)
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/candy/caramel
	name = "Caramel"
	desc = "Chewy and dense, yet it practically melts in your mouth!"
	icon_state = "caramel"
	filling_color = "#DB944D"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/candy/caramel/New()
	..()
	reagents.add_reagent("cream", 2)
	reagents.add_reagent("sugar", 2)
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/candy/toffee
	name = "Toffee"
	desc = "A hard, brittle candy with a distinctive taste."
	icon_state = "toffee"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/candy/toffee/New()
	..()
	reagents.add_reagent("nutriment", 3)
	reagents.add_reagent("sugar", 3)
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/candy/nougat
	name = "Nougat"
	desc = "A soft, chewy candy commonly found in candybars."
	icon_state = "nougat"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/candy/nougat/New()
	..()
	reagents.add_reagent("nutriment", 3)
	reagents.add_reagent("sugar", 3)
	spawn(1)
		reagents.del_reagent("egg")
		reagents.update_total()
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/taffy
	name = "Saltwater Taffy"
	desc = "Old fashioned saltwater taffy. Chewy!"
	icon_state = "candy1"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/taffy/New()
	..()
	icon_state = pick("candy1", "candy2", "candy3", "candy4", "candy5")
	reagents.add_reagent("nutriment", 3)
	reagents.add_reagent("sugar", 3)
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/fudge
	name = "Fudge"
	desc = "Chocolate fudge, a timeless classic treat."
	icon_state = "fudge"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/fudge/New()
	..()
	reagents.add_reagent("cream", 3)
	reagents.add_reagent("chocolate",6)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/fudge/peanut
	name = "Peanut Fudge"
	desc = "Chocolate fudge, with bits of peanuts mixed in. People with nut allergies shouldn't eat this."
	icon_state = "fudge_peanut"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/fudge/cherry
	name = "Chocolate Cherry Fudge"
	desc = "Chocolate fudge surrounding sweet cherries. Good for tricking kids into eating some fruit."
	icon_state = "fudge_cherry"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/fudge/cookies_n_cream
	name = "Cookies 'n' Cream Fudge"
	desc = "An extra creamy fudge with bits of real chocolate cookie mixed in. Crunchy!"
	icon_state = "fudge_cookies_n_cream"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/fudge/cookies_n_cream/New()
	..()
	reagents.add_reagent("cream", 3)

/obj/item/weapon/reagent_containers/food/snacks/fudge/turtle
	name = "Turtle Fudge"
	desc = "Chocolate fudge with caramel and nuts. It doesn't contain real turtles, thankfully."
	icon_state = "fudge_turtle"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

// ***********************************************************
// Candy Products (Pre-existing)
// ***********************************************************

/obj/item/weapon/reagent_containers/food/snacks/donor
	name = "Donor Candy"
	desc = "A little treat for blood donors."
	trash = /obj/item/trash/candy
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/donor/New()
	..()
	reagents.add_reagent("nutriment", 10)
	reagents.add_reagent("sugar", 3)
	bitesize = 5

/obj/item/weapon/reagent_containers/food/snacks/candy_corn
	name = "candy corn"
	desc = "It's a handful of candy corn. Cannot be stored in a detective's hat, alas."
	icon_state = "candycorn"
	filling_color = "#FFFCB0"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/candy_corn/New()
	..()
	reagents.add_reagent("nutriment", 4)
	reagents.add_reagent("sugar", 2)
	bitesize = 2

// ***********************************************************
// Candy Products (plain / unflavored)
// ***********************************************************

/obj/item/weapon/reagent_containers/food/snacks/cotton
	name = "cotton candy"
	desc = "Light and fluffy, it's like eating a cloud made from sugar!"
	icon_state = "cottoncandy1"
	trash = /obj/item/weapon/c_tube
	filling_color = "#FFFFFF"
	icon = 'icons/obj/food/candy.dmi'



/obj/item/weapon/reagent_containers/food/snacks/cotton/New()
	..()
	reagents.add_reagent("sugar", 15)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/candy/candybar
	name = "candy"
	desc = "A chocolate candybar, wrapped in a bit of foil."
	icon_state = "candy"
	trash = /obj/item/trash/candy
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/candy/candybar/New()
	..()
	reagents.add_reagent("nutriment", 2)
	reagents.add_reagent("chocolate",5)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/candycane
	name = "candy cane"
	desc = "A festive mint candy cane."
	icon_state = "candycane"
	filling_color = "#F2F2F2"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/candycane/New()
	..()
	reagents.add_reagent("minttoxin", 1)
	reagents.add_reagent("sugar", 5)
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/gummybear
	name = "gummy bear"
	desc = "A small edible bear. It's squishy and chewy!"
	icon_state = "gbear"
	filling_color = "#FFFFFF"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummybear/New()
	..()
	reagents.add_reagent("sugar", 10)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummyworm
	name = "gummy worm"
	desc = "An edible worm, made from gelatin."
	icon_state = "gworm"
	filling_color = "#FFFFFF"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/New()
	..()
	reagents.add_reagent("sugar", 10)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas."
	icon_state = "jbean"
	filling_color = "#FFFFFF"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/New()
	..()
	reagents.add_reagent("sugar", 10)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jawbreaker
	name = "jawbreaker"
	desc = "An unbelievably hard candy. The name is fitting."
	icon_state = "jawbreaker"
	filling_color = "#ED0758"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jawbreaker/New()
	..()
	reagents.add_reagent("sugar", 10)
	bitesize = 0.1	//this is gonna take a while, you'll be working at this all shift.

/obj/item/weapon/reagent_containers/food/snacks/cash
	name = "candy cash"
	desc = "Not legal tender. Tasty though."
	icon_state = "candy_cash"
	filling_color = "#302000"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/cash/New()
	..()
	reagents.add_reagent("nutriment", 2)
	reagents.add_reagent("chocolate", 4)
	bitesize = 2

/obj/item/weapon/reagent_containers/food/snacks/coin
	name = "chocolate coin"
	desc = "Probably won't work in the vending machines."
	icon_state = "choc_coin"
	filling_color = "#302000"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/coin/New()
	..()
	reagents.add_reagent("nutriment", 2)
	reagents.add_reagent("chocolate",4)
	bitesize = 3


/obj/item/weapon/reagent_containers/food/snacks/gum/New()
	..()
	reagents.add_reagent("sugar", 5)
	bitesize = 0.2

/obj/item/weapon/reagent_containers/food/snacks/sucker
	name = "sucker"
	desc = "For being such a good sport!"
	icon_state = "sucker"
	filling_color = "#FFFFFF"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/sucker/New()
	..()
	reagents.add_reagent("sugar", 10)
	bitesize = 1

// ***********************************************************
// Gummy Bear Flavors
// ***********************************************************

/obj/item/weapon/reagent_containers/food/snacks/gummybear/red
	name = "gummy bear"
	desc = "A small edible bear. It's red!"
	icon_state = "gbear6"
	filling_color = "#801E28"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummybear/red/New()
	..()
	reagents.add_reagent("cherryjelly", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummybear/blue
	name = "gummy bear"
	desc = "A small edible bear. It's blue!"
	icon_state = "gbear2"
	filling_color = "#863333"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummybear/blue/New()
	..()
	reagents.add_reagent("berryjuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummybear/poison
	name = "gummy bear"
	desc = "A small edible bear. It's blue!"
	icon_state = "gbear2"
	filling_color = "#863353"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummybear/poison/New()
	..()
	reagents.add_reagent("poisonberryjuice", 12)
	spawn(1)
		reagents.del_reagent("sugar")
		reagents.update_total()
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummybear/green
	name = "gummy bear"
	desc = "A small edible bear. It's green!"
	icon_state = "gbear3"
	filling_color = "#365E30"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummybear/green/New()
	..()
	reagents.add_reagent("limejuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummybear/yellow
	name = "gummy bear"
	desc = "A small edible bear. It's yellow!"
	icon_state = "gbear8"
	filling_color = "#863333"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummybear/yellow/New()
	..()
	reagents.add_reagent("lemonjuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummybear/orange
	name = "gummy bear"
	desc = "A small edible bear. It's orange!"
	icon_state = "gbear4"
	filling_color = "#E78108"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummybear/orange/New()
	..()
	reagents.add_reagent("orangejuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummybear/purple
	name = "gummy bear"
	desc = "A small edible bear. It's purple!"
	icon_state = "gbear5"
	filling_color = "#993399"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummybear/purple/New()
	..()
	reagents.add_reagent("grapejuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummybear/wtf
	name = "gummy bear"
	desc = "A small bear. Wait... what?"
	icon_state = "gbear7"
	filling_color = "#60A584"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummybear/wtf/New()
	..()
	reagents.add_reagent("space_drugs", 2)
	bitesize = 3

// ***********************************************************
// Gummy Worm Flavors
// ***********************************************************

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/red
	name = "gummy worm"
	desc = "An edible worm, made from gelatin. It's red!"
	icon_state = "gworm_red"
	filling_color = "#801E28"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/red/New()
	..()
	reagents.add_reagent("cherryjelly", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/blue
	name = "gummy worm"
	desc = "An edible worm, made from gelatin. It's blue!"
	icon_state = "gworm_blue"
	filling_color = "#863333"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/blue/New()
	..()
	reagents.add_reagent("berryjuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/poison
	name = "gummy worm"
	desc = "An edible worm, made from gelatin. It's blue!"
	icon_state = "gworm_blue"
	filling_color = "#863353"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/poison/New()
	..()
	reagents.add_reagent("poisonberryjuice", 12)
	spawn(1)
		reagents.del_reagent("sugar")
		reagents.update_total()
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/green
	name = "gummy worm"
	desc = "An edible worm, made from gelatin. It's green!"
	icon_state = "gworm_green"
	filling_color = "#365E30"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/green/New()
	..()
	reagents.add_reagent("limejuice", 10)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/yellow
	name = "gummy worm"
	desc = "An edible worm, made from gelatin. It's yellow!"
	icon_state = "gworm_yellow"
	filling_color = "#863333"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/yellow/New()
	..()
	reagents.add_reagent("lemonjuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/orange
	name = "gummy worm"
	desc = "An edible worm, made from gelatin. It's orange!"
	icon_state = "gworm_orange"
	filling_color = "#E78108"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/orange/New()
	..()
	reagents.add_reagent("orangejuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/purple
	name = "gummy worm"
	desc = "An edible worm, made from gelatin. It's purple!"
	icon_state = "gworm_purple"
	filling_color = "#993399"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/purple/New()
	..()
	reagents.add_reagent("grapejuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/wtf
	name = "gummy worm"
	desc = "An edible worm. Did it just move?"
	icon_state = "gworm_wtf"
	filling_color = "#60A584"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/gummyworm/wtf/New()
	..()
	reagents.add_reagent("space_drugs", 2)
	bitesize = 3

// ***********************************************************
// Jelly Bean Flavors
// ***********************************************************

/obj/item/weapon/reagent_containers/food/snacks/jellybean/red
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. It's red!"
	icon_state = "jbean_red"
	filling_color = "#801E28"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/red/New()
	..()
	reagents.add_reagent("cherryjelly", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean/blue
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. It's blue!"
	icon_state = "jbean_blue"
	filling_color = "#863333"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/blue/New()
	..()
	reagents.add_reagent("berryjuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean/poison
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. It's blue!"
	icon_state = "jbean_blue"
	filling_color = "#863353"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/poison/New()
	..()
	reagents.add_reagent("poisonberryjuice", 12)
	spawn(1)
		reagents.del_reagent("sugar")
		reagents.update_total()
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean/green
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. It's green!"
	icon_state = "jbean_green"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/green/New()
	..()
	reagents.add_reagent("limejuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean/yellow
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. It's yellow!"
	icon_state = "jbean_yellow"
	filling_color = "#863333"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/yellow/New()
	..()
	reagents.add_reagent("lemonjuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean/orange
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. It's orange!"
	icon_state = "jbean_orange"
	filling_color = "#E78108"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/orange/New()
	..()
	reagents.add_reagent("orangejuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean/purple
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. It's purple!"
	icon_state = "jbean_purple"
	filling_color = "#993399"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/purple/New()
	..()
	reagents.add_reagent("grapejuice", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean/chocolate
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. It's chocolate!"
	icon_state = "jbean_choc"
	filling_color = "#302000"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/chocolate/New()
	..()
	reagents.add_reagent("chocolate",2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean/popcorn
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. It's popcorn flavored!"
	icon_state = "jbean_popcorn"
	filling_color = "#664330"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/popcorn/New()
	..()
	reagents.add_reagent("nutriment", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean/cola
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. It's Cola flavored!"
	icon_state = "jbean_cola"
	filling_color = "#102000"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/cola/New()
	..()
	reagents.add_reagent("cola", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean/drgibb
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. It's Dr. Gibb flavored!"
	icon_state = "jbean_cola"
	filling_color = "#102000"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/drgibb/New()
	..()
	reagents.add_reagent("dr_gibb", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean/coffee
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. It's Coffee flavored!"
	icon_state = "jbean_choc"
	filling_color = "#482000"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/coffee/New()
	..()
	reagents.add_reagent("coffee", 2)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/jellybean/wtf
	name = "jelly bean"
	desc = "A candy bean, guarenteed to not give you gas. You aren't sure what color it is."
	icon_state = "jbean_wtf"
	filling_color = "#60A584"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/jellybean/wtf/New()
	..()
	reagents.add_reagent("space_drugs", 2)
	bitesize = 3

// ***********************************************************
// Cotton Candy Flavors
// ***********************************************************

/obj/item/weapon/reagent_containers/food/snacks/cotton/red
	name = "cotton candy"
	desc = "Light and fluffy, it's like eating a cloud made from sugar!"
	icon_state = "cottoncandy8"
	trash = /obj/item/weapon/c_tube
	filling_color = "#801E28"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/cotton/red/New()
	..()
	reagents.add_reagent("cherryjelly", 5)
	bitesize = 4

/obj/item/weapon/reagent_containers/food/snacks/cotton/blue
	name = "cotton candy"
	desc = "Light and fluffy, it's like eating a cloud made from sugar!"
	icon_state = "cottoncandy1"
	trash = /obj/item/weapon/c_tube
	filling_color = "#863333"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/cotton/blue/New()
	..()
	reagents.add_reagent("berryjuice", 5)
	bitesize = 4

/obj/item/weapon/reagent_containers/food/snacks/cotton/poison
	name = "cotton candy"
	desc = "Light and fluffy, it's like eating a cloud made from sugar!"
	icon_state = "cottoncandy2"
	trash = /obj/item/weapon/c_tube
	filling_color = "#863353"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/cotton/poison/New()
	..()
	reagents.add_reagent("poisonberryjuice", 20)
	spawn(1)
		reagents.del_reagent("sugar")
		reagents.update_total()
	bitesize = 4

/obj/item/weapon/reagent_containers/food/snacks/cotton/green
	name = "cotton candy"
	desc = "Light and fluffy, it's like eating a cloud made from sugar!"
	icon_state = "cottoncandy2"
	trash = /obj/item/weapon/c_tube
	filling_color = "#365E30"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/cotton/green/New()
	..()
	reagents.add_reagent("limejuice", 5)
	bitesize = 4

/obj/item/weapon/reagent_containers/food/snacks/cotton/yellow
	name = "cotton candy"
	desc = "Light and fluffy, it's like eating a cloud made from sugar!"
	icon_state = "cottoncandy9"
	trash = /obj/item/weapon/c_tube
	filling_color = "#863333"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/cotton/yellow/New()
	..()
	reagents.add_reagent("lemonjuice", 5)
	bitesize = 4

/obj/item/weapon/reagent_containers/food/snacks/cotton/orange
	name = "cotton candy"
	desc = "Light and fluffy, it's like eating a cloud made from sugar!"
	icon_state = "cottoncandy3"
	trash = /obj/item/weapon/c_tube
	filling_color = "#E78108"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/cotton/orange/New()
	..()
	reagents.add_reagent("orangejuice", 5)
	bitesize = 4

/obj/item/weapon/reagent_containers/food/snacks/cotton/purple
	name = "cotton candy"
	desc = "Light and fluffy, it's like eating a cloud made from sugar!"
	icon_state = "cottoncandy6"
	trash = /obj/item/weapon/c_tube
	filling_color = "#993399"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/cotton/purple/New()
	..()
	reagents.add_reagent("grapejuice", 5)
	bitesize = 4

/obj/item/weapon/reagent_containers/food/snacks/cotton/pink
	name = "cotton candy"
	desc = "Light and fluffy, it's like eating a cloud made from sugar!"
	icon_state = "cottoncandy4"
	trash = /obj/item/weapon/c_tube
	filling_color = "#863333"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/cotton/pink/New()
	..()
	reagents.add_reagent("watermelonjuice", 5)
	bitesize = 4

/obj/item/weapon/reagent_containers/food/snacks/cotton/rainbow
	name = "cotton candy"
	desc = "Light and fluffy, it's like eating a cloud made from sugar!"
	icon_state = "cottoncandy7"
	trash = /obj/item/weapon/c_tube
	filling_color = "#C8A5DC"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/cotton/rainbow/New()
	..()
	reagents.add_reagent("omnizine", 20)
	spawn(1)
		reagents.del_reagent("sugar")
		reagents.update_total()
	bitesize = 4

/obj/item/weapon/reagent_containers/food/snacks/cotton/bad_rainbow
	name = "cotton candy"
	desc = "Light and fluffy, it's like eating a cloud made from sugar!"
	icon_state = "cottoncandy_rainbow"
	trash = /obj/item/weapon/c_tube
	filling_color = "#32127A"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/cotton/bad_rainbow/New()
	..()
	reagents.add_reagent("sulfonal", 20)
	spawn(1)
		reagents.del_reagent("sugar")
		reagents.update_total()
	bitesize = 4

// ***********************************************************
// Candybar Flavors
// ***********************************************************

/obj/item/weapon/reagent_containers/food/snacks/candybar/rice
	name = "Asteroid Crunch Bar"
	desc = "Crunchy rice deposits in delicious chocolate! A favorite of miners galaxy-wide."
	icon_state = "asteroidcrunch"
	trash = /obj/item/trash/candy
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/candybar/toffee
	name = "Yum-baton Bar"
	desc = "Chocolate and toffee in the shape of a baton. Security sure knows how to pound these down!"
	icon_state = "yumbaton"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/candybar/caramel
	name = "Malper Bar"
	desc = "A chocolate syringe filled with a caramel injection. Just what the doctor ordered!"
	icon_state = "malper"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/candybar/caramel_nougat
	name = "Toxins Test Bar"
	desc = "An explosive combination of chocolate, caramel, and nougat. Research has never been so tasty!"
	icon_state = "toxinstest"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

/obj/item/weapon/reagent_containers/food/snacks/candybar/nougat
	name = "Tool-erone Bar"
	desc = "Chocolate-covered nougat, shaped like a wrench. Great for an engineer on the go!"
	icon_state = "toolerone"
	filling_color = "#7D5F46"
	icon = 'icons/obj/food/candy.dmi'

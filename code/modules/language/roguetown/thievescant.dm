/datum/language/thievescant
	name = "Thieves' Cant"
	desc = "A secret language of gestures, expressions, and subtle body movements used by rogues, criminals, and the underworld to communicate without detection."
	speech_verb = "says"
	ask_verb = "asks"
	exclaim_verb = "yells"
	key = "x"
	flags = TONGUELESS_SPEECH | SIGNLANG
	space_chance = 66
	default_priority = 80
	icon_state = "thief"
	spans = list(SPAN_PAPYRUS)
	signlang_verb = list(
		"scrunches their nose",
		"smiles",
		"grins",
		"frowns",
		"smacks their lips",
		"bites their lip",
		"yawns",
		"squints",
		"winks",
		"darts their eyes left and right",
		"stares blankly",
		"raises an eyebrow",
		"shrugs",
		"stretches",
		"makes a rude gesture",
		"nods",
		"nods twice",
		"nods thrice",
		"shakes their head",
		"leans to their left",
		"leans to their right"
	)

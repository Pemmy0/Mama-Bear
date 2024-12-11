extends Node

var timmy_move_allowed = true
var mama_move_allowed = false
var mama_walk_anim = false

var kitchen_has_entered = false
var bathroom_has_entered = false
var trigger_phone_notification = false

var use_them_dialogue = false

var has_interacted_bedroom_1 = false
var has_interacted_corridor_1 = false
var has_interacted_livingroom_1 = false
var has_interacted_livingroom_2 = false
var has_interacted_livingroom_4 = false
var has_interacted_livingroom_5 = false
var has_interacted_bathroom_1 = false
var has_interacted_kitchen1 = false
var has_interacted_kitchen2 = false
var has_interacted_parent1 = false
var has_interacted_parent_bedroom_bed = false
var has_interacted_teddy = false
var has_interacted_lizard = false

var timmy_box = false

var call_final_2 = false
var call_final_3 = false

var has_played_ambience = false

#Bedroom
var bedroom_bed: Array[String] = [
	"The bed looks comfy", ". . . hm?", "Teddy is missing!!", "Is mama washing Teddy again?",
	"I need to ask mama!!"
]
var bedroom_table: Array[String] = [
	"No school today", "So no homework!", ". . . eh?", "Where are my books?",
	"And my pencils!?"
]
var bedroom_closet: Array[String] = [
	"So big. . .", "My clothes are also gone. . .", "Weird. . ."
]
var bedroom_book: Array[String] = [
	"I need to study hard", "So one day. . .", "I will be as smart as mama"
]
var bedroom_flower: Array[String] = [
	"Mama bought me this flower", "She said it reminds her of me", 
	"But I dont look like a flower!"
]
var bedroom_lizard: Array[String] = [
	"Greeni and Yellowi!", "Mama is taking us to a vacation!", 
	"I can't wait to bring you guys!!"
]

#Corridor
var corridor_picture: Array[String] = [
	"A picture of a baby", "I think that is me. . .", ". . . right?"
]
var corridor_urn: Array[String] = [
	"Dad said I shouldn't touch it", ". . .", 
	". T .", ". A .", ". M .", ". M .", ". Y .", "T . a . m . m . y . .", "But I'm Timmy!!",
	". . .", "hm. . .", "I wonder what's in there", "Should I open it?"
]
var corridor_mirror: Array[String] = [
	". . .", "aaaaaaaaaa", "he he"
]
var corridor_boxes: Array[String] = [
	"Whoa...", "Where did all these boxes come from?"
]
var corridor_cabinet_top: Array[String] = [
	"Dads broken watch"
]
var corridor_cabinet_bot: Array[String] = [
	"There is a ring inside!", "It is so pretty!"
]
#choices
var corridor_urn_choice1: Array[String] = [
	". . .", "Lots of gray sprinkles"
]
var corridor_urn_choice2: Array[String] = [
	"Better not do that", "Dad will be mad if I do"
]

#Living Room
var living_room_ash_tray:Array[String] = [
	"There's a lot of gray sprinkles here!", ". . .", "Should I taste it?"
]
var living_room_couch:Array[String] = [
	"Dad will get angry again if I sit here"
]
var living_room_fam_pic:Array[String] = [
	"it's me", "Mama", "And dad. . ."
]
var living_room_parents_1:Array[String] = [
	". . .", "I'm hungy"
]
var living_room_parents_2:Array[String] = [
	". . .", "I need to pee"
]
var living_room_tv:Array[String] = [
	"It's a person talking"
]
var living_room_coat:Array[String] = [
	"Dad's coat", "Smells bad. . .", ". . .", 
	"There is something in the pocket", "Should I check it out?"
]
var living_room_dada1:Array[String] = [
	"I should not bother dad"
]
var living_room_dada2:Array[String] = [
	"I dont want to make him angry"
]
var living_room_dada3:Array[String] = [
	"Put it on the kitchen table"
]
var living_room_delivery = {
	"Delivery1": "Delivery for. . .",
	"Delivery2": "Mr. Thomas Martin?",
	"Timmy2": "Oh. . .",
	"Timmy3": "Yes."
}
var livingroom_phone:Array[String] = [
	"Dad left his phone. . .", "I shouldn't play with it", ". . .",
	"Maybe a little peek?"
]
#choices
var living_room_ash_tray_choice1:Array[String] = [
	"HOEK!!", "YUCKY!!", "NO MORE GRAY SPRINKLES"
]
var living_room_ash_tray_choice2:Array[String] = [
	"Better not do that", "It might taste yucky. . ."
]
var living_room_coat_choice1:Array[String] = [
	"A crumpled up paper?", ". . .", '"Not mine. . ."', '"Not sure. . ."', 
	'"Cant trust her. . . ?"', "Weird."
]
var living_room_coat_choice2:Array[String] = [
	"Better not do that", "Dad will be mad if he found out"
]
var livingroom_phone_choice1:Array[String] = [
	". . .?", "*Ding*", "There is a message from. . .", "A coworker?", 
	'"Coming today?". . .?', "Is dad going somewhere?"
]
var livingroom_phone_choice2:Array[String] = [
	"Better not do that", "Dad will be mad if he found out"
]

#Kitchen
var kitchen_fridge_1:Array[String] = [
	"Empty. . .", "There is no food"
]
var kitchen_fridge_2:Array[String] = [
	"There is leftover lasagna", "But it is cold. . ."
]
var kitchen_table:Array[String] = [
	"Lots of gray marks. . ."
]
var kitchen_lasagna:Array[String] = [
	"Lasagna!", ". . .", "I think it belongs to dad. . .", 
	"He might get mad if I take some"
]
var kitchen_trash_bin:Array[String] = [
	". . . hm?", "Broken plate?"
]
var kitchen_whiskey:Array[String] = [
	"Dad often drink this", "It tastes yucky. . ."
]
var dada_count = 0
var kitchen_dada_1:Array[String] = [
	"I shouldn't bother dad"
]
var kitchen_dada_2:Array[String] = [
	"I don't want to make him angry"
]
#Bathroom
var bathroom_trash_bin_1:Array[String] = [
	"Empty. . ."
]
var bathroom_trash_bin_2:Array[String] = [
	". . . ?", "There is a crumpled piece of handkerchief with red marks on it",
	"I wonder what it is. . .", "Should I check it out?"
]
var bathroom_toilet_1:Array[String] = [
	"I don't need to pee anymore"
]
var bathroom_toilet_2:Array[String] = [
	"Eugh. . .", "It stinks. . ."
]
var bathroom_toothbrush:Array[String] = [
	". . .", "Eh?", "My toothbrush. . .", "is gone!"
]
#choices
var bathroom_trash_bin_choice1:Array[String] = [
	"There is a number and a kiss!", "Must be from Mom!"
]
var bathroom_trash_bin_choice2:Array[String] = [
	"Better not do that", "Dirty. . .", "Yuck"
]

#Parents Bedroom
var parent_bedroom_mama_1 = {
	"Timmy1" : "Mom. . .",
	"Timmy2" : "Are we going on a vacation?",
	"Mama3" : "Vacation?",
	"Mama4" : "Oh right! Yes!",
	"Mama5" : "We are!",
	"Mama6" : "We are leaving today",
	"Timmy7" : "Really!?",
	"Timmy8" : "Yippie!!",
	"Timmy9" : "Where are we going?",
	"Mama10" : "It is a secret",
	"Timmy11" : "A secret?",
	"Timmy12" : "Tell me, tell me!",
	"Mama13" : "Mama will tell you later okay?",
	"Mama14" : "But for now. . .",
	"Mama15" : "Can you keep this a secret?",
	"Timmy16" : "Like spies!",
	"Mama17" : "Exactly!", 
	"Mama18" : "Just you and me, okay?",
	"Mama19" : "Promise?",
	"Timmy20" : "Promise!"
}
var parent_bedroom_suitcase: Array[String] = [
	"Mama is packing her clothes. . .", "Are we going on a vacation?"
]
var parent_bedroom_teddy: Array[String] = [
	"Teddy!", ". . .hm?", "Mama patched you up!"
]
var parent_bedroom_bed: Array[String] = [
	"There is only one pillow. . . ?"
]
var parent_bedroom_door: Array[String] = [
	"I need to check on Teddy before I leave"
]
var parent_bedroom_closet: Array[String] = [
	"Mama closet is empty. . .", "Must be a super long vacation!",
	"I cant wait!"
]
var parent_bedroom_papers: Array[String] = [
	"Dee...vo...se egg...reement?", "It has Mama and Dad signatures!", 
	"Must be a love letter!"
]
var parent_bedroom_cabinet: Array[String] = [
	"There is a picture inside!", "It is mama and. . .", "Dad?", "Why is it broken though?", 
	". . .", "There is something on the back", "Should I check it out?"
]
#choices
var parent_bedroom_cabinet_choice1:Array[String] = [
	". . .", "A number?", "Twenty", "Seven", "Twenty", "Fourteen?"
]
var parent_bedroom_cabinet_choice2:Array[String] = [
	"Better not do that"
]

#trigger dialogue
var trigger_bedroom_1:Array[String] = [
	". . .", "I'm hungy. . ."
]
var trigger_corridor_1:Array[String] = [
	"*CRASH*"
]
var trigger_livingroom_1:Array[String] = [
	". . .", "I need to pee. . ."
]
var trigger_livingroom_2 = {
	"Dada1": "TIMMY!",
	"Dada2" : "GET OUT OF THE WAY!",
	"Timmmy3": "Sorry dad."
}
var trigger_livingroom_3:Array[String] = [
	"TIMMY!", "GO GET THE DOOR!!"
]
var trigger_livingroom_4 = {
	"Dada1": "What are you doing!?",
	"Dada2": "GO GET THE DOOR!",
	"Timmy3": "Yes dad."
}
var trigger_livingroom_5:Array[String] = [
	"What are you doing?", "PUT IT ON THE KITCHEN TABLE!"
]
var kitchen_trigger1 = {
	"Dada1": "Don't play in the kitchen",
	"Timmmy2": "Yes dad."
}
var kitchen_trigger2 = {
	"Dada1": "I said. . .",
	"Dada2" : "DON'T PLAY IN THE KITCHEN!",
	"Timmmy3": "Sorry dad."
}
var trigger_bathroom_1:Array[String] = [
	"DONT PLAY IN THE BATHROOM!"
]
var parent_trigger1 = {
	"Mama1": "Timmy",
	"Timmy2" : "Yes mama?",
	"Mama3": "Don't play in the bedroom okay?",
	"Mama4": "Mama is busy right now",
	"Timmy5": "Okay mama"
}

#Last Scene / Dada n Mama Dialogues
var dada_lines_1: Array[String] = [
	"WHAT DID I SAY ABOUT TOUCHING MY STUFF!!"
]
#Dada grabs Timmy by his hand
var final_fight_1 = {
	"Dada1": "I TOLD YOU NOT TO TOUCH MY STUFF!",
	"Dada2": "YOU ANNOYING LITTLE BRAT!",
	"Dada3": "ALWAYS GETTING IN MY WAY!",
	"Dada4": "STOP CRYING",
	"Dada5": "I SAID STOP CRYING, YOU PIECE OF SHIT",
	"Mama6": "GET YOUR HANDS OFF MY CHILD!"
}
#Mama come to the rescue
var final_fight_2 = {
	"Mama1": "I said.",
	"Mama2": "HANDS OFF MY CHILD!",
	"Mama3": "NOW!!"
}
#Timmy runs onto mama and hid behind her back
var final_fight_3 = {
	"Mama2": "You disgust me",
	"Mama3": "I should have never married you",
	"Mama4": "I was dumb enough to waste ten years",
	"Mama5": "Ten fucking years, just for you to-",
	"Mama6": ". . .",
	"Mama7": "Sigh",
	"Mama8": "Im not letting you hurt me. . .",
	"Mama9": "Or my child anymore",
	"Mama10": ". . .",
	"Mama11": "Never again."
}
#Mama Walks away with Timmy
var final_fight_4 = {
	"Dada1": "Yeah its your fucking child",
	"Mama2": ". . .",
	"Mama3": "You are sick",
	"Mama4": "lets go now honey"
}
#Scene 7 Last Dialogue
var final_fight_5 = {
	"Timmy1": "Mama, are we going on that vacation?",
	"Mama2": "Yes honey. . .",
	"Mama3": "We are.",
	"Timmy4": "Is dad coming?",
	"Mama5": "No.",
	"Mama6": "He wont be coming with us"
}
var ending: Array[String] = [
	"Mama said we are going on a vacation", "But it has been so long", 
	"I miss the yellow house. . .", "And I miss dad."
]

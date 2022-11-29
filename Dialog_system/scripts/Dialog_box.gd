extends Control

enum {on_dialog,out_dialog}
enum {in_event, out_event}
enum {pressed,not_pressed}
var button_press = pressed
var event = in_event
var status = out_dialog
var wait_time = 2
var upgrade_counter = 0
var dialog_status = [1,1,1,1,1,1,1,1,1,1]


var has_event = true 

var day = 0 

var dialog = [
	"Sir, it's time to continue our plans.",
	"It looks like the last human finally got away!",
	"Now we need to take care of this farm. Without it, we will starve.",
	"It seems those traitors continued to attack us for food.",
	"But stay strong. You know very well what they did to your brother and what they are going to do to you.",
	"How could they? Your brother was such a good leader to everyone. Without him, we would never have gotten rid of humans.",
	"What's left for us now is revenge. We're going to let everyone starve to pay for what they did to your brother.",
	"Let them all starve now! In the meantime, let's survive; just me and you...",
	"Well, I need to take care of the plantation now. Daily I will offer you some of my harvest.",
	"Please take care of site administration and repairs. I will come back every 7 days to talk about progress.",
	"In the meantime, how about scaring off some crows in the plantation and in the barn? Looks like some traitors are causing trouble there.",
	"Be careful not to overwork too! When your energy runs out, come back here and rest. If you use up all your energy, you won't be able to work anymore.",
	"You can also make some Upgrades if you prefer. Remember, repairing this farm is our goal. Then you must perform all available upgrades.",
	"See you soon. I'll be back to report in 7 days."
]

var dialog2 = [
	"Looked like you're having some problems, right? Those damned traitors, they leave your brother and now they want to rob us...",
	"To his brother, all crows were family. But look at this? It was only he managed to finish off the humans that the crows betrayed him.",
	"But I'm glad to see them starving. Revenge, sweet revenge!",
	"Well, I need to get back to work now. Again, see you in 7 days."
	
]

var dialog3 = [
	"These bastards really want to see us starving, right? Or do they keep coming just because THEY are starving?",
	"HAHHAHAHAHAHAHAHAHAHAHAHAHHAHAHAHAHAHAHHAAHAHAHHAHAHAHAHAHAHAHAHAHAHAH!!!!!!!!",
	"We have the last corn plantation now. They may keep coming, but in the end, we'll just survive the two of us!",
	"They will pay for everything they did to you. For your brother, let's do this together.",
	"I will be back to work again. I'll keep an eye on yo.... I mean, on the plantation.",
	"See you in 7 days."
]

var dialog4 = [
	"Irmão, lider, acabar, humanos, juntos, prosperar, irmãos, liderar, traição, traição, traição, traição!!!",
	"Are you alright sir? ",
	"1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111",
	"Nos vemos em 7 dias"
	
]

var dialog5 = [
	"Looks like we're surviving. It's been some days since we took control of this farm. Our friends don't come so much anymore",
	"Probably many of them have already starved or fled. Would your brother be happy?",
	"After all, it was for them that we expelled humans. We take care of everything anyway, don't we? Destroying all food reserves and means of production was a genius plan, sir.",
	"You are also a sensational leader! You made it possible for everyone in the world to come here and live together",
	"But they were all traitors, they had to end it all, didn't they??",
	"In 7 days."
]

var dialog6 = [
	"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",
	"ME ME ME MEM ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME ME !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",
	"Traitor?",
	"7 days"
]

var dialog7 = [
	"It looks like things are looking up, sir. The farm repair is going as planned and your brother is very proud!",
	"I'm sure our brothers will be happy when they arrive. Soon we'll have food for everyone!",
	"See you in 7 days. Our mission is close to be completed."
]

var dialog8 = [
	"Traitor, me?",
	"7"
]

var dialog9 = [
	"Sir, I flew over the farm and realized our brothers' nests are in ruins!",
	"Very few are left, probably not withstanding hunger.",
	"Unfortunately, I couldn't find your brother either... I hope he's okay! He will still lead us to prosperity.",
	"He's brilliant, isn't he? And I envy him so much. How I would like to be him.",
	"Unfortunately, we had our falling out; he was a pacifist and was totally against the plan of human extinction. But I love him so much.",
	"See you in 7 days, sir!"
]


var dialog10 = [
	"How is it to feel the pain of guilt? The crows will go extinct and you're the only one left",
	"Maybe you already know at this point, but I am you...",
	"Unfortunately, the loss of my brother was much harder on me than I thought I could handle...",
	"But he was silly, believed that humans would not capture him on this farm",
	"He and the others doubt the cruelty of humans",
	"And of my plan to take over the means of production... They said they were stronger, smarter and that they deserved...",
	"I always said, we don't depend on them, we might as well take over the production methods of humans",
	"They laughed at me... A crow, tending crops ha ha ha. But hey, I can take care of this farm!",
	"AHAHHAHAHAHAHHAHAHHAHAHHAHAHAHHAHAHHAHAHHAHAHHAHAHAHHAH!!!!!",
	"Look at me now! I was right all along!",
	"I was right!",
	"And now I'm alone...",
	"No more than 7 days, I don't have anyone now... I'll just prove to myself that I was capable. Because the others are no longer here to see.",
	"and live!",
	"alone..."
]

var alternative_dialog = [
	"Hmmmmm, very welll! It's look you're doing good.",
	"I have not to say yet. See you in 7 days."
]

onready var dialogo = dialog


var dialog_index = 0
var finished = false
var counter = 0 

func _ready():
	reset_parameters()

func _process(delta):
	
	if has_event == true:
		if button_press == pressed and status == out_dialog and event == in_event:
			dialog_events()
			load_dialog()
		
func load_dialog():
	if dialog_index < dialogo.size():
		$"../next".hide()
		status = on_dialog
		$"../dialogue_timer".start()
		finished = false
		$RichTextLabel.bbcode_text = dialogo[dialog_index]
		$RichTextLabel.percent_visible = 0
		$RichTextLabel.push_align(RichTextLabel.ALIGN_CENTER)
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, wait_time,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($RichTextLabel,"draw")
		
	dialog_index += 1
	counter += 1 
	
	

	
func dialog_events():
	if counter <= dialog.size():
		pass

	else:
		has_event = false
		event = out_event
		$"..".hide()
		activate_buttons()
		if dialog_status[8] != 1:
			$"..".queue_free()

	
func _on_Tween_tween_completed(object, key):
	finished = true

func _on_dialogue_timer_timeout():
	status = out_dialog
	button_press = not_pressed
	$"../next".show()


func _on_next_pressed():
	button_press = pressed
	$"../../audios/sfx/buttons".play()


func _on_return_pressed():
	day += 1
	
	
	if day%7 == 0:
		if upgrade_counter > 0 and upgrade_counter < 3:
			if dialog_status[0] == 1:
				dialogo = dialog2
				dialog_status[0] = 0
			else:
				dialogo = alternative_dialog
			
		elif upgrade_counter >= 3 and upgrade_counter < 6: 
			if dialog_status[1] == 1:
				dialogo = dialog3
				dialog_status[1] = 0
			else:
				dialogo = alternative_dialog
			
		elif upgrade_counter >= 6 and upgrade_counter < 8: 
			if dialog_status[2] == 1:
				dialogo = dialog4
				dialog_status[2] = 0
			else:
				dialogo = alternative_dialog

			
		elif upgrade_counter >= 8 and upgrade_counter < 10: 
			if dialog_status[3] == 1:
				dialogo = dialog5
				dialog_status[3] = 0
			else:
				dialogo = alternative_dialog

			
		elif upgrade_counter >= 10 and upgrade_counter < 12: 
			if dialog_status[4] == 1:
				dialogo = dialog6
				dialog_status[4] = 0
			else:
				dialogo = alternative_dialog

		elif upgrade_counter >= 12 and upgrade_counter < 14: 
			if dialog_status[5] == 1:
				dialogo = dialog7
				dialog_status[5] = 0
			else:
				dialogo = alternative_dialog

			
		elif upgrade_counter >= 14 and upgrade_counter < 16: 
			if dialog_status[6] == 1:
				dialogo = dialog8
				dialog_status[6] = 0
			else:
				dialogo = alternative_dialog

			
		elif upgrade_counter >= 16 and upgrade_counter < 20: 
			if dialog_status[7] == 1:
				dialogo = dialog9
				dialog_status[7] = 0
			else:
				dialogo = alternative_dialog
		elif upgrade_counter >= 20: 
			if dialog_status[8] == 1:
				dialogo = dialog10
				dialog_status[8] = 0
			else:
				pass
			
		reset_parameters()
	 
#	if day == 15: 
#		dialogo = dialog2
#		reset_parameters()
#
#	elif day == 30:
#		dialogo = dialog3
#		reset_parameters()
#
#	elif day == 45:
#		dialogo = dialog4
#		reset_parameters()
#
#	elif day == 60:
#		dialogo = dialog5
#		reset_parameters()
#
#	elif day == 75:
#		dialogo = dialog6
#		reset_parameters()
#
#	elif day == 90:
#		dialogo = dialog7
#		reset_parameters()
#
#	elif day == 105:
#		dialogo = dialog8
#		reset_parameters()
#
#	elif day == 120:
#		dialogo = dialog9
#		reset_parameters()
#
#	elif day == 135:
#		dialogo = dialog10
#		reset_parameters()
		

func reset_parameters():
		counter = 0 
		dialog_index = 0
		$"..".show()
		has_event = true
		event = in_event
		$"../../Button_main/Barn".disabled = true
		$"../../Button_main/Plantation".disabled = true
		$"../../Button_main/Upgrades".disabled = true
		$"../../Button_main/next_day".disabled = true

func activate_buttons():
		$"../../Button_main/Barn".disabled = false
		$"../../Button_main/Plantation".disabled = false
		$"../../Button_main/Upgrades".disabled = false
		$"../../Button_main/next_day".disabled = false


func upgrade_button():
	upgrade_counter += 1 

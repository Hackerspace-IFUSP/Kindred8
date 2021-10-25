extends Node

enum{main,barn,plantation,upgrades}
var location = main

var corn = 200000
var capacity = 200
var day = 0 
var increase_corn = 100
var decrease_corn = 50
var energy = 100 
var barn_crows = 3
var barn_damages = 3
var plantation_crows = 3
var plantation_damages = 3 
var sky_rotation = 0 


var imp_harv_val = [100,200,400,800,1000,10000]
var imp_barn_val = [100,200,400,800,1000,10000]
var imp_scarecrow_val = [100,200,400,800,1000,10000]
var imp_repair_val = [100,200,400,800,1000,10000]
var imp_energy_val = [100,200,400,800,1000,10000]

var imp_harv = 0
var imp_barn = 0
var imp_scarecrow = 0
var imp_repair = 0
var imp_energy = 0


func _ready():
	$Button_main/anim.play("event")
	$HUD/anim.play("event")
	$Dialog/anim.play("event")

func _process(delta):
	
	sky_change()
	rotate()
	if Input.is_action_just_pressed("ui_down"):
		$Dialog/Textbox.hide()
		$Dialog/Crow.hide()
		$Dialog/Text.hide()


func rotate():
	if location == barn and $Discs/Buildings.rotation != PI:
		$Discs/Buildings.rotation += .1
		if $Discs/Buildings.rotation > PI:
			$Discs/Buildings.rotation = PI
			
	elif location == plantation and $Discs/Buildings.rotation != PI/2:
		$Discs/Buildings.rotation += .1
		if $Discs/Buildings.rotation > PI/2:
			$Discs/Buildings.rotation = PI/2
	
	elif location == upgrades and $Discs/Buildings.rotation != 3*PI/4:
		$Discs/Buildings.rotation += .1
		if $Discs/Buildings.rotation > 3*PI/2:
			$Discs/Buildings.rotation = 3*PI/2
		
	elif location == main and $Discs/Buildings.rotation != 0:
		$Discs/Buildings.rotation += .1
		if $Discs/Buildings.rotation > 2*PI:
			$Discs/Buildings.rotation = 0


####Main_buttons##############################################################

func _on_Barn_pressed():
	location = barn
	$Button_main/anim_button_change.play("event")
	$Button_barn/anim_barn.play("event")
	$Back_button/anim_back_button.play("event")
	$Button_barn/anim_barn.play("event")

func _on_Plantation_pressed():
	location = plantation
	$Button_main/anim_button_change.play("event")
	$Button_plantation/anim_plantation.play("event")
	$Back_button/anim_back_button.play("event")

func _on_Upgrades_pressed():
	location = upgrades
	$Button_main/anim_button_change.play("event")
	$Button_upgrades/anim_upgrades.play("event")
	$Back_button/anim_back_button.play("event")

func _on_next_day_pressed():
	change_day()
	$Button_main/anim_button_change.play("event")
	$Daily_report/anim.play("event")


func _on_return_pressed():
	energy = 100
	$HUD/Energy_bar.rect_scale.y = 1
	sky_rotation = 0
	$Button_main/anim_button_change.play("event2")
	$Daily_report/anim.play("event2")


func change_day():
	day += 1 
	corn += increase_corn - decrease_corn
	$Daily_report/corn_earned.text = str("Corn earned: ", increase_corn)
	$Daily_report/corn_lost.text = str("Corn lost: ", decrease_corn)
	$Daily_report/total.text = str("Total: ", corn)
	$HUD/Corn.text = str("Corn: ", corn)
	$HUD/Day.text = str("Day:", day)


####barn button################################################################

func _on_Scare_off_b_pressed():
	if energy >= 25:
		barn_crows -= 1
		barn_buttons_event()

func _on_Fix_b_pressed():
	if energy >= 25:
		barn_damages -= 1 
		barn_buttons_event()

		
func barn_buttons_event():
		$Button_barn/anim_barn.play("event2")
		$Back_button/anim_back_button.play("event2")
		$Button_barn/Scare_off_b.disabled = true
		$Button_barn/Fix_b.disabled = true
		$Back_button/Back.disabled = true
		$Button_barn/timer_barn_event.start()
		energy_change()
		
func _on_timer_barn_event_timeout():
		$Button_barn/Scare_off_b.disabled = false
		$Button_barn/Fix_b.disabled = false
		$Back_button/Back.disabled = false
		$Button_barn/anim_barn.play("event")
		$Back_button/anim_back_button.play("event")
		
####plantation button###########################################################
func _on_Scare_off_p_pressed():
	if energy >= 25:
		barn_crows -= 1
		plantation_buttons_event()


func _on_Fix_p_pressed():
	if energy >= 25:
		barn_damages -= 1 
		plantation_buttons_event()


func plantation_buttons_event():
		$Button_plantation/anim_plantation.play("event2")
		$Back_button/anim_back_button.play("event2")
		$Button_plantation/Scare_off_p.disabled = true
		$Button_plantation/Fix_p.disabled = true
		$Back_button/Back.disabled = true
		$Button_plantation/timer_plantation_event.start()
		energy_change()
		
func _on_timer_plantation_event_timeout():
		$Button_plantation/anim_plantation.play("event")
		$Back_button/anim_back_button.play("event")
		$Button_plantation/Scare_off_p.disabled = false
		$Button_plantation/Fix_p.disabled = false
		$Back_button/Back.disabled = false

####energy_change###############################################################

func energy_change():
	energy -= 25
	$HUD/Energy_bar.rect_scale.y -= .25
	sky_rotation += PI/3
	#sky_change()


func sky_change():
	if $Discs/Sky.rotation != sky_rotation:
		$Discs/Sky.rotation += .01
		if $Discs/Sky.rotation > sky_rotation:
			$Discs/Sky.rotation = sky_rotation
####back button################################################################

func _on_Back_pressed():
	if location == barn:
		$Button_barn/anim_barn.play("event2")
	elif location == plantation:
		$Button_plantation/anim_plantation.play("event2")
	elif location == upgrades:
		$Button_upgrades/anim_upgrades.play("event2")
	
	location = main
	$Button_main/anim_button_change.play("event2")
	$Button_barn/anim_barn.play("event2")
	$Back_button/anim_back_button.play("event2")


####upgrade_button##############################################################

func _on_Imp_harvest_pressed():
	if corn >= imp_harv_val[imp_harv] and imp_harv < len(imp_harv_val):
		corn -= imp_harv_val[imp_harv]
		imp_harv += 1 
		if imp_harv < len(imp_harv_val):
			$Button_upgrades/Imp_harvest/price.text = str("Price: ", imp_harv_val[imp_harv])
			$HUD/Corn.text = str("Corn: ", corn)
		else:
			$HUD/Corn.text = str("Corn: ", corn)
			$Button_upgrades/Imp_harvest/price.text = str("Full")
			$Button_upgrades/Imp_harvest.disabled = true

func _on_Imp_barn_space_pressed():
	if corn >= imp_barn_val[imp_barn] and imp_barn < len(imp_barn_val):
		corn -= imp_barn_val[imp_barn]
		imp_barn += 1 
		if imp_barn < len(imp_barn_val):
			$Button_upgrades/Imp_barn_space/price.text = str("Price: ", imp_barn_val[imp_barn])
			$HUD/Corn.text = str("Corn: ", corn)
		else:
			$HUD/Corn.text = str("Corn: ", corn)
			$Button_upgrades/Imp_barn_space/price.text = str("Full")
			$Button_upgrades/Imp_barn_space.disabled = true


func _on_Imp_scarecrow_pressed():
	if corn >= imp_scarecrow_val[imp_scarecrow] and imp_scarecrow < len(imp_scarecrow_val):
		corn -= imp_scarecrow_val[imp_scarecrow]
		imp_scarecrow += 1 
		if imp_scarecrow < len(imp_scarecrow_val):
			$Button_upgrades/Imp_scarecrow/price.text = str("Price: ", imp_scarecrow_val[imp_scarecrow])
			$HUD/Corn.text = str("Corn: ", corn)
		else:
			$HUD/Corn.text = str("Corn: ", corn)
			$Button_upgrades/Imp_scarecrow/price.text = str("Full")
			$Button_upgrades/Imp_scarecrow.disabled = true


func _on_less_repair_pressed():
	if corn >= imp_repair_val[imp_repair] and imp_repair < len(imp_repair_val):
		corn -= imp_repair_val[imp_repair]
		imp_repair += 1 
		if imp_repair < len(imp_repair_val):
			$Button_upgrades/less_repair/price.text = str("Price: ", imp_repair_val[imp_repair])
			$HUD/Corn.text = str("Corn: ", corn)
		else:
			$HUD/Corn.text = str("Corn: ", corn)
			$Button_upgrades/less_repair/price.text = str("Full")
			$Button_upgrades/less_repair.disabled = true


func _on_less_energy_pressed():
	if corn >= imp_energy_val[imp_energy] and imp_energy < len(imp_energy_val):
		corn -= imp_energy_val[imp_energy]
		imp_energy += 1 
		if imp_energy < len(imp_energy_val):
			$Button_upgrades/less_energy/price.text = str("Price: ", imp_energy_val[imp_energy])
			$HUD/Corn.text = str("Corn: ", corn)
		else:
			$HUD/Corn.text = str("Corn: ", corn)
			$Button_upgrades/less_energy/price.text = str("Full")
			$Button_upgrades/less_energy.disabled = true

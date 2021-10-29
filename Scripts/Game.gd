extends Node

enum{main,barn,plantation,upgrades}
var location = main

var corn = 100
var capacity = 200
var day = 0 

var energy = 100
var plantation_crows = 3
var plantation_damages = 3 
var sky_rotation = 0 

var energy_usage = 25

var imp_harv_val = [100,150,250,350,600,1200]
var imp_barn_val = [100,150,250,350,600,1000]
var imp_scarecrow_val = [100,150,350,600]
var imp_repair_val = [100,150,350,600]
var imp_energy_val = [100,200]

var imp_harv = 0
var imp_barn = 0
var imp_scarecrow = 0
var imp_repair = 0
var imp_energy = 0

var crows_in_barn = 2
var crow_in_plantation = 2
var damages_in_barn = 0
var damages_in_plantation = 0 

var repair_incident


func _ready():
	$audios/sfx/next_day.play()
	$transition.play("event")
	yield($transition,"animation_finished")
	
	$audios/music.play()
	$Button_main/anim.play("event")
	$HUD/anim.play("event")
	$HUD/Day.text = str("Day: ", day)
	$HUD/Barn_capacity.text = str("Barn Capacity: ",capacity)
	$HUD/Corn.text = str("Corn: ", corn)
	$Button_barn/crows_in_barn.text = str("Crows: ", crows_in_barn)
	$Button_barn/damages_in_barn.text = str("Damages: ", damages_in_barn)
	$Button_plantation/damages_in_plantation.text = str ("Damages: ", damages_in_plantation)
	$Button_plantation/crows_in_plantation.text = str ("Crows: ", crow_in_plantation)
	
	$Button_upgrades/Imp_barn_space/price.text = str("Price: ", imp_barn_val[0])
	$Button_upgrades/Imp_harvest/price.text = str("Price: ", imp_harv_val[0])
	$Button_upgrades/Imp_scarecrow/price.text = str("Price: ", imp_scarecrow_val[0])
	$Button_upgrades/less_energy/price.text = str("Price: ", imp_energy_val[0])
	$Button_upgrades/less_repair/price.text = str("Price: ", imp_repair_val[0])
	
func _process(delta):
	sky_change()
	rotate()
	#if Input.is_action_just_pressed("ui_down"):
	#	$Dialog/Textbox.hide()
	#	$Dialog/Crow.hide()
	#	$Dialog/Text.hide()


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
	$audios/sfx/wheel_buttons.play()
	$Button_main/anim_button_change.play("event")
	$Button_barn/anim_barn.play("event")
	$Back_button/anim_back_button.play("event")
	$Button_barn/anim_barn.play("event")

func _on_Plantation_pressed():
	location = plantation
	$audios/sfx/wheel_buttons.play()
	$Button_main/anim_button_change.play("event")
	$Button_plantation/anim_plantation.play("event")
	$Back_button/anim_back_button.play("event")

func _on_Upgrades_pressed():
	location = upgrades
	$audios/sfx/wheel_buttons.play()
	$Button_main/anim_button_change.play("event")
	$Button_upgrades/anim_upgrades.play("event")
	$Back_button/anim_back_button.play("event")

func _on_next_day_pressed():
	change_day()
	
	$Button_main/anim_button_change.play("event")
	$Daily_report/anim.play("event")
	
	$audios/sfx/next_day.play()


func _on_return_pressed():
	energy = 100
	$HUD/Energy_bar.rect_scale.y = 1
	sky_rotation = 0
	$Button_main/anim_button_change.play("event2")
	$Daily_report/anim.play("event2")
	
	$audios/sfx/next_day.play()


func change_day():
	day += 1 
	var corn_earned_in_plantation = rand_range(20,30) + 10 * imp_harv
	var corn_lost_in_plantation = 5 * (crow_in_plantation + damages_in_plantation)
	var corn_by_plantation = int(corn_earned_in_plantation - corn_lost_in_plantation)
	
	var corn_lost = - 2 * (crows_in_barn + damages_in_barn)
	
	
	corn += corn_by_plantation + corn_lost
	
	if corn > capacity:
		corn = capacity
	elif corn < 0:
		corn = int(0)
	
	
	var add_crow_in_plantation = int(3 - imp_scarecrow/2)
	crow_in_plantation += int(rand_range(0 , add_crow_in_plantation))  + int(randi()%2)
	if crow_in_plantation > 5:
		crow_in_plantation = 5
	var add_crow_in_barn = int(3 - imp_scarecrow/2)
	crows_in_barn += int(rand_range(0,add_crow_in_barn))  + int(randi()%2)
	if crows_in_barn > 5:
		crows_in_barn = 5
	var add_damage_in_plantation = int(3 - imp_repair/2)
	damages_in_plantation += int(rand_range(0,add_damage_in_plantation))  + int(randi()%2)
	if damages_in_plantation > 5:
		damages_in_plantation = 5
	var add_damage_in_barn = int(3 - imp_repair/2)
	damages_in_barn += int(rand_range(0,add_damage_in_barn)) + int(randi()%2)
	if damages_in_barn > 5:
		damages_in_barn = 5
	
	$Daily_report/corn_earned.text = str("Corn earned: ", corn_by_plantation)
	$Daily_report/corn_lost.text = str("Corn lost: ", corn_lost)
	$Daily_report/total.text = str("Total: ", corn)
	$"Daily_report/Daily Report".text = str("Daily Report #",day)
	$HUD/Corn.text = str("Corn: ", corn)
	$HUD/Day.text = str("Day:", day)
	$Button_barn/damages_in_barn.text = str("Damages: ", damages_in_barn)
	$Button_barn/crows_in_barn.text = str("Crows: ", crows_in_barn)
	$Button_plantation/damages_in_plantation.text = str ("Damages: ", damages_in_plantation)
	$Button_plantation/crows_in_plantation.text = str ("Crows: ", crow_in_plantation)

####barn button################################################################

func _on_Scare_off_b_pressed():
	if energy >= energy_usage:
		if crows_in_barn > 0:
			crows_in_barn -= 1
		barn_buttons_event()
		$animated/anim_fix_and_scare.play("sacreoff")
		$audios/sfx/crow.play()

func _on_Fix_b_pressed():
	if energy >= energy_usage:
		if damages_in_barn > 0:
			damages_in_barn -= 1
		barn_buttons_event()
		$animated/anim_fix_and_scare.play("fix")
		$audios/sfx/repair.play()

		
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
		$Button_barn/damages_in_barn.text = str("Damages: ", damages_in_barn)
		$Button_barn/crows_in_barn.text = str("Crows: ", crows_in_barn)
		
####plantation button###########################################################
func _on_Scare_off_p_pressed():
	if energy >= energy_usage:
		if crow_in_plantation > 0:
			crow_in_plantation -= 1
		plantation_buttons_event()
		$animated/anim_fix_and_scare.play("sacreoff")
		$audios/sfx/crow.play()

func _on_Fix_p_pressed():
	if energy >= energy_usage:
		if damages_in_plantation > 0:
			damages_in_plantation -= 1
		plantation_buttons_event()
		$animated/anim_fix_and_scare.play("fix")
		$audios/sfx/repair.play()

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
		$Button_plantation/damages_in_plantation.text = str ("Damages: ", damages_in_plantation)
		$Button_plantation/crows_in_plantation.text = str ("Crows: ", crow_in_plantation)


####energy_change###############################################################

func energy_change():
	energy -= energy_usage
	$HUD/Energy_bar.rect_scale.y -=float(energy_usage)/float(100)
	if energy_usage == 25:
		sky_rotation += PI/3
	elif energy_usage == 20:
		sky_rotation += PI/4
	elif energy_usage == 16.666:
		sky_rotation += PI/5
	#sky_change()


func sky_change():
	if $Discs/Sky.rotation != sky_rotation:
		$Discs/Sky.rotation += .01
		if $Discs/Sky.rotation > sky_rotation:
			$Discs/Sky.rotation = sky_rotation
####back button################################################################

func _on_Back_pressed():
	$audios/sfx/wheel_buttons.play()
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

		
		$audios/sfx/buttons.play()

	if imp_harv == 2:
		$"Discs/Buildings/plantation/02".show()
	elif imp_harv == 4:
		$"Discs/Buildings/plantation/03".show()

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
			
		capacity += 180
		$HUD/Barn_capacity.text = str("Barn Capacity: ", capacity)
		
		$audios/sfx/buttons.play()
	
	if imp_barn == 2:
		$"Discs/Buildings/barn/02".show()
	elif imp_barn == 4:
		$"Discs/Buildings/barn/03".show()
		

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
	
		$audios/sfx/buttons.play()
	
	if imp_scarecrow == 1:
		$"Discs/Buildings/plantation/scarecrow01".show()
	elif imp_scarecrow == 2:
		$"Discs/Buildings/plantation/scarecrow01".hide()
		$"Discs/Buildings/plantation/scarecrow02".show()
	elif imp_scarecrow == 3:
		$"Discs/Buildings/plantation/scarecrow02".hide()
		$"Discs/Buildings/plantation/scarecrow03".show()

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

		$audios/sfx/buttons.play()

	if imp_repair == 1:
		$"Dialog/crow_sprites/form1/01".hide()
		$"Dialog/crow_sprites/form2/01".hide()
		$"Dialog/crow_sprites/form3/01".hide()
		$"Dialog/crow_sprites/form1/02".show()
		$"Dialog/crow_sprites/form2/02".show()
		$"Dialog/crow_sprites/form3/02".show()
	elif imp_repair == 2:
		$"Dialog/crow_sprites/form1/02".hide()
		$"Dialog/crow_sprites/form2/02".hide()
		$"Dialog/crow_sprites/form3/02".hide()
		$"Dialog/crow_sprites/form1/03".show()
		$"Dialog/crow_sprites/form2/03".show()
		$"Dialog/crow_sprites/form3/03".show()
	elif imp_repair == 4:
		$"Dialog/crow_sprites/form1/03".hide()
		$"Dialog/crow_sprites/form2/03".hide()
		$"Dialog/crow_sprites/form3/03".hide()
		$"Dialog/crow_sprites/form1/04".show()
		$"Dialog/crow_sprites/form2/04".show()
		$"Dialog/crow_sprites/form3/04".show()


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
		
		$audios/sfx/buttons.play()
		
		if imp_energy == 1:
			energy_usage = 20
			$"Dialog/crow_sprites/form1".hide()
			$"Dialog/crow_sprites/form2".show()
		elif imp_energy == 2:
			energy_usage = 16.666
			$"Dialog/crow_sprites/form2".hide()
			$"Dialog/crow_sprites/form3".show()

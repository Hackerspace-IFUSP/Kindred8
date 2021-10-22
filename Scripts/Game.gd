extends Node

enum{main,barn,plantation,upgrades}
var location = main



func _ready():
	$Button_main/anim.play("event")
	$HUD/anim.play("event")
	$Dialog/anim.play("event")

func _process(delta):
	rotate()

	
	if Input.is_action_just_pressed("ui_down"):
		$Dialog/Textbox.hide()
		$Dialog/Crow.hide()
		$Dialog/Text.hide()





func rotate():
	
	$Discs/Sky.rotation += .005
	
	
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


func _on_Barn_pressed():
	location = barn
	$Button_main/anim_button_change.play("event")
	$Button_barn/anim_barn.play("event")

func _on_Plantation_pressed():
	location = plantation
	$Button_main/anim_button_change.play("event")
	$Button_plantation/anim_plantation.play("event")

func _on_Upgrades_pressed():
	location = upgrades
	$Button_main/anim_button_change.play("event")
	$Button_upgrades/anim_upgrades.play("event")

func _on_Back_pressed():
	location = main
	$Button_main/anim_button_change.play("event2")
	$Button_barn/anim_barn.play("event2")
	


extends Node




func _ready():
	$music.play()
	$anim.play("event")


func _on_Barn_pressed():
	#$next_day.play()
	$transition.play("event")
	yield($transition,"animation_finished")
	get_tree().change_scene("res://Maps/Game.tscn")

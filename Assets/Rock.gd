extends Node2D

#VARIABLES
@export var fall_speed: float = 3.5
var shouldFall = false

func _physics_process(delta):
	if(shouldFall):
		position.y += fall_speed

func _on_RockArea2D_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()
		print("HIT")

func _on_TriggerArea2D_body_entered(body):
	if body.name == "Player":
		print("ROCK TRIGGERED")
		$AudioStreamPlayer2D.play()
		shouldFall = true

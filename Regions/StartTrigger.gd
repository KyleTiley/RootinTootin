extends Area2D

signal start_timer

func _on_StartTrigger_body_entered(body):
	if body.name == "Player":
		emit_signal("start_timer")

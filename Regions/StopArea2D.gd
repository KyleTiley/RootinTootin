extends Area2D

signal stop_timer

func _on_StopTrigger_body_entered(body):
	if body.name == "Player":
		emit_signal("stop_timer")


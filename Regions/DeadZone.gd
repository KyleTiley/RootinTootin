extends Area2D

func _on_DeadZone_body_entered(body):
	print("DELETED")
	body.queue_free()

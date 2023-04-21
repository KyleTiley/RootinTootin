extends Node2D

signal root_collected()

# Triggers when beer area is entered by any object, fix to only work for character

func _on_RootBeerArea2D_body_entered(body):
	emit_signal("root_collected")
	queue_free()

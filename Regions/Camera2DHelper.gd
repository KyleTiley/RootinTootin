extends Camera2D

@onready var player = $"../Player"

func _physics_process(delta):
	position.y = player.position.y
	if position.y > -120:
		position.y = -120
	set_position(position)

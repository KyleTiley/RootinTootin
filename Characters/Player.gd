extends CharacterBody2D

#VARIABLES
@export var move_speed: float = 200.0
@export var jump_impulse: float = 700.0
@export var max_jumps: int = 2
@export var enemy_bounce_impulse: int = 400
@export var jump_damage: float = 1
var double_jumps = 0

#STATES
enum STATE { IDLE, RUN, JUMP, DOUBLE_JUMP }

#REFERENCES
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_tree = $AnimationTree
@onready var jump_hitbox = $JumpHitbox

#SIGNALS
signal change_state(new_state_string, new_state_id)

var velocity : Vector2

var current_state = STATE.IDLE : set = set_current_state
var jumps = 0

func _physics_process(delta):
	var input = get_player_input()
	adjust_flip_direction(input)

	velocity = Vector2(input.x*move_speed, min(velocity.y + GameSettings.gravity, GameSettings.terminal_velocity))

	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity = velocity

	set_anim_parameters()

	pick_next_state()

#setters
func set_current_state(new_state):
	match(new_state):
		STATE.JUMP: 
			jump()
		STATE.DOUBLE_JUMP:
			if double_jumps > 0:
				jump()
				animation_tree.set("parameters/double_jump/active", true)
				$AudioStreamPlayer.play()
				double_jumps -= 1

	current_state = new_state
	emit_signal("change_state", STATE.keys()[new_state], new_state)

func set_anim_parameters():
	animation_tree.set("parameters/x_sign/blend_position", sign(velocity.x))
	animation_tree.set("parameters/y_sign/blend_amount", sign(velocity.y))

func jump():
	velocity.y = -jump_impulse
	jumps += 1

func adjust_flip_direction(input : Vector2):
	if(sign(input.x) == 1):
		animated_sprite.flip_h = false
	elif(sign(input.x) == -1):
		animated_sprite.flip_h = true

# Uses Input to determine which direction the player is pressing down on for use in movement
func get_player_input():
	var input : Vector2

	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")

	input.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	return input

func pick_next_state():
	if(is_on_floor()):
		jumps = 0

		if(Input.is_action_just_pressed("jump")):
			self.current_state = STATE.JUMP
		elif(abs(velocity.x) > 0):
			self.current_state = STATE.RUN
		else:
			self.current_state = STATE.IDLE
	else:
		if(Input.is_action_just_pressed("jump") && jumps < max_jumps):
			self.current_state = STATE.DOUBLE_JUMP

func _on_JumpHitbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var enemy = area.owner

#	if(enemy is Enemy && enemy.can_be_hit):
#		if(jump_hitbox.global_position.y < area.global_position.y):
#			velocity.y = -enemy_bounce_impulse
#			enemy.get_hit(jump_damage)

func _on_RootBeer_root_collected():
	print("JUMP GRANTED")
	double_jumps += 1

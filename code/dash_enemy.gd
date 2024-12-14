extends CharacterBody2D

@onready var player = $"../../Player"
@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D

@onready var text = $TextParticle
@onready var text_anim = $TextParticle/AnimationPlayer
@onready var text_text = $TextParticle/LabelParent/Label

const SPEED = 190.0

var direction = 0
@export var trigger_range_x = 500
@export var trigger_range_y = 250

var start_pos = Vector2.ZERO

var triggered = false

func _ready():
	start_pos = global_position

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if abs(player.global_position.x - global_position.x) < trigger_range_x and abs(player.global_position.y - global_position.y) < trigger_range_y:
		if not triggered:
			text_text.text = Global.dialogues[1].pick_random()
			text.visible = true
			text_anim.play("talk")
			triggered = true
		if abs(player.global_position.x - global_position.x) > 30:
			if player.global_position.x < global_position.x:
				direction = -1
			else:
				direction = 1
			
	if direction == -1:
		sprite.flip_h = false
	if direction == 1:
		sprite.flip_h = true
	
	if direction != 0:
		velocity.x = direction * SPEED
		anim.play("wobble")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("RESET")

	move_and_slide()

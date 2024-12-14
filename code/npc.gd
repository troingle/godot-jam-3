extends Node2D

@export var flipped = false

@onready var player = $"../../Player"
@onready var sprite = $AnimatedSprite2D

@onready var text = $TextParticle
@onready var text_anim = $TextParticle/AnimationPlayer
@onready var text_text = $TextParticle/LabelParent/Label

var recruited = false
var saved = false

func _ready():
	if flipped:
		sprite.flip_h = true

func _process(delta: float) -> void:
	if global_position.distance_to(player.global_position) < 70 and Input.is_action_just_pressed("interact") and not recruited:
		player.recruits += 1
		modulate = "#86ff72"
		recruited = true
		$CPUParticles2D.emitting = true
		text_text.text = Global.dialogues[0].pick_random()
		text.visible = true
		text_anim.play("talk")
		
	if recruited:
		modulate = "#86ff72"
	else:
		modulate = "ffffff"

func derecruit():
	recruited = false
		

extends StaticBody2D

@export var req = 5

@onready var anim = $AnimationPlayer
@onready var player = $"../../../Player"

var opened = false

func _process(delta: float) -> void:
	if opened and position.y == 0:
		anim.play("open")
		
	if player.recruits >= req:
		opened = true
	else:
		opened = false
		anim.play("RESET")
		

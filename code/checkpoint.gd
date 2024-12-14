extends Node2D

@onready var player = $"../../Player"
@onready var sprite = $AnimatedSprite2D
@onready var root = $"../../"

var on = false

func _process(delta: float) -> void:
	if on:
		sprite.play("on")
	else:
		sprite.play("off")
		
	if player.global_position.distance_to(global_position) < 50:
		# play sound
		for i in get_tree().get_nodes_in_group("checkpoint"):
			on = false
		for n in get_tree().get_nodes_in_group("npc"):
			if n.recruited:
				n.saved = true
		on = true
		player.reset_point = sprite.global_position
	

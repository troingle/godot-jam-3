extends StaticBody2D

@onready var player = $"../../Player"

func _process(delta: float) -> void:
	if Input.is_action_pressed("down"):
		$CollisionShape2D.disabled = true
	elif player.position.y < position.y - 15:
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true

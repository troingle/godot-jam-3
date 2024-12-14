extends StaticBody2D

var dir_x = 0
var dir_y = 1

var speed = 470

func _process(delta: float) -> void:
	global_position.x += delta * speed * dir_x
	global_position.y += delta * speed * dir_y


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.reset_pos(false)
	elif body != self and !body.is_in_group("gun") and !body.is_in_group("platform"):
		queue_free()

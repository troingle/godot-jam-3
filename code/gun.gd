extends StaticBody2D

@onready var bullet_obj = load("res://scenes/bullet.tscn")

@export var left = false

func _ready():
	if left:
		$ShootTimer.wait_time = 1.7

func _on_shoot_timer_timeout() -> void:
	var bullet = bullet_obj.instantiate()
	bullet.global_position = global_position
	if left:
		bullet.dir_x = -1
		bullet.dir_y = 0
		bullet.rotation = 20.413
		bullet.global_position.x -= 32
		bullet.speed = 400
	else:
		bullet.global_position.y += 36
	$"../..".add_child(bullet)

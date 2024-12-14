extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var anim = $AnimationPlayer

@onready var death_anim = $CanvasLayer/DeathAnim
@onready var death_lock_timer = $DeathLockTimer

@onready var recruit_count_label = $CanvasLayer/Count

const SPEED = 310.0
const JUMP_VELOCITY = -580.0

var recruits = 9

var reset_point = Vector2.ZERO

var can_move = true

func _ready():
	$"../CanvasModulate".visible = true
	reset_point = global_position

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_pressed("jump") and is_on_floor() and can_move:
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	if direction and can_move:
		velocity.x = direction * SPEED
		sprite.play("walk")
		if direction > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		anim.play("wobble")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play("stand")
		anim.play("RESET")

	move_and_slide()
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("reset"):
		reset_pos(true)
		
	recruit_count_label.text = str(recruits)
		
func reset_pos(buttoned):
	for n in get_tree().get_nodes_in_group("npc"):
		if not n.saved and n.recruited:
			n.derecruit()
			recruits -= 1
	for n in get_tree().get_nodes_in_group("enemy"):
		n.direction = 0
		n.global_position = n.start_pos
		n.triggered = false
		
	global_position = reset_point
	if not buttoned:
		can_move = false
		death_anim.play("death_screen")
		death_lock_timer.start()

func _on_belter_timeout() -> void:
	$"../Belts".visible = !$"../Belts".visible
	$"../Belts2".visible = !$"../Belts2".visible

func _on_check_body_entered(body: Node2D) -> void:
	if body.name == "Water":
		reset_pos(false)
	if body.is_in_group("enemy"):
		reset_pos(false)

func _on_death_lock_timer_timeout() -> void:
	can_move = true

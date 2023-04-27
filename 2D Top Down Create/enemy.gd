extends Node

#rotation speed
@onready var rotate_speed = 10
#wait time between each bullets
@onready var shooter_wait_time = 0.3
#the amount of spawn points the rotation will have
@onready var spawn_point = 6
const radius = 50
const bullet_scene = preload("res://bullet.tscn")
@onready var shoot_timer = $ShootTimer
@onready var rotation = $Rotation

func randombull():
	var rng = RandomNumberGenerator.new()
	var mynum = rng.randi_range(1,3)
	if mynum == 1:
		rotate_speed = 0
		shooter_wait_time = 0.6
		spawn_point = 10
	elif mynum == 2:
		rotate_speed = 10
		shooter_wait_time = 0.3
		spawn_point = 6
	elif mynum == 3:
		rotate_speed = 60
		shooter_wait_time = 0.1
		spawn_point = 3
	mynum = 0

func _ready():
	randombull()
	_after_ready()

func _after_ready():
	var step = 2 * PI / spawn_point
	
	for i in range(spawn_point):
		var spawn_point_1 = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point_1.position = pos
		spawn_point_1.rotation = pos.angle()
		rotation.add_child(spawn_point_1)
		
	shoot_timer.wait_time = shooter_wait_time
	shoot_timer.start()

func _process(delta: float):
	var new_rotate = rotation.rotation_degrees + rotate_speed * delta
	rotation.rotation_degrees = fmod(new_rotate, 360)

func _on_shoot_timer_timeout():
	for s in rotation.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation

extends Node

#rotation speed
@export var rotate_speed = 10
#wait time between each bullets
@export var shooter_wait_time = 0.3
#the amount of spawn points the rotation will have
@export var spawn_point = 6
const radius = 50
const bullet_scene = preload("res://bullet.tscn")
@onready var shoot_timer = $ShootTimer
@onready var rotation = $Rotation

func _ready():
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

extends CharacterBody2D

const invincibility_duration = 1.5
@export var speed = 300
@onready var d_cooldown = $DashCooldown
@onready var blink = $Blink
@onready var hit = $Hit
@onready var coll_shape = $collider

func _ready():
	pass

func _physics_process(_delta):
	velocity = Vector2()
	
	if Input.is_action_pressed("down"):
		velocity.y += speed
	if Input.is_action_pressed("up"):
		velocity.y -= speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_just_pressed("right"):
		rotation_degrees = 90
	if Input.is_action_just_pressed("left"):
		rotation_degrees = -90
	if Input.is_action_just_pressed("up"):
		rotation_degrees = 0
	if Input.is_action_just_pressed("down"):
		rotation_degrees = 180
	move_and_slide()
	
	if Input.is_action_just_pressed("dash"):
		dash()

func dash():
	if d_cooldown.is_stopped():
		speed = 600
		$Timer.start()
		d_cooldown.start()

func _on_timer_timeout():
	speed = 300

func _on_hit_area_entered(area):
	if !hit.is_invincible:
		print("WORK PLEASE")
		blink.start_blinking(self, invincibility_duration)
		hit.start_invinc(invincibility_duration)

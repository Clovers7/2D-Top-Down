extends Area2D

const within_duration = 0.5
@onready var coll_shape = $CollisionShape2D

var is_invincible = false

func start_invinc(invincibility_duration):
	is_invincible = true
	#deferred means to check and wait for all the other physics calculation to be done to work
	coll_shape.set_deferred("disabled",true)
	await(get_tree().create_timer(invincibility_duration).timeout)
	coll_shape.set_deferred("disabled", false)
	is_invincible = false


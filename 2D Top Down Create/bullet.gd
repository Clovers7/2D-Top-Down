extends Node2D

const speed = 100

func _process(delta):
	position += transform.x * delta * speed
	

func _on_KillTimer_timeout():
	queue_free()

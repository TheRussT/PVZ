extends Node2D

var velocity_y = 0
var velocity_x = 0
var stop_point = 1080
var lerp_timer = 0
var lerp_x = 0
var lerp_y = 0
var lifetime = 15
var is_falling = true
var is_collected = false
# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = -50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (get_global_mouse_position().distance_to(position) <= 50 && !is_collected):
		is_collected = true
		lerp_x = position.x
		lerp_y = position.y
	if !is_collected:
		if is_falling:
			position.x += velocity_x * delta
			position.y += velocity_y * delta
			velocity_y += 50 * delta
			if velocity_y > 100:
				velocity_y = 100
			if position.y >= stop_point:
				position.y = stop_point
				velocity_x = 0
				velocity_y = 0
				is_falling = false
		else:
			lifetime -= delta
			if lifetime < 5 && lifetime - int(lifetime) < 0.5:
				modulate = Color("ffffff88")
			if lifetime <= 0:
				queue_free()
	else:
		position.x = lerp_x + lerp_timer * (50 - lerp_x)
		position.y = lerp_y + lerp_timer * (50 - lerp_y)
		lerp_timer += delta * 1.5
		if(lerp_timer > 1):
			get_node("/root/Level").update_sun(50)
			queue_free()


func _on_character_body_2d_input_event(viewport, event, shape_idx):
	pass
	#print("maybe something was pressed")
	#if (event.is_pressed()):
	#	print("maybe something was pressed pt. 2")
	#	if (get_global_mouse_position().distance_to(position) <= 50 && !is_collected):
	#		is_collected = true
	#		lerp_x = position.x
	#		lerp_y = position.y


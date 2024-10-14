extends Plant

var shoot_timer
var can_sun
var new_sun

func start_action():
	#$Stem/Throat_Pea.visible = false
	can_sun = true
	anim.play("Producing")
	action = action_timer
	cooldown = randf_range(10,15)
	cooldown_timer = cooldown

func do_action():
	if action < 1.12 && action > 1.04:
		$Stem/petals.visible = false
		$Stem/petals_lit.visible = true
	elif action < 0.3 && action > 0.2:
		$Stem/petals.visible = true
		$Stem/petals_lit.visible = false
		if can_sun:
			new_sun = load("res://scenes/interactables/sun.tscn").instantiate()
			get_node("/root/Level/Suns").add_child(new_sun, true)
			new_sun.position.x = position.x 
			new_sun.position.y = position.y - 75
			new_sun.velocity_y = randf_range(-100, -60)
			new_sun.velocity_x = randf_range(-30, 30)
			new_sun.stop_point = (row_num + 1) * 150 + 190
			can_sun = false

func initialize():
	zombies = get_node("/root/Level/Zombies/Column" + str(row_num))#node
	cooldown_timer = randf_range(2,4)
	health = 400
	action_timer = 2
	action = action_timer


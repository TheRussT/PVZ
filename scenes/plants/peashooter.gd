extends Plant

var shoot_timer
var can_shoot
var new_pea

func start_action():
	#$Stem/Throat_Pea.visible = false
	can_shoot = true
	anim.play("Shooting")
	action = action_timer
	cooldown = cooldown_timer

func do_action():
	if action < 0.7 && action > 0.42:
		$Stem/Throat_Pea.visible = true
	elif action < 0.38 && action > 0.2:
		$Stem/Throat_Pea.visible = true
	elif action < 0.12:
		if can_shoot:
			print("trying to shoot")
			new_pea = load("res://scenes/projectiles/pea.tscn").instantiate()
			$Projectiles.add_child(new_pea, true)
			new_pea.position.x = position.x + 64
			new_pea.position.y = position.y - 60
			new_pea.zombies = zombies
			can_shoot = false
	else:
		$Stem/Throat_Pea.visible = false

func initialize():
	zombies = get_node("/root/Level/Zombies/Column" + str(row_num))#node
	cooldown_timer = 2.75
	health = 400
	action_timer = 0.8
	action = action_timer

func can_act():
	if zombies.get_child_count() > 0:
		for z in zombies.get_children():
			if z.position.x + 1730 > position.x && z.is_active:
				return true
	return false

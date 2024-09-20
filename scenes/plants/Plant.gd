extends Node2D


class_name Plant
@onready var anim = $AnimationPlayer
var isactive = false
var idle = true
var row_num
var column_num
var zombies
var cooldown = 0
var cooldown_timer
var action = 0
var action_timer
var health


func _ready():
	anim.play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isactive:
		if idle:
			if cooldown <= 0:
				if can_act():
					idle = false
					cooldown = cooldown_timer
					start_action()
			else:
				cooldown -= delta
		else:
			if action < 0:
				action = action_timer
				idle = true
				cooldown = cooldown_timer
				#print("back to idle, cooldown ", cooldown)
				anim.play("Idle")
			else:
				do_action()
				action -= delta

func start_placement():
	modulate = Color("ffffffaa")
	
func stop_placement(column_no, row):
	modulate = Color("ffffffff")
	column_num = column_no
	row_num = row
	initialize()
	isactive = true

func can_act():
	return true

func do_action():
	pass

func start_action():
	pass

func damage(value):
	health -= value
	if health <= 0:
		queue_free()

func initialize():
	pass

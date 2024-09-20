extends Node2D


@onready var anim = $AnimationPlayer

func _ready():
	anim.play("Idle")
	print("made peashooter")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_placement():
	modulate = Color("ffffffaa")
	
func stop_placement():
	modulate = Color("ffffffff")

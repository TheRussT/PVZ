extends Node2D

var zombies
var speed
var damage = 30
# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 800
	print("loaded")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(position.x > 2000):
		print("despawned")
		queue_free()
	for z in zombies.get_children():
		if abs((1730 + z.position.x) - position.x) < 50:
			z.damage(damage)
			queue_free()
			print("hit! ", 1730 + z.position.x,  " and ", position.x)
	position.x += speed * delta
